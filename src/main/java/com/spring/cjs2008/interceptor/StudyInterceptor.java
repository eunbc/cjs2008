package com.spring.cjs2008.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class StudyInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		int level = session.getAttribute("slevel")==null? 99 : (Integer)session.getAttribute("slevel");
		
		if(level > 3) {
			response.sendRedirect(request.getContextPath()+"/msg/restricted");
		}
		
		return true;
	}

}
