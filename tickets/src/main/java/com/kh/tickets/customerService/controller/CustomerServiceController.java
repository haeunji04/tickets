package com.kh.tickets.customerService.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

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
