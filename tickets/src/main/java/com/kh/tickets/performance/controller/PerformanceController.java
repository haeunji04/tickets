package com.kh.tickets.performance.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.tickets.boardComment.model.service.BoardCommentService;
import com.kh.tickets.boardComment.model.vo.BoardComment;
import com.kh.tickets.boardComment.model.vo.ReviewComment;
import com.kh.tickets.common.Utils;
import com.kh.tickets.member.model.service.MemberService;
import com.kh.tickets.member.model.vo.Member;
import com.kh.tickets.performance.model.service.PerformanceService;
import com.kh.tickets.performance.model.vo.CommentPerList;
import com.kh.tickets.performance.model.vo.MyRecentlyPerList;
import com.kh.tickets.performance.model.vo.MyWishList;
import com.kh.tickets.performance.model.vo.PerJoin;
import com.kh.tickets.performance.model.vo.Performance;
import com.kh.tickets.performance.model.vo.PerformanceHall;
import com.kh.tickets.performance.model.vo.RecentlyPerList;
import com.kh.tickets.performance.model.vo.SchDate;
import com.kh.tickets.performance.model.vo.Schedule;
import com.kh.tickets.performance.model.vo.Selected;
import com.kh.tickets.performance.model.vo.WishList;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@SessionAttributes(value = { "loginMember" })
public class PerformanceController {
	
	@Autowired
	private PerformanceService performanceService; 
	@Autowired
	private MemberService memberService; 
	
	@Autowired
	private BoardCommentService boardCommentService;
	
//	@Autowired
//	private WishList wishList;
	

	@GetMapping("/list")
	public ModelAndView categoryListView(ModelAndView mav, 
			/* @RequestParam(value="Principal", required=false) */ Principal principal,
//										@RequestParam(value="memberId", required=false) String memberId,
										@RequestParam("category") String category, 
										HttpServletRequest request
							  			) {
		log.debug("category = {}", category);
		log.debug("principal = {}", principal);
		
		String memberId = null;
		if(principal != null) {
			memberId = principal.getName();
			
		}
		log.debug("memberId@@  = {}", memberId );
		
		List<MyRecentlyPerList> rList = performanceService.recentlyPerList(memberId);
		log.debug("rList@homecontroller## = {}", rList);		
		
		//1.사용자 입력값 
//		final int limit = 10;
//		int offset = (cPage - 1) * limit;
		
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
		map.put("category", category);
		
//		List<PerJoin> list = performanceService.categoryListView(category);
//		List<PerJoin> list = performanceService.categoryListView(category, limit, offset);
		List<PerJoin> list = performanceService.categoryListView(map);
		
		String categoryName = performanceService.getCategoryName(category); 
		
		log.debug("list = {}", list);
		
		//전체컨텐츠수 구하기
		int totalContents = performanceService.selectCategoryListTotalContents(category);
				
		String url = request.getRequestURI() + "?category="+category+"&";
		String pageBar = Utils.getPageBarHtml(cPage, numPerPage, totalContents, url);
		
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy.MM.dd");
		mav.addObject("dateformat", dateformat);		
		mav.addObject("list", list);
		mav.addObject("categoryName", categoryName);
		mav.addObject("totalContents", totalContents);
		mav.addObject("pageBar", pageBar);
		mav.addObject("rList", rList);
		mav.setViewName("/performance/performanceCategoryView");
		return mav;
	}
	
	@GetMapping("/search")
	public ModelAndView searchView(ModelAndView mav,
								   @RequestParam("keyword") String keyword) {
		log.debug("keyword = {}", keyword);
		
		List<PerJoin> perList = performanceService.searchPerformance(keyword);
		List<PerformanceHall> hallList = performanceService.searchHallName(keyword);
		
		log.debug("perList = {}", perList);
		log.debug("hallList = {}", hallList);
		
		mav.addObject("perList", perList);
		mav.addObject("hallList", hallList);
		mav.addObject("keyword", keyword);
		mav.setViewName("/performance/performanceSearchResult");
		return mav;
	}
	
	@GetMapping("/performance/performanceRegisterForm.do")
	public ModelAndView performaceRegisterForm(ModelAndView mav) {
		mav.setViewName("/performance/performanceRegisterForm");
		return mav;
	}	

	
	@PostMapping("/performance/performanceRegister.do")
	public ModelAndView performanceRegister(Performance performance,
			  						  @RequestParam(value="perImgFile",required=false) MultipartFile[] perImgFiles,
			  						  @RequestParam(value="detailImgFile",required=false) MultipartFile[] detailImgFiles,
									  HttpServletRequest request,
									  ModelAndView mav) {
		
		String theaterNo = request.getParameter("searchHallNo");	
		performance.setTheaterNo(theaterNo);	
		
		if(performance.getAloneSale() == null) {
			performance.setAloneSale("N");
		}
		
		String saveDirectory = request.getServletContext()
				  .getRealPath("/resources/upload/performance");
		
		for(MultipartFile f : perImgFiles) {
			
			if(!f.isEmpty() && f.getSize() != 0) {
				//1. 파일명 생성
				String renamedFileName = Utils.getRenamedFileName(f.getOriginalFilename());
				
				//2. 메모리의 파일 -> 서버경로상의 파일 
				File newFile = new File(saveDirectory, renamedFileName);
				try {
					f.transferTo(newFile);
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
				
				performance.setPerImgOriginalFileName(f.getOriginalFilename());
				performance.setPerImgRenamedFileName(renamedFileName);
			}			
		}	
		
		for(MultipartFile f : detailImgFiles) {
			
			if(!f.isEmpty() && f.getSize() != 0) {
				//1. 파일명 생성
				String renamedFileName = Utils.getRenamedFileName(f.getOriginalFilename());
				
				//2. 메모리의 파일 -> 서버경로상의 파일 
				File newFile = new File(saveDirectory, renamedFileName);
				try {
					f.transferTo(newFile);
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
				
				performance.setDetailImgOriginalFileName(f.getOriginalFilename());
				performance.setDetailImgRenamedFileName(renamedFileName);
			}			
		}	
		
		log.debug("performance@@1 = {}", performance);
		
		try {
			int result = performanceService.performanceRegister(performance);
			mav.addObject("msg", "공연등륵 신청 성공!");
		} catch (Exception e) {
			log.error("공연등륵 신청 오류", e);
//			redirectAttr.addFlashAttribute("msg", "공연등륵 신청 실패!");
			
			//예외발생을 spring container에게 전달 : 지정한  예외페이지로 응답처리
			throw e;
		}	
		
		int perNo = performanceService.getPerNo(performance.getPerTitle());
		
		if(performance.getCategoryCode().equals("C5")) {
			mav.setViewName("performance/performanceRegisterEnd");
		} else {
			mav.setViewName("performance/performanceDateRegisterForm");
		}
		
		
		mav.addObject("perNo", perNo);
		return mav;
	}
	
	@ResponseBody
	@PostMapping("/performance/dateRegister")
	public Map<String, Object> performanceDate(@RequestBody Map<String, Object> param) {
		
		String schedule = param.get("date")+" "+param.get("hour")+":"+param.get("min")+":00";
		log.debug("schedule = {}", schedule);
		log.debug("param = {}", param);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date parseDate = null;
		String msg = "일정등록 성공";
		try {
			parseDate = sdf.parse(schedule);
			log.debug("parseDate = {}", parseDate);
			param.put("parseDate", parseDate);
			int result = performanceService.insertSchedule(param);
			
		} catch (Exception e) {
			log.error("일정 등록 오류!!!!", e);
			msg = "일정등록 실패";
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("msg", msg);

		return map;
	}
	
	@RequestMapping("/performance/performanceRegisterEnd")
	public String performanceRegisterEnd() {
		return "performance/performanceRegisterEnd";
	}
	
	
	@RequestMapping("/performance/performanceList.do")
	public String performanceList(Model model) {
		List<Performance> list = performanceService.selectPerformanceList();
		log.debug("list@controller = {}", list);
		
		model.addAttribute("list", list);
		
		return "performance/performanceList";
	}
	
	@GetMapping("/performance/performanceInfoView.do")
	public ModelAndView performanceInfoView(ModelAndView mav) {
		mav.setViewName("/performance/performanceInfoView");
		return mav;
	}
	
	@RequestMapping("/performance/adminApprovalPerList.do")
	public String adminApprovalPerList(Model model) {
		List<Performance> list = performanceService.adminApprovalPerList();
		log.debug("list@controller = {}", list);
		
		model.addAttribute("list", list);
		
		return "performance/adminApprovalPerList";
	}
	
	@PostMapping("/performance/approvePerRegister.do")
	public String approvePerRegister(@RequestParam int perNo, RedirectAttributes redirectAttributes){
		int result = performanceService.approvePerRegister(perNo);
		redirectAttributes.addFlashAttribute("msg", result>0 ? "공연 승인성공" : "공연 승인실패");
		return "redirect:/performance/adminApprovalPerList.do";
	}
	

//	@GetMapping("/company/companyPerList.do")
//	public String companyPerList(Model model, @ModelAttribute("loginMember") Member loginMember) {
//		
//		String memberId = loginMember.getMemberId();
//		log.debug("memberId@@ = {}", memberId);
//		List<Performance> list = performanceService.companyPerList(memberId);
//		log.debug("list@controller = {}", list);
//		
//		model.addAttribute("list", list);
//		
//		return "/company/companyPerList";
//	}

	@RequestMapping("/searchPerformanceHall.do")
	public ModelAndView searchPerformanceHall(ModelAndView mav) {
		mav.setViewName("/performance/searchPerformanceHall");
		return mav;
	}
	
	@GetMapping("/searchHall/{keyword}")
	@ResponseBody
	public List<PerformanceHall> searchHallName(@PathVariable("keyword") String keyword) {
		log.debug("keyword", keyword);
		
		List<PerformanceHall> list = performanceService.searchHallName(keyword);
		log.debug("list = {}", list);
		
		return list;
	}
	

	
	@GetMapping("/company/companyPerList.do")
	public ModelAndView companyPerList(ModelAndView mav,
										Principal principal) {
		log.debug("Principal = {}", principal);		
		String memberId = principal.getName();
		log.debug("memberId@@ = {}", memberId);
		List<Performance> list = performanceService.companyPerList(memberId);
		//log.debug("list@controller = {}", list);
		
		
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy.MM.dd");
		mav.addObject("dateformat", dateformat);
		mav.addObject("list", list);
		mav.setViewName("/company/companyPerList");
		return mav;
	}
	
	@PostMapping("/company/perUpdateForm.do")
	public ModelAndView perUpdateForm(ModelAndView mav,
			   						 @RequestParam int perNo, RedirectAttributes redirectAttributes) {		
		
		PerJoin performance = performanceService.selectOnePerJoin(perNo);
//		String aloneSale = performance.getAloneSale();
//		log.debug("aloneSale@@ = {}", aloneSale);
		log.debug("aloneSale@@ = {}", performance.getAloneSale());
		log.debug("perRating@@ = {}", performance.getPerRating());
		
		mav.addObject("performance", performance);
		mav.setViewName("/company/perUpdateForm");
		return mav;
	}
	
	@PostMapping("/company/perUpdate.do")
	public ModelAndView perUpdate(Performance performance, 
			 				@RequestParam(value="perImgFile",required=false) MultipartFile[] perImgFiles,
			 				@RequestParam(value="detailImgFile",required=false) MultipartFile[] detailImgFiles,
			 				@RequestParam("oldPerImgOriginalFileName") String oldPerImgOriginalFileName,
			 				@RequestParam("oldDetailImgOriginalFileName") String oldDetailImgOriginalFileName,
			 				@RequestParam("oldPerImgRenamedFileName") String oldPerImgRenamedFileName,
			 				@RequestParam("oldDetailImgRenamedFileName") String oldDetailImgRenamedFileName,
			 				HttpServletRequest request,
			 				ModelAndView mav){
		
		log.debug("aloneSale@@ = {}", performance.getAloneSale());
		
		if(performance.getAloneSale() == null) {
			performance.setAloneSale("N");
		}
		
		String saveDirectory = request.getServletContext()
				  .getRealPath("/resources/upload/performance");
		
		log.debug("performanceUpdate = {}", performance);
		
		// 기존 첨부 파일이 있는 경우 처리
		//if(!"".equals(oldPerImgOriginalFileName)) {
			//기존 첨부파일이 있고, 수정에서 새로 업로드하지 않은 경우
			for(MultipartFile mf : perImgFiles) {
			if(mf.isEmpty()==true) {
				performance.setPerImgOriginalFileName(oldPerImgOriginalFileName);
				performance.setPerImgRenamedFileName(oldPerImgRenamedFileName);
			} else {
					//기존 첨부파일도 있고, 수정에서 새로 업로드한 파일이 있는 경우
				//기존 파일 삭제
				File f = new File(saveDirectory, oldPerImgRenamedFileName);
				f.delete();
				System.out.println("[ " + oldPerImgRenamedFileName + " ] 파일 삭제!");
				
					if(mf.isEmpty()==false && mf.getSize() != 0) {
						//1. 파일명 생성
						String renamedFileName = Utils.getRenamedFileName(mf.getOriginalFilename());
						
						//2. 메모리의 파일 -> 서버경로상의 파일 
						File newFile = new File(saveDirectory, renamedFileName);
						try {
							mf.transferTo(newFile);
						} catch (IllegalStateException | IOException e) {
							e.printStackTrace();
						}
						
						log.debug("mf.getOriginalFilename()={}",mf.getOriginalFilename());
						performance.setPerImgOriginalFileName(mf.getOriginalFilename());
						performance.setPerImgRenamedFileName(renamedFileName);
					}			
				}	
			}
	//	}
		
		
		for(MultipartFile f : detailImgFiles) {
			if(f.isEmpty()==true) {
				performance.setDetailImgOriginalFileName(oldDetailImgOriginalFileName);
				performance.setDetailImgRenamedFileName(oldDetailImgRenamedFileName);
			}else {
				
				//기존 파일 삭제
				File fi = new File(saveDirectory, oldDetailImgOriginalFileName);
				fi.delete();
				System.out.println("[ " + oldDetailImgRenamedFileName + " ] 파일 삭제!");
				
					if(!f.isEmpty() && f.getSize() != 0) {
						//1. 파일명 생성
						String renamedFileName = Utils.getRenamedFileName(f.getOriginalFilename());
						
						//2. 메모리의 파일 -> 서버경로상의 파일 
						File newFile = new File(saveDirectory, renamedFileName);
						try {
							f.transferTo(newFile);
						} catch (IllegalStateException | IOException e) {
							e.printStackTrace();
						}
					log.debug("f.getOriginalFilename()={}",f.getOriginalFilename());
					log.debug("f.getOriginalFilename()={}",renamedFileName);
					performance.setDetailImgOriginalFileName(f.getOriginalFilename());
					performance.setDetailImgRenamedFileName(renamedFileName);
					}
						
			}	
		}
		int result = performanceService.perUpdate(performance);
		
		mav.addObject("msg", result>0 ? "공연정보 수정성공" : "공연정보 수정실패");
		
		mav.setViewName("redirect:/company/companyPerList.do");
		
		return mav;
	}
		
	@PostMapping("/company/perDateUpdate.do")
	public ModelAndView perDateUpdate(ModelAndView mav,
									  @RequestParam int perNo){
		log.debug("perNo = {}", perNo);
		
		List<Schedule> list = performanceService.selectPerSchedule(perNo);
		log.debug("List = {}", list);
		
		List<SchDate> schList = new ArrayList<>();
		
		if(list != null) {
			for(Schedule sch: list) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String schedule = sdf.format(sch.getSchDateTime());

				int schNo = sch.getSchNo();
				String date = schedule.substring(0, 11);
				String hour = schedule.substring(11, 13);
				String min = schedule.substring(14, 16);
				
				SchDate sd = new SchDate(schNo, date, hour, min);
				log.debug("SchDate = {}", sd);
				
				schList.add(sd);
			}
		}
		
		log.debug("schList = {}", schList);
		
		mav.addObject("schList", schList);
		mav.addObject("perNo", perNo);
		mav.setViewName("company/perDateUpdateForm");
		
		return mav;
	}	
	
	@RequestMapping("/company/perDateDelete")
	public ModelAndView deleteSchForm(ModelAndView mav,
									  @RequestParam int perNo) {
		log.debug("perNo = {}", perNo);
		
		List<Schedule> list = performanceService.selectPerSchedule(perNo);
		log.debug("List = {}", list);
		
		List<SchDate> schList = new ArrayList<>();
		
		if(list != null) {
			for(Schedule sch: list) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String schedule = sdf.format(sch.getSchDateTime());

				int schNo = sch.getSchNo();
				String date = schedule.substring(0, 11);
				String hour = schedule.substring(11, 13);
				String min = schedule.substring(14, 16);
				
				SchDate sd = new SchDate(schNo, date, hour, min);
				log.debug("SchDate = {}", sd);
				
				schList.add(sd);
			}
		}
		
		log.debug("schList = {}", schList);
		
		mav.addObject("perNo", perNo);
		mav.addObject("schList", schList);
		mav.setViewName("company/perDateDeleteForm");
		return mav;
	}
	
	@ResponseBody
	@PostMapping("/company/deleteDate.do")
	public String deleteDate(@RequestParam int schNo) {
		log.debug("schNo = {}", schNo);
		int result = performanceService.deleteDate(schNo);

		String msg = result > 0 ? "일정 삭제 완료" : "일정 삭제 실패";
		log.error(msg);
		
		return msg;
	}
	
	
	@RequestMapping("/company/perUpdateEnd")
	public String perUpdateEnd() {
		return "company/perUpdateEnd";
	}
	
	@PostMapping("/company/perDelete.do")
	public String perDelete(@RequestParam int perNo, RedirectAttributes redirectAttributes){
		int result = performanceService.perDelete(perNo);
		redirectAttributes.addFlashAttribute("msg", result>0 ? "공연 삭제성공" : "공연 삭제실패");		
//		redirectAttributes.addFlashAttribute("perNo", perNo);	
		return "redirect:/company/companyPerList.do";
	}
	
	
	@GetMapping("/performance/performanceInfoView2.do")
	public ModelAndView performanceInfoView2(ModelAndView mav, @RequestParam int perNo,
											Principal principal) {
		
		log.debug("perNo@@ = {}", perNo);
		PerJoin performance = performanceService.selectOnePerJoin(perNo);
		//log.debug("loginMember={}", principal.getName());
		if(principal != null) {
			String memberId = principal.getName();
			
		log.debug("memberId@@ = {}", memberId);
		
		//공연상세페이지에 들어갈 공연객체
		//찜하기 여부 확인할 찜 list				
		List<MyWishList> list = performanceService.wishListView(memberId);
		log.debug("list@controller = {}", list);
		
		Member member = memberService.selectOneMember(memberId);
		log.debug("member = {}", member);
		mav.addObject("loginMember", member);
		
		mav.addObject("list", list);		
		mav.addObject("memberId", memberId);
		//내 최근공연목록 list. for문과 if절에서 이미 최근목록에 있을시 이전거 지우고, 다시 최신날짜로 insert
		List<MyRecentlyPerList> rrList = performanceService.recentlyPerList(memberId);
		MyRecentlyPerList[] arr = rrList.toArray(new MyRecentlyPerList[rrList.size()]);
		
		
	    for(int i=0; i<arr.length; i++){
	    	if(perNo==(arr[i].getPerNo())){
	    		
	    		RecentlyPerList recentlyPerList2 = new RecentlyPerList();
	    		recentlyPerList2.setMemberId(arr[i].getMemberId());
	    		recentlyPerList2.setPerNo(arr[i].getPerNo());
	    		
	    		int result = performanceService.recentlyPerListDelete(recentlyPerList2);
	    		log.debug("recentInsert@controller## = {}", result);
	    	}
	    	
	    }
	    
	    RecentlyPerList recentlyPerList = new RecentlyPerList();
		recentlyPerList.setMemberId(memberId);
		recentlyPerList.setPerNo(perNo);
		
		
		int result = performanceService.recentlyPerListInsert(recentlyPerList);		
		log.debug("recentlyPerListInsert@controller = {}", result);
		
		List<MyRecentlyPerList> rList = performanceService.recentlyPerList(memberId);
		log.debug("list@controller = {}", rList);
		mav.addObject("rList", rList);	
		}
		
		
		List<BoardComment> commentList = boardCommentService.selectCommentList(perNo);
		int commntListSize = commentList.size();
		
		log.debug("commentList@controller@@ = {}", commentList);
		log.debug("commntListSize@@ = {}", commntListSize);
		
		List<ReviewComment> reviewList = boardCommentService.selectReviewList(perNo);
		
		log.debug("reviewList = {}", reviewList);
		
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy.MM.dd");
		
		mav.addObject("reviewList", reviewList);
		mav.addObject("dateformat", dateformat);
		mav.addObject("performance", performance);		
		mav.addObject("commentList", commentList);		
		mav.addObject("commntListSize", commntListSize);		
//		mav.addObject("loginMember", loginMember);		
		mav.setViewName("/performance/performanceInfoView2");
		return mav;
	}
	
	
	@GetMapping("/performance/selectSeat.do")
	public ModelAndView selectSeat(ModelAndView mav,
								   @RequestParam int schNo,
								   @RequestParam int perNo,
								   @RequestParam String memberId,
								   HttpServletRequest request) {
		PerJoin performance = performanceService.selectOnePerformance(perNo);	
		int theaterNo = performanceService.selectScheduleHall(schNo);
		PerformanceHall performanceHall = performanceService.selectOneTheater(theaterNo);
		//List<Seat> seatList = performanceService.selectSeatList(theaterNo);
		int seatLength = performanceService.seatLength(schNo);
		List<Selected> selectedList = performanceService.selectSelectedList(schNo);
		log.debug("selectedList@={}",selectedList);
		request.setAttribute("selectedList", selectedList);
		mav.addObject("selectedList", selectedList);
		mav.addObject("seatLength", seatLength);
		//mav.addObject("seatList", seatList);
		mav.addObject("performanceHall", performanceHall);
		mav.addObject("performance", performance);
		mav.addObject("memberId", memberId);
		log.debug("memberId={}",memberId);
		mav.addObject("schNo", schNo);
		mav.setViewName("/performance/selectSeat2");
		return mav;
	}
	
	@PostMapping("/performance/salePerformance.do")
	public ModelAndView salePerformance(ModelAndView mav,
										@RequestParam int[] seatNo,
										@RequestParam String[] seatName,
										@RequestParam int schNo,
										@RequestParam String memberId) {
		log.debug("seatNo={}",seatNo);
		int total=0;
		for(int i=0;i<seatNo.length;i++) {
			total += performanceService.seatPrice(seatNo[i]);
			
		}
		mav.addObject("total", total);
		mav.addObject("schNo", schNo);
		mav.addObject("seatNo", seatNo);
		mav.addObject("seatNoLength",seatNo.length);
		mav.addObject("seatName", seatName);
		mav.addObject("memberId", memberId);
		mav.setViewName("performance/salePerformance");
		return mav;
	}
	
	@PostMapping("/performance/paySelect.do")
	public ModelAndView paySelect(ModelAndView mav,
								  @RequestParam int[] seatNo,
								  @RequestParam String[] seatName,
								  @RequestParam int schNo,
								  @RequestParam String memberId,
								  @RequestParam int total,
								  @RequestParam int originTotal,
								  @RequestParam int sale) {
		
		
		int perNo = performanceService.selectOneSchedule(schNo);
		PerJoin performance = performanceService.selectOnePerformance(perNo);
		Member member = memberService.selectOneMember(memberId);
		mav.addObject("member", member);
		mav.addObject("performance", performance);
		mav.addObject("total", total);
		mav.addObject("originTotal", originTotal);
		mav.addObject("sale", sale);
		mav.addObject("schNo", schNo);
		mav.addObject("seatNo", seatNo);
		mav.addObject("seatNoLength",seatNo.length);
		mav.addObject("seatName", seatName);
		mav.addObject("memberId", memberId);
		mav.setViewName("performance/paySelect");
		return mav;
	}
	
	@PostMapping("/performance/payComplete.do")
	public ModelAndView payComplete(ModelAndView mav) {
		
		mav.setViewName("performance/payComplete");
		return mav;
	}
	
	//요거 질문: 아래 똑같은데 ModelAndView는 됬는데 Model은 왜 perNo를 못읽고 화면을 다시 못띄우는지? sql까진 wishlist 정상 들어감.
//	@PostMapping("/performance/wishListInsert.do")
//	public String wishListInsert(@RequestParam int perNo, RedirectAttributes redirectAttributes,
//								 @ModelAttribute("loginMember") Member loginMember, Model model){
//		
//		WishList wishList = new WishList();
//		wishList.setMemberId(loginMember.getMemberId());
//		wishList.setPerNo(perNo);		
//		
//		int result = performanceService.wishListInsert(wishList);
//		redirectAttributes.addFlashAttribute("msg", result>0 ? "찜하기 성공" : "찜하기 실패");
//		
//		model.addAttribute("perNo", perNo);
//		return "redirect:/performance/performanceInfoView2.do";
//	}
	
	@PostMapping("/performance/wishListInsert.do")
	public ModelAndView wishListInsert(@RequestParam int perNo, RedirectAttributes redirectAttributes,
			 						   Principal principal, ModelAndView mav){
		
		log.debug("Principal.name={}", principal.getName());
		
		WishList wishList = new WishList();
		wishList.setMemberId(principal.getName());
		wishList.setPerNo(perNo);		
		
		int result = performanceService.wishListInsert(wishList);
		redirectAttributes.addFlashAttribute("msg", result>0 ? "찜하기 성공" : "찜하기 실패");
		
		
		String memberId = principal.getName();
		
		mav.addObject("memberId", memberId);		
		mav.addObject("perNo", perNo);		
		mav.setViewName("redirect:/performance/performanceInfoView2.do");
		return mav;
	}
	
	@PostMapping("/performance/wishListDelete.do")
	public ModelAndView wishListDelete(@RequestParam int perNo, RedirectAttributes redirectAttributes,
										Principal principal, ModelAndView mav){
		
		WishList wishList = new WishList();
		wishList.setMemberId(principal.getName());
		wishList.setPerNo(perNo);		
		
		int result = performanceService.wishListDelete(wishList);
		redirectAttributes.addFlashAttribute("msg", result>0 ? "찜 해제하기 성공" : "찜 해제하기 실패");
		
		
		mav.addObject("perNo", perNo);		
		mav.setViewName("redirect:/performance/performanceInfoView2.do");
		return mav;
	}
	
//	/performance/wishListView.do
	@GetMapping("/performance/wishListView.do")
	public ModelAndView wishListView(ModelAndView mav,
									 Principal principal) {
		log.debug("loginMember = {}", principal);		
		String memberId = principal.getName();  //getMemberId();
		log.debug("memberId@@ = {}", memberId);
		List<MyWishList> list = performanceService.wishListView(memberId);
		List<Performance> recommendedList = performanceService.recommendList();
		List<MyRecentlyPerList> rList = performanceService.recentlyPerList(memberId);
		log.debug("list@controller = {}", list);
		log.debug("recommendedList@controller = {}", recommendedList);
		log.debug("list@controller = {}", rList);
		
		
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy.MM.dd");
		mav.addObject("dateformat", dateformat);
		mav.addObject("list", list);
		mav.addObject("recommendedList", recommendedList);
		mav.addObject("rList", rList);
		mav.setViewName("/performance/wishListView");
		return mav;
	}
	
	//최근공연목록
	@RequestMapping("/performance/recentlyPerList.do")
	public String recentlyPerList(Model model, Principal principal) {
		
		//log.debug("loginMember = {}", loginMember);		
		String memberId = principal.getName();
		log.debug("memberId@@ = {}", memberId);
		
		List<MyRecentlyPerList> rList = performanceService.recentlyPerList(memberId);
		log.debug("list@controller = {}", rList);
				
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy.MM.dd");
		model.addAttribute("dateformat", dateformat);
		model.addAttribute("rList", rList);
		
		return "performance/recentlyPerList";
	}
	
//	@RequestMapping("/performance/adminRecommendedList.do")
//	public String adminRecommendedList(Model model) {		
//		
//		List<Performance> list = performanceService.selectPerformanceList();
//		log.debug("list@controller = {}", list);
//		Performance[] arr = list.toArray(new Performance[list.size()]);
//			
//		int recommendedCnt = 0;
//	    for(int i=0; i<arr.length; i++){
//	    	if("Y".equals(arr[i].getPerDisplay())){
//	    		
//	    		recommendedCnt++;
//	    		
//	    	}
//	    	
//	    }
//		
//		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy.MM.dd");
//		model.addAttribute("dateformat", dateformat);
//		model.addAttribute("list", list);
//		model.addAttribute("recommendedCnt", recommendedCnt);
//		
//		return "performance/adminRecommendedList";
//	}
//	
	
	@GetMapping("/performance/adminRecommendedList.do")
	public String adminRecommendedList(Model model,
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
		
		List<Performance> list = performanceService.allPerformanceList(map);
		List<Performance> recommendedList = performanceService.recommendList();
		log.debug("list@controller = {}", list);
		
		String url = request.getRequestURI() + "?";
		
		int totalContents = performanceService.totalAllPerformanceList();
		String pageBar = Utils.getPageBarHtml(cPage, numPerPage, totalContents, url);
		
		Performance[] arr = list.toArray(new Performance[list.size()]);
			
		int recommendedCnt = recommendedList.size();
//		List<Performance> list2 = new ArrayList<>();
		
//	    for(int i=0; i<arr.length; i++){
//	    	if("Y".equals(arr[i].getPerDisplay())){
//	    		
//	    		recommendedCnt++;
//	    		recommendedList.add(arr[i]);
//	    		log.debug("arr[i]={}",arr[i]);
//	    	}
//	    	else {
//	    		list2.add(arr[i]);
//	    	}
//	    }
	    log.debug("recommendedList = {}", recommendedList);
		
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy.MM.dd");
		model.addAttribute("dateformat", dateformat);
		model.addAttribute("list", list);
		model.addAttribute("recommendedList", recommendedList);
		model.addAttribute("recommendedCnt", recommendedCnt);
		model.addAttribute("cPage", cPage);
		model.addAttribute("pageBar", pageBar);
		
		return "performance/adminRecommendedList";
	}
	
	
	
	@PostMapping("/performance/addRecommendedPer.do")
	public String addRecommendedPer(@RequestParam int perNo, RedirectAttributes redirectAttributes){
		int result = performanceService.addRecommendedPer(perNo);
		redirectAttributes.addFlashAttribute("msg", result>0 ? "추천목록에 추가성공" : "추천목록에 추가실패");
		return "redirect:/performance/adminRecommendedList.do";
	}
	
	@PostMapping("/performance/turnOffRecommendedPer.do")
	public String turnOffRecommendedPer(@RequestParam int perNo, RedirectAttributes redirectAttributes){
		int result = performanceService.turnOffRecommendedPer(perNo);
		redirectAttributes.addFlashAttribute("msg", result>0 ? "추천목록에서 해제성공" : "추천목록에서 해제실패");
		return "redirect:/performance/adminRecommendedList.do";
	}
	
	
	@GetMapping("/performance/adminSearchList")
	public ModelAndView searchPerformance(ModelAndView mav,
										  HttpServletRequest request,
										  @RequestParam("searchType") String searchType,
										  @RequestParam("keyword") String keyword) {
		
//		log.debug("keyword = {}", keyword);
//		log.debug("searchType = {}", searchType);
		
		int numPerPage = 2;
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
		
		List<Performance> list = performanceService.selectPerformanceList(map);
		List<Performance> recommendedList = performanceService.recommendList();
		log.debug("list = {}", list);
		int recommendedCnt = recommendedList.size();
		
		String url = request.getRequestURI() + "?searchType=" + searchType + "&keyword=" + keyword + "&";
		
		int totalContents = performanceService.selectTotalPerformanceList(map);
		String pageBar = Utils.getPageBarHtml(cPage, numPerPage, totalContents, url);
		
		mav.addObject("list", list);
		mav.addObject("searchType", searchType);
		mav.addObject("recommendedList", recommendedList);
		mav.addObject("recommendedCnt", recommendedCnt);
		mav.addObject("cPage", cPage);
		mav.addObject("pageBar", pageBar);
		mav.addObject("keyword", keyword);
		mav.setViewName("performance/adminRecommendedList");
		return mav;
	}	
	
	@GetMapping("/company/companySales.do")
	public ModelAndView companySales(ModelAndView mav) {
		
		mav.setViewName("company/companySales");
		return mav;
		
	}

	
	@PostMapping("/performance/selectDate")
	@ResponseBody
	public List<SchDate> selectDate(@RequestBody Map<String, Object> param){
		
		String date = String.valueOf(param.get("date"));
		String perNo = String.valueOf(param.get("perNo"));
		
		log.debug("date = {}", date);
		log.debug("perNo = {}", perNo);
		
		SimpleDateFormat beforeSdf = new SimpleDateFormat("EEE MMM dd yyyy HH:mm:ss");
		SimpleDateFormat afterSdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		List<SchDate> schList = new ArrayList<>();
		
		try {
			Date beforeDate = beforeSdf.parse(date);
			String newFormatDate = afterSdf.format(beforeDate);
			
			log.debug("beforeDate = {}", beforeDate);
			log.debug("newFormatDate = {}", newFormatDate);
			
			param.put("newFormatDate", newFormatDate);
			
			List<Schedule> list = performanceService.selectDate(param);
			
			log.debug("scheduleList = {}", list);
			
			
			if(list != null) {
				for(Schedule sch: list) {
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					
					String schedule = sdf.format(sch.getSchDateTime());
					
					int schNo = sch.getSchNo();
					String perDate = schedule.substring(0, 11);
					String hour = schedule.substring(11, 13);
					String min = schedule.substring(14, 16);
					
					SchDate sd = new SchDate(schNo, perDate, hour, min);
					log.debug("schDate = {}", sd);
					
					schList.add(sd);
				}
			}
			
			log.debug("schList = {}", schList);
			
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		return schList;
	}
	
	//내가 기대평 단 공연목록
	@RequestMapping("/performance/commentPerList.do")
	public String commentPerList(Model model, Principal principal) {
		
		//log.debug("loginMember = {}", loginMember);		
		String boardCommentWriter = principal.getName();
		log.debug("boardCommentWriter@@ = {}",boardCommentWriter);
		
		List<CommentPerList> list = performanceService.commentPerList(boardCommentWriter);
		log.debug("list@controller = {}", list);
		
		CommentPerList[] arr = list.toArray(new CommentPerList[list.size()]);
		
		//공연 중복제거용 리스트
		List<CommentPerList> cList = new ArrayList<>(); 		
		
		abc:
		for(int i=0; i<arr.length; i++) {
			
			for(int j=0; j<arr.length; j++) {
				if(arr[i].getPerNo()==arr[j].getPerNo()) {
					if(i>j) {
						continue abc;
					}					
				}
			}
			
			cList.add(arr[i]);
		}		
		
		List<MyRecentlyPerList> rList = performanceService.recentlyPerList(boardCommentWriter);
		log.debug("list@controller = {}", rList);
				
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy.MM.dd");
		model.addAttribute("dateformat", dateformat);
		model.addAttribute("cList", cList);
		model.addAttribute("list", list);
		model.addAttribute("rList", rList);
		
		return "performance/commentPerList";
	}	
	
	@RequestMapping("/performance/searchOption")
	public String searchOption(Model model) {
		
		Map<String, Object> param = new HashMap<>();
		
		List<PerJoin> list = performanceService.allPerJoinList(param);
		int size = list.size();
		
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy.MM.dd");
		model.addAttribute("dateformat", dateformat);
		model.addAttribute("listSize", size);
		model.addAttribute("list", list);
		return "performance/performanceSearchOpt";
	}
	
	@ResponseBody
	@RequestMapping("/performance/option")
	public Map<String, Object> searchOption(@RequestBody Map<String, Object> param){
		log.debug("locationCode = {}", param.get("locationCode"));
		log.debug("categoryCode = {}", param.get("categoryArr"));
		
		List<PerJoin> list = performanceService.allPerJoinList(param);
		int size = list.size();
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("listSize", size);
		
		//log.debug("list@locationCode = {}", list);
		return map;
	}
	
	@PostMapping("/performance/addSelect")
	@ResponseBody
	public void addSelect(@RequestBody Map<String, Object> param) {

		int seatNo = Integer.parseInt((String) param.get("seatNo"));
		String memberId = String.valueOf(param.get("memberId"));
		memberId = memberId.replaceAll("\"", "");
		param.put("seatNo", seatNo);
		param.put("memberId", memberId);
		log.debug("memberId@@@={}",memberId);
		int result = performanceService.addSelect(param);
		log.debug("result@@={}",result);

		
	}
	@PostMapping("/performance/removeSelect")
	@ResponseBody
	public void removeSelect(@RequestBody Map<String, Object> param) {
		
		int seatNo = Integer.parseInt((String) param.get("seatNo"));
		String memberId = String.valueOf(param.get("memberId"));
		memberId = memberId.replaceAll("\"", "");
		param.put("seatNo", seatNo);
		param.put("memberId", memberId);
		log.debug("memberId@@@={}",memberId);
		int result = performanceService.removeSelect(param);
		log.debug("result@@={}",result);
		
		
	}
	
	//오늘티켓 공연목록
	@RequestMapping("/performance/todayPerList.do")
	public String todayPerList(Model model, Principal principal) {
			
		//log.debug("loginMember = {}", loginMember);		
		log.debug("principal = {}", principal);
		
		String memberId = null;
		if(principal != null) {
			memberId = principal.getName();			
		}
		
		log.debug("memberId@@  = {}", memberId );
		
		List<MyRecentlyPerList> rList = performanceService.recentlyPerList(memberId);
		log.debug("list@controller = {}", rList);
			

		List<Performance> list = performanceService.selectPerformanceList();
//		List<PerJoin> list = performanceService.todayPerList();
		log.debug("list@controller = {}", list);
					
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy.MM.dd (E)", Locale.KOREAN);
		model.addAttribute("dateformat", dateformat);
		model.addAttribute("rList", rList);
		model.addAttribute("list", list);
			
		return "performance/todayPerList";
	}
	
	//오픈소식 공연목록
	@RequestMapping("/performance/openNewsPerList.do")
	public String openNewsPerList(Model model, Principal principal, HttpServletRequest request) {
		
		//최근 공연바 과정	
		log.debug("principal = {}", principal);
		
		String memberId = null;
		if(principal != null) {
			memberId = principal.getName();			
		}
		
		log.debug("memberId@@  = {}", memberId );
		
		List<MyRecentlyPerList> rList = performanceService.recentlyPerList(memberId);
		log.debug("list@controller = {}", rList);
		
		//----------- 
		
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
		
		
		List<Performance> list = performanceService.openNewsPerList(map);
//		List<PerJoin> list = performanceService.todayPerList();
		log.debug("list@controller = {}", list);
		
		String url = request.getRequestURI() + "?";
		
		int totalContents = performanceService.totalOpenNewsPerList();
		String pageBar = Utils.getPageBarHtml(cPage, numPerPage, totalContents, url);
		
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy.MM.dd (E)", Locale.KOREAN);
		model.addAttribute("dateformat", dateformat);
		model.addAttribute("rList", rList);
		model.addAttribute("list", list);
		model.addAttribute("cPage", cPage);
		model.addAttribute("pageBar", pageBar);
		
		return "performance/openNewsPerList";
	}
	
	
}
