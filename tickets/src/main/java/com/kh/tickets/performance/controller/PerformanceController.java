package com.kh.tickets.performance.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.tickets.common.Utils;
import com.kh.tickets.member.model.vo.Member;
import com.kh.tickets.performance.model.service.PerformanceService;
import com.kh.tickets.performance.model.vo.Performance;
import com.kh.tickets.performance.model.vo.PerformanceHall;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@SessionAttributes(value = { "loginMember" })
public class PerformanceController {
	
	@Autowired
	private PerformanceService performanceService; 

	@GetMapping("/list")
	public ModelAndView categoryListView(ModelAndView mav,
							@RequestParam("category") String category) {
		log.debug("category = {}", category);
		
		List<Performance> list = performanceService.categoryListView(category);
		
		String categoryName = performanceService.getCategoryName(category); 
		
		log.debug("list = {}", list);
		mav.addObject("list", list);
		mav.addObject("categoryName", categoryName);
		mav.setViewName("/performance/performanceCategoryView");
		return mav;
	}
	
	
	@GetMapping("/search")
	public ModelAndView searchView(ModelAndView mav,
								   @RequestParam("keyword") String keyword) {
		log.debug("keyword = {}", keyword);
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
	public String performanceRegister(Performance performance,
			  						  @RequestParam(value="perImgFile",required=false) MultipartFile[] perImgFiles,
			  						  @RequestParam(value="detailImgFile",required=false) MultipartFile[] detailImgFiles,
									  HttpServletRequest request,
									  RedirectAttributes redirectAttr) {
		
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
			redirectAttr.addFlashAttribute("msg", "공연등륵 신청 성공!");
		} catch (Exception e) {
			log.error("공연등륵 신청 오류", e);
//			redirectAttr.addFlashAttribute("msg", "공연등륵 신청 실패!");
			
			//예외발생을 spring container에게 전달 : 지정한  예외페이지로 응답처리
			throw e;
		}	
		
		
		return "redirect:/performance/performanceRegisterForm.do";
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
	public String perUpdate(Performance performance, 
			 				@RequestParam(value="perImgFile",required=false) MultipartFile[] perImgFiles,
			 				@RequestParam(value="detailImgFile",required=false) MultipartFile[] detailImgFiles,
			 				HttpServletRequest request,
							RedirectAttributes redirectAttributes){
		
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
		
		int result = performanceService.perUpdate(performance);
		redirectAttributes.addFlashAttribute("msg", result>0 ? "공연정보 수정성공" : "공연정보 수정실패");
		return "redirect:/company/companyPerList.do";
	}
	
	
	
	
	
}

	