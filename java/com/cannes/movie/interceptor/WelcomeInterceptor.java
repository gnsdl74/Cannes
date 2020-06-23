package com.cannes.movie.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class WelcomeInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(WelcomeInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		logger.info("welcome preHandle() 호출");
		
		// step1과 step2를 거쳐서 왔는지
		HttpSession session = request.getSession();
		String step1 = (String) session.getAttribute("step1");
		String step2 = request.getParameter("step2");
		System.out.println("step1, step2 : " + step1 + ", " + step2);
		
		// 비정상적인 경로로 접근했을 때
		if((step1 == null || step1 == "") || (step2 == null || step2 == "")) {
			response.sendRedirect("error.jsp");
		}
		session.setAttribute("step2", step2);
		return true;
	}
} // end JoinInterceptor
