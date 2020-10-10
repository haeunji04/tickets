package com.kh.tickets;

import java.security.Principal;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kh.tickets.member.model.vo.Member;
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
	public String home(Locale locale, Model model, @ModelAttribute("memberId") String memberId,
						HttpSession session, Principal principal) {
		
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
		
		//security 관련 방식으로 해서도 loginMember session 담아보기 시도
//		Member member = new Member();
//		String location = "/";
//		
//		if(member != null ) {
//			// 세션처리
//			model.addAttribute("loginMember", member);			
////			model.addAttribute("memberId", memberId);			
////			model.addAttribute("rList", rList);
//		
//			//세션에서 next값 가져오기
//			String next = (String) session.getAttribute("next");
//			location = next != null ? next : location;
//			session.removeAttribute("next");
//			
//		}
		
		//memberId = principal.getName();
		
		if(principal != null) {
			memberId = principal.getName();
			
		}
		log.debug("memberId@@  = {}", memberId );
		
		List<MyRecentlyPerList> rList = performanceService.recentlyPerList(memberId);
		log.debug("rList@homecontroller## = {}", rList);		
		
		model.addAttribute("rList", rList);
		
		
		
		return "forward:/index.jsp";
	}
	
}
