package com.cannes.movie.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.cannes.movie.domain.MemberVO;
import com.cannes.movie.service.MemberService;

public class FindIdInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(FindIdInterceptor.class);
	
	@Autowired
	private MemberService memberService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		// 아이디 찾기 페이지에서 넘어온 정보
		HttpSession session = request.getSession();
		MemberVO vo = (MemberVO) session.getAttribute("inputInfo");
		String standardkey = (String) session.getAttribute("authkey");
		System.out.println(vo);
		System.out.println(standardkey);
		
		// 이메일 인증 후 넘어온 정보
		String email = request.getParameter("email");
		String authkey = request.getParameter("authkey");
		
		if(email == null || authkey == null) {
			response.sendRedirect("/error");
		}
		System.out.println(email);
		System.out.println(authkey);
		
		// 기준 데이터와 인증 후 데이터가 같으면
		if(vo.getMemberEmail().equals(email) && standardkey.equals(authkey)) {
			logger.info("이메일 인증 성공");
			MemberVO result = memberService.readFindId(vo);
			// 해당하는 회원이 없을 때
			if(result == null) {
				logger.info("아이디 찾기 실패");
				response.sendRedirect("/error");
				return false;
			} else { // 해당하는 회원이 존재
				logger.info("아이디 찾기 성공");
				request.setAttribute("findMember", result);
				session.removeAttribute("inputInfo");
				session.removeAttribute("authkey");
				return true;
			}
		} else { // 이메일 인증 실패
			logger.info("이메일 인증 실패");
			response.sendRedirect("error.jsp");
			return false;
		}
	} // end preHandle()
} // end FindIdInterceptor
