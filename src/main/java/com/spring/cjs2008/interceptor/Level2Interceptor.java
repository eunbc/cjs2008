package com.spring.cjs2008.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class Level2Interceptor extends HandlerInterceptorAdapter {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		int slevel = session.getAttribute("slevel")==null? 99 : (Integer) session.getAttribute("slevel");
		if(slevel <= 2) {
			System.out.println("접근 허용 구역(레벨2이하)");
		} else {
			System.out.println("접근 불가 구역(레벨3이상)");
			response.sendRedirect(request.getContextPath()+"/msg/restricted");
		}
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		System.out.println("레벨2 인터셉터 끝");
	}
	
}
