package com.kh.tickets.customerService.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ResourceLoader;
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

import com.kh.tickets.boardComment.model.vo.ReviewComment;
import com.kh.tickets.common.Utils;
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
	
	@Autowired
	ServletContext servletContext;
	
	@Autowired
	ResourceLoader resourceLoader;
	
	@RequestMapping("customerService.do")
	public ModelAndView noticeList(ModelAndView mav,
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
		
		List<Notice> noticeList = customerService.selectNoticeList(map);
		List<Notice> faqList = customerService.selectFaqList(map);
		log.debug("noticeList = {}", noticeList);
		log.debug("faqList = {}", faqList);
		
		String url = request.getRequestURI() + "?";
		
		//전체컨텐츠수 구하기
		int totalContents = customerService.selectNoticeTotalContents();
		String pageBar = Utils.getPageBarHtml(cPage, numPerPage, totalContents, url);
		
		mav.addObject("noticeList", noticeList);
		mav.addObject("faqList", faqList);
		mav.addObject("cPage", cPage);
		mav.addObject("pageBar", pageBar);
		mav.addObject("totalContents", totalContents);
		mav.setViewName("customerService/customerService");
		
		return mav;
	}
	
	@RequestMapping("/noticeForm.do")
	public ModelAndView boardForm(ModelAndView mav) {
		mav.setViewName("customerService/noticeForm");
		return mav;
	}
	
	@PostMapping("/noticeEnroll.do")
	public ModelAndView insertNotice(Notice notice, ModelAndView mav,
							   RedirectAttributes redirectAttr) {
		
		log.debug("notice = {}", notice);
		
		int result = customerService.insertNotice(notice);
		
		redirectAttr.addFlashAttribute("msg", result > 0? "관람후기 등록 성공!" : "관람후기 등록 실패");
		mav.addObject(notice);		
		mav.setViewName("redirect:/");
		
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
