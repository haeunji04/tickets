package com.kh.tickets;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kh.tickets.performance.model.service.PerformanceService;
import com.kh.tickets.performance.model.vo.MyRecentlyPerList;
import com.kh.tickets.performance.model.vo.Performance;

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
//		else {
//			memberId = "nonlogin";
//		}
		log.debug("memberId@@  = {}", memberId );
		
		List<MyRecentlyPerList> rList = performanceService.recentlyPerList(memberId);
		log.debug("rList@homecontroller## = {}", rList);		
		
		model.addAttribute("rList", rList);

		
		//랭킹
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy.MM.dd (E)", Locale.KOREAN);
		
		Map<String, Object> param = new HashMap<>();
		param.put("code1", "C1");
		param.put("code2", "C2");
		
		List<Performance> mList = performanceService.selectPerRank(param);
		List<Performance> pickList = performanceService.selectPickList();
		
		log.debug("pickList= {}", pickList);
		
		//슬라이드 아래 new 공연
		List<Performance> newList = performanceService.selectPerformanceList();
		log.debug("newList= {}", newList);
		
		//슬라이드 아래 콘서트&페스티벌 공연
		String category = "C3";
		List<Performance> concertList = performanceService.selectCategoryList(category);
		log.debug("concertList= {}", concertList);
		
		//슬라이드 아래 뮤지컬 공연
		category = "C1";
		List<Performance> musicalList = performanceService.selectCategoryList(category);
		log.debug("musicalList= {}", musicalList);
		
		//슬라이드 아래 연극 공연
		category = "C2";
		List<Performance> theatreList = performanceService.selectCategoryList(category);
		log.debug("theatreList= {}", theatreList);
		
		model.addAttribute("dateformat", dateformat);	
		model.addAttribute("muRank", mList);
		model.addAttribute("pickList", pickList);
		model.addAttribute("newList", newList);
		model.addAttribute("concertList", concertList);
		model.addAttribute("musicalList", musicalList);
		model.addAttribute("theatreList", theatreList);
		
		return "forward:/index.jsp";
	}
	
	@PostMapping("/")
	@ResponseBody
	public Map<String, Object> selectPerRank(@RequestBody Map<String, Object> param){
		
		String code1 = (String)param.get("code1");
		String code2 = (String)param.get("code2");
		
		List<Performance> list = performanceService.selectPerRank(param);
		
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy.MM.dd (E)", Locale.KOREA);
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("dateFormat", dateformat);
		
		return map;
	}
	
	
}
