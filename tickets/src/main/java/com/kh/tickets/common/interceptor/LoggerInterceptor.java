package com.kh.tickets.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoggerInterceptor extends HandlerInterceptorAdapter{

	private Logger log = 
			LoggerFactory.getLogger(getClass());
	
	/**
	 * DispatcherServlet에서 controller의 handler메소드 호출 전
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, 
							 HttpServletResponse response, 
							 Object handler)
			throws Exception {
		
		log.debug("=============HANDLER============");
		log.debug("{}",request.getRequestURI());
		log.debug("-----------------------");
		
		// true를 리턴해야 정상적인 mvc 흐름을 만들 수 있다.
		return super.preHandle(request, response, handler);
	}

	/**
	 * Handler메소드에서 DispatcherServlet으로 리턴되기 직전
	 * view단에 전달된 Model 객체 확인
	 */
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);

		log.debug("------------------------------");
		log.debug("mav = {}", modelAndView);
		log.debug("------------------- VIEW -------------------");
	}

	/**
	 * view단에서 응답처리 후에 호출
	 */
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		super.afterCompletion(request, response, handler, ex);
	
		log.debug("_______________ END _______________");
	}

	
	
}
