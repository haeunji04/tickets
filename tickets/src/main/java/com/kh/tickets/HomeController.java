package com.kh.tickets;

import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kh.tickets.performance.model.service.PerformanceService;
import com.kh.tickets.performance.model.vo.MyRecentlyPerList;

/**
 * Handles requests for the application home page.
 */
@Controller
@SessionAttributes(value = { "loginMember" })
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private PerformanceService performanceService; 
	
	private Logger log = 
			LoggerFactory.getLogger(getClass());
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, @ModelAttribute("memberId") String memberId) {
		
		log.debug("memberId = {}", memberId);
//		logger.info("Welcome home! The client locale is {}.", locale);
//		
//		Date date = new Date();
//		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
//		
//		String formattedDate = dateFormat.format(date);
//		
//		model.addAttribute("serverTime", formattedDate );
		
//		if(memberId != null) {
//		}
			
		
		List<MyRecentlyPerList> rList = performanceService.recentlyPerList(memberId);
		log.debug("rList@homecontroller## = {}", rList);		
		
		model.addAttribute("rList", rList);
		
		
		
		return "forward:/index.jsp";
	}
	
}
