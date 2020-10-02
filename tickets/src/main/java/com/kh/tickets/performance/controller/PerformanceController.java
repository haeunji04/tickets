package com.kh.tickets.performance.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
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
import com.kh.tickets.common.Utils;
import com.kh.tickets.member.model.vo.Member;
import com.kh.tickets.performance.model.service.PerformanceService;
import com.kh.tickets.performance.model.vo.MyRecentlyPerList;
import com.kh.tickets.performance.model.vo.MyWishList;
import com.kh.tickets.performance.model.vo.PerJoin;
import com.kh.tickets.performance.model.vo.Performance;
import com.kh.tickets.performance.model.vo.PerformanceHall;
import com.kh.tickets.performance.model.vo.RecentlyPerList;
import com.kh.tickets.performance.model.vo.SchDate;
import com.kh.tickets.performance.model.vo.Schedule;
import com.kh.tickets.performance.model.vo.WishList;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@SessionAttributes(value = { "loginMember" })
public class PerformanceController {
	
	@Autowired
	private PerformanceService performanceService; 
	
	@Autowired
	private BoardCommentService boardCommentService;
	
//	@Autowired
//	private WishList wishList;
	

	@GetMapping("/list")
	public ModelAndView categoryListView(ModelAndView mav,
							@RequestParam("category") String category) {
		log.debug("category = {}", category);
		
		List<PerJoin> list = performanceService.categoryListView(category);
		
		String categoryName = performanceService.getCategoryName(category); 
		
		log.debug("list = {}", list);
		
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy.MM.dd");
		mav.addObject("dateformat", dateformat);		
		mav.addObject("list", list);
		mav.addObject("categoryName", categoryName);
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
		
		mav.addObject("perNo", perNo);
		mav.setViewName("performance/performanceDateRegisterForm");
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
									  @ModelAttribute("loginMember") Member loginMember) {
		log.debug("loginMember = {}", loginMember);		
		String memberId = loginMember.getMemberId();
		log.debug("memberId@@ = {}", memberId);
		List<Performance> list = performanceService.companyPerList(memberId);
		log.debug("list@controller = {}", list);
		
		
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy.MM.dd");
		mav.addObject("dateformat", dateformat);
		mav.addObject("list", list);
		mav.setViewName("/company/companyPerList");
		return mav;
	}
	
	@PostMapping("/company/perUpdateForm.do")
	public ModelAndView perUpdateForm(ModelAndView mav,
			   						 @RequestParam int perNo, RedirectAttributes redirectAttributes) {		
		
		Performance performance = performanceService.selectOnePerformance(perNo);
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
		
		String saveDirectory = request.getServletContext()
				  .getRealPath("/resources/upload/performance");
		
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
	
	
	@GetMapping("/performance/performanceInfoView2.do")
	public ModelAndView performanceInfoView2(ModelAndView mav, @RequestParam int perNo,
											@RequestParam(value="loginMember",required=false) Member loginMember) {
		
		log.debug("perNo@@ = {}", perNo);
		Performance performance = performanceService.selectOnePerformance(perNo);
		
		if(loginMember!=null) {
			
		String memberId = loginMember.getMemberId();
		log.debug("memberId@@ = {}", memberId);
		
		//공연상세페이지에 들어갈 공연객체
		//찜하기 여부 확인할 찜 list				
		List<MyWishList> list = performanceService.wishListView(memberId);
		log.debug("list@controller = {}", list);
		
		
		//내 최근목록 list. for문과 if절에서 이미 최근목록에 있을시 이전거 지우고, 다시 최신날짜로 insert
		List<MyRecentlyPerList> rList = performanceService.recentlyPerList(memberId);
		MyRecentlyPerList[] arr = rList.toArray(new MyRecentlyPerList[rList.size()]);
		
		
	    for(int i=0; i<arr.length; i++){
	    	if(perNo==(arr[i].getPerNo())){
	    		
	    		RecentlyPerList recentlyPerList2 = new RecentlyPerList();
	    		recentlyPerList2.setMemberId(arr[i].getMemberId());
	    		recentlyPerList2.setPerNo(arr[i].getPerNo());
	    		
	    		int result = performanceService.recentlyPerListDelete(recentlyPerList2);
	    	}
	    	
	    }
	    
	    RecentlyPerList recentlyPerList = new RecentlyPerList();
		recentlyPerList.setMemberId(loginMember.getMemberId());
		recentlyPerList.setPerNo(perNo);
		
		
		int result = performanceService.recentlyPerListInsert(recentlyPerList);		
		log.debug("recentlyPerListInsert@controller = {}", result);
		
		mav.addObject("list", list);		
		}
		List<BoardComment> commentList = boardCommentService.selectCommentList(perNo);
		int commntListSize = commentList.size();
		
		log.debug("commentList@controller@@ = {}", commentList);
		log.debug("commntListSize@@ = {}", commntListSize);
		
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy.MM.dd");
		
		mav.addObject("dateformat", dateformat);
		mav.addObject("performance", performance);		
		mav.addObject("commentList", commentList);		
		mav.addObject("commntListSize", commntListSize);		
//		mav.addObject("loginMember", loginMember);		
		mav.setViewName("/performance/performanceInfoView2");
		return mav;
	}
	@GetMapping("/performance/selectSeat.do")
	public ModelAndView selectSeat(ModelAndView mav) {
		
		mav.setViewName("performance/selectSeat");
		return mav;
	}
	
	@GetMapping("/performance/salePerformance.do")
	public ModelAndView salePerformance(ModelAndView mav) {
		
		mav.setViewName("performance/salePerformance");
		return mav;
	}
	
	@GetMapping("/performance/paySelect.do")
	public ModelAndView paySelect(ModelAndView mav) {
		
		mav.setViewName("performance/paySelect");
		return mav;
	}
	
	@GetMapping("/performance/payComplete.do")
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
			 						   @ModelAttribute("loginMember") Member loginMember, ModelAndView mav){
		
		WishList wishList = new WishList();
		wishList.setMemberId(loginMember.getMemberId());
		wishList.setPerNo(perNo);		
		
		int result = performanceService.wishListInsert(wishList);
		redirectAttributes.addFlashAttribute("msg", result>0 ? "찜하기 성공" : "찜하기 실패");
		
			
		mav.addObject("perNo", perNo);		
		mav.setViewName("redirect:/performance/performanceInfoView2.do");
		return mav;
	}
	
	@PostMapping("/performance/wishListDelete.do")
	public ModelAndView wishListDelete(@RequestParam int perNo, RedirectAttributes redirectAttributes,
			@ModelAttribute("loginMember") Member loginMember, ModelAndView mav){
		
		WishList wishList = new WishList();
		wishList.setMemberId(loginMember.getMemberId());
		wishList.setPerNo(perNo);		
		
		int result = performanceService.wishListDelete(wishList);
		redirectAttributes.addFlashAttribute("msg", result>0 ? "찜 해체하기 성공" : "찜 해제하기 실패");
		
		
		mav.addObject("perNo", perNo);		
		mav.setViewName("redirect:/performance/performanceInfoView2.do");
		return mav;
	}
	
//	/performance/wishListView.do
	@GetMapping("/performance/wishListView.do")
	public ModelAndView wishListView(ModelAndView mav,
									  @ModelAttribute("loginMember") Member loginMember) {
		log.debug("loginMember = {}", loginMember);		
		String memberId = loginMember.getMemberId();
		log.debug("memberId@@ = {}", memberId);
		List<MyWishList> list = performanceService.wishListView(memberId);
		log.debug("list@controller = {}", list);
		
		
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy.MM.dd");
		mav.addObject("dateformat", dateformat);
		mav.addObject("list", list);
		mav.setViewName("/performance/wishListView");
		return mav;
	}
	
	@RequestMapping("/performance/recentlyPerList.do")
	public String recentlyPerList(Model model, @ModelAttribute("loginMember") Member loginMember) {
		
		log.debug("loginMember = {}", loginMember);		
		String memberId = loginMember.getMemberId();
		log.debug("memberId@@ = {}", memberId);
		
		List<MyRecentlyPerList> list = performanceService.recentlyPerList(memberId);
		log.debug("list@controller = {}", list);
				
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy.MM.dd");
		model.addAttribute("dateformat", dateformat);
		model.addAttribute("list", list);
		
		return "performance/recentlyPerList";
	}
	
	@RequestMapping("/performance/adminRecommendedList.do")
	public String adminRecommendedList(Model model) {		
		
		List<Performance> list = performanceService.selectPerformanceList();
		log.debug("list@controller = {}", list);
		Performance[] arr = list.toArray(new Performance[list.size()]);
			
		int recommendedCnt = 0;
	    for(int i=0; i<arr.length; i++){
	    	if("Y".equals(arr[i].getPerDisplay())){
	    		
	    		recommendedCnt++;
	    		
	    	}
	    	
	    }
		
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy.MM.dd");
		model.addAttribute("dateformat", dateformat);
		model.addAttribute("list", list);
		model.addAttribute("recommendedCnt", recommendedCnt);
		
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
	
	//한나님 오류 확인용 주석
	
}

	