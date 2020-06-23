package com.cannes.movie.controller;

import java.io.UnsupportedEncodingException;

import javax.mail.MessagingException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cannes.movie.authutil.MailUtils;
import com.cannes.movie.authutil.TempKey;
import com.cannes.movie.domain.MemberVO;

@Controller
public class AuthController {
	private static final Logger logger = LoggerFactory.getLogger(AuthController.class);

	@Autowired
	private JavaMailSender mailSender;

	@ResponseBody
	@PostMapping(value = "/emailAuth")
	public String emailAuth(@RequestBody MemberVO vo, HttpServletRequest request) {
		String name = vo.getMemberName();
		String email = vo.getMemberEmail();
		logger.info("emailAuth() 호출");
		logger.info(email);

		// 임의의 authkey 생성
		String authkey = new TempKey().getKey(50, false);

		// mail 작성 관련
		try {
			MailUtils sendMail = new MailUtils(mailSender);
			
			sendMail.setSubject("[Best Theater, Cannes] 아이디 찾기 이메일 인증");
			sendMail.setText(new StringBuffer().append("<h3>[이메일 인증]</h3>")
					.append("<p>안녕하세요. <b>" + name + "</b>님 저희 홈페이지를 찾아주셔서 감사합니다.</p>")
					.append("<br>")
					.append("<p><b>제한 시간 5분</b> 안에</p>")
					.append("<br>")
					.append("<p>아래 링크를 클릭하시면 이메일 인증이 완료됩니다.</p>")
					.append("<br>")
					.append("<p><a href='http://localhost:8080/idConfirm?email=")
					.append(email)
					.append("&authkey=")
					.append(authkey)
					.append("' target='_blenk'>이메일 인증 확인</a></p>")
					.append("<br>")
					.append("<p>언제나 좋은 하루가 되시길 기원합니다.</p>")
					.toString());
			sendMail.setFrom("Cannes", "Cannes Theater");
			sendMail.setTo("wjdrlgnsdd@naver.com");
			sendMail.send();
		} catch (MessagingException | UnsupportedEncodingException e) {
			return "fail";
		}
		
		// 이메일 인증 후에 기준이 될 데이터 저장
		HttpSession session = request.getSession();
		session.setAttribute("inputInfo", vo);
		session.setAttribute("authkey", authkey);
		
		return "success";
	} // emailAuth()
	
	@GetMapping(value = "/idConfirm")
	public String idConfirm() {
		logger.info("idConfirm() 호출");
		return "/member/idConfirm";
	} // end idConfirm()
	
	@GetMapping(value = "/setNewPw")
	public String setNewPw(HttpServletRequest request, Model model) {
		logger.info("setNewPw() 호출");
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for(Cookie cookie : cookies) {
				if(cookie.getName().equals("Cookie_idByNewPw")) {
					System.out.println("생성된 쿠키 찾았다!");
					model.addAttribute("idByNewPw", cookie.getValue());
					cookie.setMaxAge(0);
				}
			}
		}
		return "/member/setNewPw";
	} // end setNewPw()
	
} // end AuthController
