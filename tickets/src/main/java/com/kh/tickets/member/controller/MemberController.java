package com.kh.tickets.member.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.kh.tickets.common.Utils;
import com.kh.tickets.member.model.service.MemberService;
import com.kh.tickets.member.model.vo.Auth;
import com.kh.tickets.member.model.vo.Member;
import com.kh.tickets.performance.model.service.PerformanceService;



@Controller
@SessionAttributes(value = { "loginMember" })
public class MemberController {
	
	private Logger log = 
			LoggerFactory.getLogger(getClass());

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private PerformanceService performanceService; 
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	
    @GetMapping("/member/checkIdDuplicate1.do")
    public ModelAndView checkIdDuplicate1(ModelAndView mav,
    									  @RequestParam("memberId") String memberId) {
    	// 1. 업무로직 : 중복체크
    	Member member = memberService.selectOneMember(memberId);
    	boolean isUsable = (member == null);	//member가 null이면 isUsable = true
    	
    	// 2. model에 속성등록
    	mav.addObject("isUsable", isUsable);
    	
    	// 3. viewName : jsonView빈 지정
    	mav.setViewName("jsonView");	// /WEB-INF/views/jsonView.jsp
    	
    	return mav;
    }
    
	@GetMapping("/checkIdDuplicate2.do")
	@ResponseBody
	public Map<String, Object> checkIdDuplicate2(@RequestParam("memberId") String memberId) {
		Member member = memberService.selectOneMember(memberId);
		boolean isUsable = (member == null);
		
		Map<String, Object> map = new HashMap<>();
		map.put("isUsable", isUsable);
		map.put("memberId", memberId);
		
		return map;
	}
	
	
	@RequestMapping("/member/memberEnrollForm.do")
	public String memberEnrollForm() {
		return "member/memberEnrollForm";
	}
	
	@RequestMapping(value="/member/memberEnroll.do",
					method=RequestMethod.POST)
	public String memberEnroll(Member member, Auth auth,
								RedirectAttributes redirectAttr) {
		
		String rawPassword = member.getPassword();
		String encryptPassword = bcryptPasswordEncoder.encode(rawPassword);
		
		String addrDe = member.getAddrDetail();
		log.debug("addrDe = {}", addrDe);
		
		member.setPassword(encryptPassword);
		
		log.debug("rawPassword = {}", rawPassword);
		log.debug("encryptPassword = {}", encryptPassword);
		log.debug("Member = {}", member);
		log.debug("Auth = {}", auth);
		
		// 1. 로직 실행
		int result = memberService.memberEnroll(member);
		log.debug("result = {}", result);
		
		int result2 = memberService.authEnroll(auth);
		
		int sumResult = result + result2; 
		
		// 2. 사용자 알림
		redirectAttr.addFlashAttribute("msg", sumResult > 1? "회원가입 성공!" : "회원가입 실패");
		
		return "redirect:/";
	}
	
	@RequestMapping(value="/member/memberLoginForm.do")
	public ModelAndView memberLoginForm(ModelAndView mav) {
		mav.setViewName("member/memberLoginForm");
		return mav;
	}
	
	@RequestMapping(value="/member/memberLogin.do",
					method=RequestMethod.POST)
	public String memberLogin(@RequestParam String memberId,
							  @RequestParam String password,
							  Model model,
							  RedirectAttributes redirectAttr,
							  HttpSession session) {
		log.debug("memberId = {} , password = {}", memberId, password);
		
		
		Member member = memberService.selectOneMember(memberId);
		log.debug("Member = {}", member);
		
		
//		//--------
//		List<MyRecentlyPerList> rList = performanceService.recentlyPerList(memberId);
//		log.debug("rList@controlle@@r = {}", rList);
//		
//		model.addAttribute("loginMember", member);			
//		model.addAttribute("rList", rList);
		  
		String location = "";
		// 로그인 성공
		if(member != null && bcryptPasswordEncoder.matches(password, member.getPassword())) {
			// 세션처리
			model.addAttribute("loginMember", member);			
//			model.addAttribute("memberId", memberId);			
//			model.addAttribute("rList", rList);
		
			//세션에서 next값 가져오기
			String next = (String) session.getAttribute("next");
			location = next != null ? next : location;
			session.removeAttribute("next");
			
		}
		// 로그인 실패
		else {
			model.addAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
		}			

		model.addAttribute("memberId", memberId);	
		return "redirect:/" + location;
	}
	
	//Security 관련
	@PostMapping("/member/memberLoginFailure.do")
	public String memberLoginFailure(RedirectAttributes redirectAttr) {
		redirectAttr.addFlashAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
		return "redirect:/member/memberLoginForm.do";
	}
	
	@RequestMapping("/member/memberLogout.do")
	public String memberLogout(SessionStatus sessionStatus) {
		
		//@SessionAttribute를 통해 등록된 객체 무효화
		if(sessionStatus.isComplete() == false)
			sessionStatus.setComplete();
		
		return "redirect:/";
	}
	
	@RequestMapping(value = "/member/memberWithdraw.do",
			method = RequestMethod.POST)
	public String memberWithdraw(@RequestParam String memberId, RedirectAttributes redirectAttributes,
								SessionStatus sessionStatus){
		//@SessionAttribute를 통해 등록된 객체 무효화
//		if(sessionStatus.isComplete() == false)
//			sessionStatus.setComplete();
		
		int result = memberService.deleteMember(memberId);
		redirectAttributes.addFlashAttribute("msg", result>0 ? "회원 탈퇴성공" : "회원 탈퇴실패");
		
		return "redirect:/";
	}
	
//	@RequestMapping("/member/memberList.do")
//	public String memberList(Model model) {
//		List<Member> list = memberService.selectMemberList();
//		log.debug("list@controller = {}", list);
//		
//		model.addAttribute("list", list);
//		
//		return "member/memberList";
//	}
	
	
	/**
	 * 페이징의 컨텐츠영역에 대한 기능구현을 
	 * mybatis에서 지원하는 rowbounds를 사용한다.
	 * - offset : 건너뛸 게시물수 (cPage - 1) * numPerPage
	 * 		- 1page : 1~10 (offset : 0)
	 * 		- 2page : 11~20 (offset : 10)
	 * 		- 3page : 21~30 (offset : 20)
	 * - limit : 한페이지에 표시될 게시물 수 (numPerPage)
	 * 
	 * @param mav
	 * @return
	 */
//	@RequestMapping("/member/memberList.do")
//	public String memberList(Model model,HttpServletRequest request,
//						 	@RequestParam(defaultValue = "1", 
//						 	value = "cPage") int cPage) {
//		
//		//1.사용자 입력값 
//		final int limit = 2;
//		int offset = (cPage - 1) * limit;
//		
//		List<Member> list = memberService.selectMemberList(limit, offset);
//		log.debug("list@controller = {}", list);
//		
//		//전체컨텐츠수 구하기
//		int totalContents = memberService.selectBoardTotalContents();
//		
//		String url = request.getRequestURI() + "?";
//		String pageBar = Utils.getPageBarHtml(cPage, limit, totalContents, url);
//		
//		
//		model.addAttribute("list", list);
//		model.addAttribute("totalContents", totalContents);
//		model.addAttribute("pageBar", pageBar);
//		
//		return "member/memberList";
//	}
	
	// -------------------------페이징 처리 수정----------------
	@GetMapping("/member/memberList")
	public ModelAndView memberList(ModelAndView mav,
								   HttpServletRequest request) {
		int numPerPage = 10;
		int cPage = 1;
		
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		} catch (NumberFormatException e) {
		}

		int start = (cPage-1) * numPerPage + 1;
		int end = cPage * numPerPage;
		
		Map<String, Object> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		
		List<Member> list = memberService.selectMemberList(map);
		log.debug("list = {}", list);
		
		String url = request.getRequestURI() + "?";
		
		int totalContents = memberService.selectBoardTotalContents();
		String pageBar = Utils.getPageBarHtml(cPage, numPerPage, totalContents, url);
		
		mav.addObject("list", list);
		mav.addObject("cPage", cPage);
		mav.addObject("pageBar", pageBar);
		mav.addObject("totalContents", totalContents);
		mav.setViewName("member/memberList");
		
		return mav;
	}
	
	@RequestMapping(value = "/member/deleteMember.do",
			method = RequestMethod.POST)
	public String deleteMember(@RequestParam String memberId, RedirectAttributes redirectAttributes){
		int result = memberService.deleteMember(memberId);
		redirectAttributes.addFlashAttribute("msg", result>0 ? "회원 삭제성공" : "회원 삭제실패");
		return "redirect:/member/memberList";
	}
	
	@RequestMapping(value="/member/updatePasswordForm.do")
	public ModelAndView updatePasswordForm(ModelAndView mav, @RequestParam("memberId") String memberId) {
		log.debug("memberId@@ = {}", memberId);
		mav.addObject("memberId", memberId);
		mav.setViewName("/member/updatePasswordForm");
		return mav;
	}
	
	 @RequestMapping(value = "/member/updatePassword.do",
				method = RequestMethod.POST)
	public String updatePassword(@RequestParam String memberId,
							   @RequestParam String password,
							   @RequestParam String newPassword,
							   RedirectAttributes redirectAttr){
		
		Member member = memberService.selectOneMember(memberId);
		log.debug("member@@ = {}", member);

		if(member != null && bcryptPasswordEncoder.matches(password, member.getPassword())) {
			member.setPassword(newPassword);
			String rawPassword = member.getPassword();
			String encryptPassword = bcryptPasswordEncoder.encode(rawPassword);
			member.setPassword(encryptPassword);
			
			int result = memberService.updatePassword(member);
			
			
			redirectAttr.addFlashAttribute("msg", result > 0? "비밀번호변경 성공!" : "비밀번호변경 실패");
			
			return "redirect:/" ;
		}
		else {
//			log.debug("기존비번이 틀렸습니다@@@@");
			redirectAttr.addFlashAttribute("msg", "기존 비밀번호가 일치하지 않습니다.");
			return "redirect:/member/updatePasswordForm.do";
		}			
	}
	 
	 
	
	 	//회원수정시도
		@GetMapping("/member/memberDetail.do")
		public ModelAndView memberDetail(ModelAndView mav,
								 @RequestParam("memberId") String memberId) {
			
			Member member = memberService.selectOneMember(memberId);
			log.debug("member = {}", member);
			mav.addObject("loginMember", member);
			mav.setViewName("member/memberDetail");
			return mav;
		}
	 
	 
	 	//security 관련
//	 	@RequestMapping("member/memberDetail.do")
//		public String memberDetail(Principal principal, Model model) {
//			log.debug("principal = {}", principal);
//			model.addAttribute("loginMember", principal);
//			
//			String userId = principal.getName();
//			log.debug("userId@@  = {}", userId );
//			
//			return "member/userDetail";
//		}
		//회원수정시도
		@RequestMapping("/member/memberUpdate.do")
		public ModelAndView memberUpdate(ModelAndView mav,
								   		 Member member, 
								   		HttpServletRequest request, RedirectAttributes redirectAttr) {
			log.debug("updateMember = {}", member);
			
			int result = memberService.updateMember(member);
			
			String msg = "";		
			if(result>0){
				msg = "회원 정보 수정 성공!";
				Member updateMember = memberService.selectOneMember(member.getMemberId());
				mav.addObject("loginMember", updateMember);
				
			}	
			else {
				msg = "회원정보 수정 실패";
			}
			

//			FlashMap flashMap = RequestContextUtils.getOutputFlashMap(request);
//			flashMap.put("msg", msg);
			
			mav.addObject("msg", msg);
			mav.setViewName("member/memberDetail");

			return mav;
		}
		@GetMapping("/member/memberBookingList.do")
		public ModelAndView memberBookingList(ModelAndView mav) {
			
			mav.setViewName("member/memberBookingList");
			return mav;
		}
		@GetMapping("/member/memberOneBooking.do")
		public ModelAndView memberOneBooking(ModelAndView mav) {
			
			mav.setViewName("member/memberOneBooking");
			return mav;
		}
	
		@RequestMapping("/member/customerService.do")
		public String customerService() {
			return "member/customerService";
		}
		
		@GetMapping("/member/adminMemberSearchList")
		public ModelAndView adminMemberSearchList(ModelAndView mav,
												  HttpServletRequest request,
												  @RequestParam("searchType") String searchType,
												  @RequestParam("keyword") String keyword) {
			log.debug("keyword = {}", keyword);
			log.debug("searchType = {}", searchType);

			int numPerPage = 10;
			int cPage = 1;
			
			try {
				cPage = Integer.parseInt(request.getParameter("cPage"));
			} catch (NumberFormatException e) {
				
			}
			
			int start = (cPage-1) * numPerPage + 1;
			int end = cPage * numPerPage;
			
			Map<String, Object> map = new HashMap<>();
			map.put("start", start);
			map.put("end", end);
			map.put("searchType", searchType);
			map.put("keyword", keyword);
			
			List<Member> list = memberService.searchMemberList(map);
			log.debug("list = {}", list);
			
			String url = request.getRequestURI() + "?searchType=" + searchType + "&keyword=" + keyword + "&";
			
			int totalContents = memberService.totalSearchMemberList(map);
			String pageBar = Utils.getPageBarHtml(cPage, numPerPage, totalContents, url);
			
			mav.addObject("list", list);
			mav.addObject("searchType", searchType);
			mav.addObject("cPage", cPage);
			mav.addObject("pageBar", pageBar);
			mav.addObject("keyword", keyword);
			mav.addObject("totalContents", totalContents);
			mav.setViewName("member/memberList");
			
			return mav;
		}
		
		@RequestMapping("/member/searchIdFrm")
		public String searchIdFrm() {
			return "member/memberSearchId";
		}
		
		@PostMapping("/member/findId.do")
		public ModelAndView findId(ModelAndView mav,
								   @RequestParam("memberName") String memberName,
								   @RequestParam("memberEmail") String memberEmail) {
		
			log.debug("memberName = {}", memberName);
			log.debug("memberEmail = {}", memberEmail);
			
			Map<String, Object> param = new HashMap<>();
			param.put("memberName", memberName);
			param.put("memberEmail", memberEmail);
			
			Member m = memberService.findId(param);
					
			if(m != null) {
		        char[] charArr = new char[m.getMemberId().length()];
		        
		        for(int i=0; i<charArr.length; i++){
		            charArr[i] = m.getMemberId().charAt(i);
		        }
		        
		        for(int i=2; i<charArr.length; i++){
		            charArr[i] = '*';
		        }

		        String encryptedId = new String(charArr);
		        log.debug("encryptedId = {}", encryptedId);
		        
		        String result = sendEmail(m, 1);
		        
		        mav.addObject("encryptedId", encryptedId);
		        mav.setViewName("member/memberIdResult");
			} else {
				mav.addObject("msg", "입력하신 정보와 일치하는 회원이 없습니다.");
				mav.setViewName("member/memberSearchId");
			}

			return mav;
		}
		
		@RequestMapping("/member/searchPwdFrm")
		public String searchPwdFrm() {
			return "member/memberSearchPwd";
		}
		
		@PostMapping("/member/findPwd.do")
		public String findPwd(HttpServletRequest request,
							  		RedirectAttributes redirectAttr,
							  		@RequestParam("memberId") String memberId,
									@RequestParam("memberName") String memberName,
									@RequestParam("memberEmail") String memberEmail) {
			
			Map<String, Object> param = new HashMap<>();
			
			param.put("memberId", memberId);
			param.put("memberName", memberName);
			param.put("memberEmail", memberEmail);
			
			Member m = memberService.findPwd(param);
			
			String loc = "";
			
			if(m != null) {
				//log.debug("Member : {}", m);
				
				//이메일 보내기
				String key = sendEmail(m, 2);
				log.debug("key = {}", key);
				
				HttpSession saveKeySession = request.getSession();
				saveKeySession.setAttribute("key", key);
				
				redirectAttr.addFlashAttribute("member", m);
				
				loc = "/member/findPwdResult.do";
			} else {
				redirectAttr.addFlashAttribute("msg", "입력하신 정보와 일치하는 회원이 없습니다.");
				loc = "/member/searchPwdFrm";
			}
			
			return "redirect:"+loc;
		}
		
		@RequestMapping("/member/findPwdResult.do")
		public String findPwdResult() {
			return "member/memberPwdResult";
		}
		
		
		// 인증번호 생성, 이메일 보내기
		public String sendEmail(Member m, int num) {
			// 인증코드
			String key = "";

			//mail server 설정
			String host = "smtp.gmail.com";
			String user = "ticket.ticats.a";
			String password = "ticats!a12";
			
			//메일 받을 주소
			String to_email = m.getEmail();
			
			//SMTP 서버 정보 설정
			Properties prop = new Properties();
			prop.put("mail.smtp.host", host);
			prop.put("mail.smtp.port", 465);
			prop.put("mail.smtp.auth", "true");
			prop.put("mail.smtp.ssl.enable", "true");
			
			Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(user, password);
				}
			});
			
			try {
				MimeMessage msg = new MimeMessage(session);
				msg.setFrom(new InternetAddress(user, "Ticats"));
				msg.addRecipient(Message.RecipientType.TO, new InternetAddress(to_email));
				
				String mailSubject = "";
				String mailMsg1 = "";
				String mailMsg2 = "";
				String mailMsg3 = "";
				
				// num == 1 : 아이디 메일 보내기
				if(num == 1) {
					mailSubject = "고객님의 아이디를 알려드립니다.";
					mailMsg1 = "아이디를 잊으셨나요?";
					mailMsg2 = "회원님의 아이디를 알려드립니다.";
					mailMsg3 = m.getMemberId();
					
				} else {
				// num == 2 : 비밀번호 인증번호 보내기
					
					//인증 번호 생성
					Random rnd = new Random();
					
					for(int i=0; i<6; i++) {
						
						String rndNum = Integer.toString(rnd.nextInt(10));
						key += rndNum;
					}
					log.debug("key = {}", key);
					
					mailSubject = "비밀번호 변경 인증번호 메일입니다.";
					mailMsg1 = "비밀번호를 잊으셨나요?";
					mailMsg2 = "아래의 인증번호를 입력해주세요.";
					mailMsg3 = key;
				}
				

				//메일 제목
				msg.setSubject("Ticats - "+mailSubject);
				
				//메일 내용
				msg.setHeader("content-type", "text/html; charset=utf-8");
				msg.setContent("<div style=\"background: #F7F8F9; margin: 0; padding: 15px; cursor: default; letter-spacing: -.03em; font-family: 'Apple SD Gothic Neo', Helvetica, arial, '나눔고딕', 'Nanum Gothic', '돋움', Dotum, Tahoma, Geneva, sans-serif;\">\r\n" + 
						"    <table cellspacing=\"0\" cellpadding=\"0\" style=\"max-width: 680px; width: 100%; margin: 0 auto; border-collapse: collapse;\">\r\n" + 
						"      <tbody><tr><td style=\"padding: 0 0 16px 0; vertical-align: top;\">\r\n" + 
						"            <span>티캣츠</span>          </td><td style=\"text-align: right; padding: 10px 0 0 0; vertical-align: top; color: #626d75;\">\r\n" + 
						"          </td></tr><tr><td colspan=\"2\" style=\"padding: 40px 10px; background: white; border: 1px solid #E5E8EB;\">\r\n" + 
						"            <div style=\"max-width: 490px; width: 100%; margin: 0 auto; font-size: 13px; color: #373a3c; line-height: 1.8em;\">\r\n" + 
						"                <h1 style=\"padding: 10px 0 35px 0; margin: 0 0 35px 0; font-size: 28px; font-weight: 600; color: #2b2f33; text-align: center; line-height: 1.4em; border-bottom: 1px solid #e5e8eb;\">\r\n" + 
						"    "+mailMsg1+"\r\n" + 
						"  </h1>\r\n" + 
						"  <p style=\"font-size: 13px; color: #373a3c; line-height: 1.8em; margin: 10px 0 0 0; padding: 0; text-align: center;\">\r\n" + 
						"    <strong style=\"font-size: 16px;\">"+m.getName()+"회원님, 안녕하세요!</strong><br>\r\n" + 
						"    "+mailMsg2+"\r\n" + 
						"  </p>\r\n" + 
						"  <ul style=\"background: #f8fafb; border: 1px solid #e5e8eb; text-align: center; padding: 20px 0 32px 0; margin: 20px 0;\">"+
						"<li style=\"margin: 12px 0 0 0; padding: 0; font-size: 18px; font-weight: 600; color: #373a3c; text-align: center; list-style: none;\">"+
						mailMsg3+"</li></ul>\r\n" + 
						"  <p style=\"font-size: 13px; color: #373a3c; line-height: 1.8em; margin: 10px 0 0 0; padding: 0; text-align: center;\">\r\n" + 
						"    <strong style=\"font-size: 16px;\">\r\n" + 
						"      항상 티캣츠를 사랑해주시는 고객님께 감사드리며,<br>\r\n" + 
						"      보다 나은 티캣츠가 되기 위해 최선을 다하겠습니다.\r\n" + 
						"    </strong>\r\n" + 
						"  </p>\r\n" + 
						"  <p style=\"font-size: 13px; color: #373a3c; line-height: 1.8em; margin: 10px 0 0 0; padding: 0; text-align: center;\">\r\n" + 
						"    <strong style=\"font-size: 16px; color: #1f8ee6;\">\r\n" + 
						"      티캣츠 드림 <img src=\"https://store.ridicdn.net/books/dist/images/dm_template/global/smile.png\" alt=\":-)\" style=\"border: none; width: 16px; vertical-align: top; margin-top: 2px;\">\r\n" + 
						"    </strong>\r\n" + 
						"  </p>\r\n" + 
						"            </div>\r\n" + 
						"          </td></tr><tr><td colspan=\"2\" style=\"text-align: left; padding: 29px 0 50px 0;\">\r\n" + 
						"            <p style=\"padding: 14px 0 0; margin: 0; line-height: 1.8em; color: #808991; font-size: 11px;\">\r\n" + 
						"              서울시 강남구 역삼동 702-28 어반벤치빌딩 10층(테헤란로 325)<br>\r\n" + 
						"              리디(주) 대표 배기식 사업자등록번호 120-87-27435 통신판매업신고 제 2009-서울강남 35-02139호 | <a href=\"https://email.ridibooks.com/c/eJxVjUsOgyAUAE8jO8njI-KChSblGg3yiS9FMUra65d012RWs5gJxoFcNUHDgQMDmJgeFABlVD9gEkzCsoAFa4dOwoUB11JeN_VlJ5vxbtTRS-WdEk5FLtdxSCxJH5jQfowkm63W8-7E3HHb2GI-6V-lSXKZsN-f_JRtcbh3vH75ahIeocfQx91h7pvHhN5VLMcXlVc4hQ\" target=\"_blank\" style=\"display: inline-block; text-decoration: none; color: inherit;\" rel=\"noreferrer noopener\">고객센터</a>\r\n" + 
						"            </p>\r\n" + 
						"            <p style=\"padding: 8px 0 0; margin: 0; color: #808991; font-size: 14px; font-family: Tahoma, helvetica; \">Ticats Corp.</p>\r\n" + 
						"          </td></tr></tbody>\r\n" + 
						"    </table>\r\n" + 
						"  </div>", "text/html;charset=euc-kr");

				Transport.send(msg);
				log.debug("이메일 전송 완료!");
				
			} catch(Exception e) {
				e.printStackTrace();
			}
			
			return key;
		}
		
		
		@PostMapping("/member/updatePwd.do")
		public ModelAndView updatePwd(@RequestParam("memberId") String memberId,
									  @RequestParam("password") String password,
									  ModelAndView mav) {

			String encryptPassword = bcryptPasswordEncoder.encode(password);
			log.debug("encryptPassword = {}", encryptPassword);

			Map<String, Object> param = new HashMap<>();
			param.put("memberId", memberId);
			param.put("password", encryptPassword);
			
			int result = memberService.updatePwd(param);
			log.debug("result = {}", result);
			
			if(result>0) {
				mav.addObject("msg", "비밀번호가 변경되었습니다.");
				mav.setViewName("../../index");
			} else {
				mav.addObject("msg", "비밀번호 변경에 실패했습니다.");
				mav.setViewName("member/memberSearchPwd");
			}
			
			return mav;
		}
		
		
		
}
