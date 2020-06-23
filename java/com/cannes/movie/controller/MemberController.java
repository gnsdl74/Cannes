package com.cannes.movie.controller;

import javax.servlet.http.HttpSession;

import org.apache.catalina.servlet4preview.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cannes.movie.domain.MemberVO;
import com.cannes.movie.service.MemberService;

@Controller
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberService memberService;

	/* 로그인했을 경우, 회원이면 id로 세션 생성 */
	@ResponseBody
	@PostMapping(value = "/login")
	public String login(HttpServletRequest request, MemberVO vo) {
		logger.info("login() 호출");
		System.out.println(vo);
		MemberVO result = memberService.readDetail(vo);
		System.out.println(result);
		if (result != null) {
			HttpSession session = request.getSession();
			session.setAttribute("memberId", vo.getMemberId());
			session.setAttribute("memberNo", result.getMemberNo());
			return "success";
		} else {
			return "fail";
		}
	} // end login()

	/* 로그아웃하면 memberId 세션 삭제 후 main 이동 */
	@ResponseBody
	@GetMapping(value = "/logout")
	public String logout(HttpServletRequest request) {
		logger.info("logout() 호출");
		HttpSession session = request.getSession();
		session.removeAttribute("memberId");
		return "success";
	} // end logout()

	/* 약관동의 페이지 이동 */
	@GetMapping(value = "/tos")
	public String tos() {
		logger.info("tos() 호출");
		return "/member/tos";
	} // end tos()

	/* 회원정보 입력 페이지 이동 전 JoinInfoInterceptor */
	@PostMapping(value = "/joinInfo")
	public String joinInfo() {
		logger.info("joinInfo() 호출");
		return "/member/joinInfo";
	} // end joinInfo()

	/* 아이디 중복확인 */
	@ResponseBody
	@GetMapping(value = "/checkId")
	public String checkId(String id) {
		logger.info("checkId() 호출");
		System.out.println(id);
		String checkId = memberService.readById(id);
		if (checkId == null) {
			return "success";
		} else {
			return "fail";
		}
	} // end checkId()

	/* joinInfo 페이지에서 넘어온 JSON데이터로 회원가입 후 결과 반환 */
	@ResponseBody
	@PostMapping(value = "/join")
	public String join(@RequestBody MemberVO vo) {
		logger.info("join() 호출");
		System.out.println(vo);
		int result = memberService.create(vo);
		System.out.println("회원가입 결과 : " + result);
		if (result == 1) {
			return "success";
		} else {
			return "fail";
		}
	} // end join()

	/* 가입환영 페이지로 이동 전 WelcomeInterceptor */
	@PostMapping(value = "/welcome")
	public String welcome(HttpServletRequest request, Model model) {
		logger.info("welcome() 호출");
		String name = request.getParameter("welcomeName");
		String id = request.getParameter("welcomeId");

		model.addAttribute("name", name);
		model.addAttribute("id", id);

		return "/member/welcome";
	} // end welcome()

	/* 아이디, 비밀번호 찾기 페이지 이동 */
	@GetMapping(value = "/find")
	public String findId_Pw() {
		logger.info("findId_Pw() 호출");
		return "/member/find";
	} // end findId_Pw()

	/* 아이디찾기 중 회원인지 체크하는 메소드 */
	@ResponseBody
	@PostMapping(value = "/find/idMember")
	public String idMember(@RequestBody MemberVO vo) {
		logger.info("idMember() 호출");
		logger.info(vo + "");
		MemberVO result = memberService.readFindId(vo);
		if (result != null) {
			return "success";
		} else {
			return "fail";
		}
	} // end idMember()

	/* 비밀번호찾기 중 회원인지 체크하는 메소드 */
	@ResponseBody
	@PostMapping(value = "/find/pwMember")
	public String pwMember(@RequestBody MemberVO vo) {
		logger.info("pwMember() 호출");
		logger.info(vo + "");
		MemberVO result = memberService.readFindPw(vo);
		if (result != null) {
			return "success";
		} else {
			return "fail";
		}
	} // end pwMember()
	
	/* 비밀번호 찾기 후 새로운 비밀번호 설정 */
	@ResponseBody
	@PostMapping(value = "/newPwUpdate")
	public String newPwUpdate(HttpServletRequest request) {
		logger.info("pwMember() 호출");
		String id = request.getParameter("memberId");
		String pw = request.getParameter("memberPw");
		System.out.println(id);
		System.out.println(pw);
		
		MemberVO vo = new MemberVO();
		if(id != null && pw != null) {
			vo.setMemberId(id);
			vo.setMemberPw(pw);
			int result = memberService.pwUpdate(vo);
			if(result == 1) {
				return "success";
			}
		}
		return "fail";
	} // end newPwUpdate()
	
} // end MemberController
