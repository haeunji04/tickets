package com.kh.tickets.boardComment.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.tickets.boardComment.model.service.BoardCommentService;
import com.kh.tickets.boardComment.model.vo.BoardComment;
import com.kh.tickets.boardComment.model.vo.ReviewComment;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@SessionAttributes(value = { "loginMember" })
public class BoardCommentController {
	
	@Autowired
	private BoardCommentService boardCommentService;
	
	@PostMapping(value="/boardComment/boardCommentInsert.do")
	public ModelAndView boardCommentInsert(ModelAndView mav, BoardComment boardComment, @RequestParam int perNo,
								     RedirectAttributes redirectAttr) {		
	
	log.debug("BoardComment@@ = {}", boardComment);
	
	// 1. 로직 실행
	int result = boardCommentService.boardCommentInsert(boardComment);
	log.debug("result@@ = {}", result);
	
	// 2. 사용자 알림
	redirectAttr.addFlashAttribute("msg", result > 0? "기대평 등록 성공!" : "기대평 등록 실패");
	
	mav.addObject("perNo", perNo);		
	mav.setViewName("redirect:/performance/performanceInfoView2.do");
	return mav;
	}
	
	
	@PostMapping(value = "/boardComment/boardCommentDelete.do")
	public ModelAndView boardCommentDelete(@RequestParam int boardCommentNo, @RequestParam int perNo,
											ModelAndView mav,BoardComment boardComment, 
											RedirectAttributes redirectAttributes){
		
		boardComment.setBoardCommentNo(boardCommentNo);
		boardComment.setPerNo(perNo);
		
		log.debug("BoardComment@@ = {}", boardComment);
		
		int result = boardCommentService.boardCommentDelete(boardComment);
		log.debug("result@@ = {}", result);
		
		redirectAttributes.addFlashAttribute("msg", result>0 ? "댓글 삭제성공" : "댓글 삭제실패");

		mav.addObject("perNo", perNo);		
		mav.setViewName("redirect:/performance/performanceInfoView2.do");
		return mav;
	}
	
	@ResponseBody
	@PostMapping("/review/searchReservationMember.do")
	public String searchReservationMember(@RequestBody Map<String, Object> param, Model model) {
		
		log.debug("perNo@searchReservationMember = {}, {}", param.get("perNo"), param.get("memberId"));
		String result = boardCommentService.searchReservationMember(param);
		log.debug("result@searchReservationMember={}", result);
		
		return result;
	}
	
	@PostMapping("/review/insertReview.do")
	public ModelAndView insertReview(ReviewComment review, ModelAndView mav) {
		
		log.debug("review = {}", review);
		
		int result = boardCommentService.insertReview(review);
		
		mav.addObject("msg", result > 0? "기대평 등록 성공!" : "기대평 등록 실패");
		
		mav.addObject("perNo", review.getPerNo());		
		mav.setViewName("redirect:/performance/performanceInfoView2.do");
		
		return mav;
	}
	
	

}
