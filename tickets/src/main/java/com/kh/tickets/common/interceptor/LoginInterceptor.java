package com.kh.tickets.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.FlashMapManager;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.kh.tickets.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class LoginInterceptor extends HandlerInterceptorAdapter{@Override
	public boolean preHandle(HttpServletRequest request, 
							 HttpServletResponse response, 
							 Object handler)
			throws Exception {
		
		log.debug("로그인 여부 체크!");
		HttpSession session = request.getSession();
		Member loginMember = (Member) session.getAttribute("loginMember");
		
		if(loginMember == null) {
			// FlashMap을 통한 사용자 피드백
			FlashMap flashMap = new FlashMap();
			flashMap.put("msg", "로그인 후 이용할 수 있습니다.");
			
			FlashMapManager manager = RequestContextUtils.getFlashMapManager(request);
			manager.saveOutputFlashMap(flashMap, request, response);
			
			//로그인 성공 후, redirect할 주소 session에 저장 : next
			String uri = request.getRequestURI();	// /spring/board/boardForm.do
			uri = uri.replace(request.getContextPath(), "");	//uri에 있는 / 없애기
			
			String param = request.getQueryString();	//no=??&name=??
			uri += !"".equals(param) ? "?" + param : param;
			log.debug("uri = {}", uri);
			
			session.setAttribute("next", uri);
			
			response.sendRedirect(request.getContextPath() + "/member/memberLoginForm.do");
			
			return false;
		}
		
		return super.preHandle(request, response, handler);
	}

	
	
}
