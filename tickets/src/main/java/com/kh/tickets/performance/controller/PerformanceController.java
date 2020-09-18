package com.kh.tickets.performance.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class PerformanceController {

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
	
}
