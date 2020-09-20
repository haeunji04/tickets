package com.kh.tickets.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
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

import com.kh.tickets.member.model.service.MemberService;
import com.kh.tickets.member.model.vo.Member;



@Controller
@SessionAttributes(value = { "loginMember" })
public class MemberController {
	
	private Logger log = 
			LoggerFactory.getLogger(getClass());

	@Autowired
	private MemberService memberService;
	
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
	public String memberEnroll(Member member,
								RedirectAttributes redirectAttr) {
		
		String rawPassword = member.getPassword();
		String encryptPassword = bcryptPasswordEncoder.encode(rawPassword);
		
		member.setPassword(encryptPassword);
		
		log.debug("rawPassword = {}", rawPassword);
		log.debug("encryptPassword = {}", encryptPassword);
		log.debug("Member = {}", member);
		
		// 1. 로직 실행
		int result = memberService.memberEnroll(member);
		log.debug("result = {}", result);
		
		// 2. 사용자 알림
		redirectAttr.addFlashAttribute("msg", result > 0? "회원가입 성공!" : "회원가입 실패");
		
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
		  
		String location = "/";
		// 로그인 성공
		if(member != null && bcryptPasswordEncoder.matches(password, member.getPassword())) {
			// 세션처리
			model.addAttribute("loginMember", member);
		
			//세션에서 next값 가져오기
			String next = (String) session.getAttribute("next");
			location = next != null ? next : location;
			session.removeAttribute("next");
		}
		// 로그인 실패
		else {
			redirectAttr.addFlashAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
		}
		
		return "redirect:" + location;
	}
	
	@RequestMapping("/member/memberLogout.do")
	public String memberLogout(SessionStatus sessionStatus) {
		
		//@SessionAttribute를 통해 등록된 객체 무효화
		if(sessionStatus.isComplete() == false)
			sessionStatus.setComplete();
		
		return "redirect:/";
	}
	
	@RequestMapping("/member/memberList.do")
	public String memberList(Model model) {
		List<Member> list = memberService.selectMemberList();
		log.debug("list@controller = {}", list);
		
		model.addAttribute("list", list);
		
		return "member/memberList";
	}
	
	@RequestMapping(value = "/member/deleteMember.do",
			method = RequestMethod.POST)
	public String deleteMember(@RequestParam String memberId, RedirectAttributes redirectAttributes){
		int result = memberService.deleteMember(memberId);
		redirectAttributes.addFlashAttribute("msg", result>0 ? "회원 삭제성공" : "회원 삭제실패");
		return "redirect:/member/memberList.do";
	}
	
	@RequestMapping(value="/member/updatePasswordForm.do")
	public ModelAndView updatePasswordForm(ModelAndView mav) {
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
	
		@RequestMapping("/member/memberDetail.do")
		public String memberDetail(ModelAndView mav,
								   @ModelAttribute("loginMember") Member loginMember) {
			log.debug("loginMember = {}", loginMember);
			return "member/memberDetail";
		}
		
		@RequestMapping("/member/memberUpdate.do")
		public ModelAndView memberUpdate(ModelAndView mav,
								   		 Member member,
								   		HttpServletRequest request) {
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
			
			FlashMap flashMap = RequestContextUtils.getOutputFlashMap(request);
			flashMap.put("msg", msg);
			
			mav.setViewName("member/memberDetail");
			return mav;
		}
	
	
}
