package com.kh.tickets.customerService.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.tickets.customerService.model.service.CustomerService;
import com.kh.tickets.customerService.model.vo.Notice;
import com.kh.tickets.performance.controller.PerformanceController;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/customerService")
@Slf4j
public class CustomerServiceController {
	@Autowired
	private CustomerService customerService;
	
	@RequestMapping("customerService.do")
	public ModelAndView noticeList(ModelAndView mav, 
								  @RequestParam(defaultValue = "1", 
												value = "cPage") int cPage) {
		//1.사용자 입력값 
		final int limit = 10;
		int offset = (cPage - 1) * limit;
		
		//2. 업무로직
		List<Notice> list = customerService.selectNoticeList(limit, offset);
		log.debug("list = {}", list);
		
		//전체컨텐츠수 구하기
		//int totalContents = customerService.selectBoardTotalContents();
		
		//3. view단 처리
		//mav.addObject("totalContents", totalContents);
		mav.addObject("list", list);
		mav.setViewName("customerService/customerService");
		return mav;
	}
	
	@RequestMapping("/noticeForm.do")
	public ModelAndView boardForm(ModelAndView mav) {
		mav.setViewName("customerService/noticeForm");
		return mav;
	}
	
	@PostMapping("/noticeEnroll.do")
	public String noticeEnroll(Notice notice,
							  HttpServletRequest request,
							  RedirectAttributes redirectAttr) {

		log.debug("notice = {}", notice);
		
		//2. 게시글, 첨부파일정보를 DB에 저장
		try {
			int result = customerService.insertNotice(notice);
			redirectAttr.addFlashAttribute("msg", "게시글 등록 성공!");
		} catch (Exception e) {
			log.error("게시물 등록  오류", e);
			
			//예외발생을 spring container에게 전달 : 지정한  예외페이지로 응답처리
			throw e;
		}
		
		return "redirect:/customerService/noticeList.do";
	}
	
	@GetMapping("/noticeDetail.do")
	public String boardDetail(@RequestParam int noticeNo,
							  Model model) {
		log.debug("[{}]번 게시글 조회!", noticeNo);
		
		//1.Board : boardService.selectOneBoard(no);
		//2.List<Attachment> : boardService.selectAttachList(no);
		
		Notice notice = customerService.selectOneNoticeCollection(noticeNo);
		log.debug("notice = {}", notice);
		
		model.addAttribute("notice", notice);
		
		return "customerService/noticeDetail";
	}
}
