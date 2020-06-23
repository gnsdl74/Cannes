package com.cannes.movie.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.cannes.movie.domain.MemberVO;
import com.cannes.movie.service.MemberService;

@RestController
public class ManagementRESTController {
	private static final Logger logger = LoggerFactory.getLogger(ManagementRESTController.class);
	
	@Autowired
	private MemberService memberService;
	
	// 개인정보수정 페이지에서 비밀번호를 입력했을 때 확인
	@ResponseBody
	@PostMapping(value = "/mypage/confirm")
	public ResponseEntity<MemberVO> confirm(@RequestBody MemberVO vo, HttpServletRequest request) {
		logger.info("mypage confirm() 호출");
		logger.info(vo + "");
		// 아이디와 비밀번호를 보내 회원인지 확인
		MemberVO result = memberService.readDetail(vo);
		System.out.println(result);
		
		if(result != null) {
			System.out.println("null이 아님");
			return new ResponseEntity<MemberVO>(result, HttpStatus.OK);
		} else {
			System.out.println("null임");
			return new ResponseEntity<MemberVO>(result, HttpStatus.NO_CONTENT);
		}
	} // end confirm()
	
	@ResponseBody
	@DeleteMapping(value = "/mypage/goodbye")
	public ResponseEntity<Integer> delete(@RequestBody MemberVO vo, HttpServletRequest request) {
		logger.info("mypage delete() 호출");
		HttpSession session = request.getSession();
		Cookie[] cookies = request.getCookies();
		String id = (String) session.getAttribute("memberId");
		logger.info(id);
		logger.info(vo+"");
		
		vo.setMemberId(id);
		
		int result = memberService.delete(vo);
		
		// 회원탈퇴 성공
		if(result == 1) {
			logger.info("삭제 성공");
			// 세션 및 쿠키 삭제
			session.removeAttribute("memberId");
			for(Cookie coo : cookies) {
				if(coo.getName().equals("Cookie_memberid")) {
					coo.setMaxAge(-1);
				}
			}
			// 해당 결과를 return
			return new ResponseEntity<Integer>(result, HttpStatus.OK);
		} else {
			logger.info("삭제 실패");
			return new ResponseEntity<Integer>(result, HttpStatus.NO_CONTENT);
		}
	} // end delete()
	
	@ResponseBody
	@PutMapping(value = "/mypage/newPwdSettingPage")
	public ResponseEntity<Integer> newPwdSettingPage(@RequestBody MemberVO vo, HttpServletRequest request) {
		logger.info("mypage newPwdSettingPage() 호출");
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("memberId");
		vo.setMemberId(id);
		logger.info("id : " + id + " pw : " + vo.getMemberPw());
		
		
		int result = memberService.pwUpdate(vo);
		
		if(result == 1) {
			session.removeAttribute("memberId");
			return new ResponseEntity<Integer>(result, HttpStatus.OK);
		}
		return null;
	} // end newPwdSettingPage()
	
	@ResponseBody
	@PutMapping(value = "/mypage/registUserInfo")
	public ResponseEntity<Integer> registUserInfo(@RequestBody MemberVO vo) {
		logger.info("mypage registUserInfo() 호출");
		logger.info("정보 업데이트? " + vo);
		
		int result = memberService.update(vo);
		
		if(result == 1) {
			return new ResponseEntity<Integer>(result, HttpStatus.OK);
		}
		return null;
	} // end registUserInfo()
	
} // end ManagementRESTController
