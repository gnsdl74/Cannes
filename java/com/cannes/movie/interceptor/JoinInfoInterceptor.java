package com.cannes.movie.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class JoinInfoInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(JoinInfoInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		logger.info("JoinInfo preHandle() 호출");
		
		// step1 약관동의에서 넘어왔는지 확인
		String check = request.getParameter("step1");
		System.out.println("check의 값 : " + check);
		// 비정상적인 경로로 접근했을 때
		if (check == null || check == "") {
			response.sendRedirect("error.jsp");
		}
		HttpSession session = request.getSession();
		session.setAttribute("step1", check);
		return true;
	}

} // end JoinInterceptor
