package com.kh.tickets.performance.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.tickets.common.Utils;
import com.kh.tickets.performance.model.service.PerformanceService;
import com.kh.tickets.performance.model.vo.Performance;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class PerformanceController {
	
	@Autowired
	private PerformanceService  performanceSerivce; 

	@GetMapping("/list")
	public ModelAndView listView(ModelAndView mav,
							@RequestParam("category") String category) {
		log.debug("category = {}", category);
		mav.addObject("category", category);
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
	
//	@RequestMapping("/performance/performaceRegisterForm.do")
//	public String memberEnrollForm() {
//		return "/performance/performaceRegisterForm";
//	}
	
	@PostMapping("/performance/performanceRegister.do")
	public String performanceRegister(Performance performance,
			  						  @RequestParam(value="perImgFile",required=false) MultipartFile[] perImgFiles,
			  						  @RequestParam(value="detailImgFile",required=false) MultipartFile[] detailImgFiles,
									  HttpServletRequest request,
									  RedirectAttributes redirectAttr) {
		
		String address_ = request.getParameter("address_");		
		String address = performance.getPerAddress() + " " + address_;		
		performance.setPerAddress(address);		
		
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
			int result = performanceSerivce.performanceRegister(performance);
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
		List<Performance> list = performanceSerivce.selectPerformanceList();
		log.debug("list@controller = {}", list);
		
		model.addAttribute("list", list);
		
		return "performance/performanceList";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}

		//파일 업로드 시도 관련 이클립스쪽 참고
//		int maxPostSize = 1024 * 1024 * 10; //10MB
//		
//		FileRenamePolicy policy = new MvcFileRenamePolicy();
//		
//		MultipartRequest multipartRequest
//		= new MultipartRequest(request,
//								saveDirectory,
//								maxPostSize,
//								"utf-8",
//								policy);