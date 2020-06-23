package com.cannes.movie.service;

import java.util.List;

import com.cannes.movie.domain.MemberVO;

public interface MemberService {
	/* 관리자용 메소드 */
	List<MemberVO> readAll(); // 전체 회원 목록
	List<MemberVO> readById_Name_Phone(String keyword); // 아이디, 이름, 핸드폰번호로 회원 찾기
	
	/* 회원용 메소드 */
	MemberVO readDetail(MemberVO vo); // 회원 세부정보
	MemberVO readDetailById(String id); // 회원 세부정보(아이디로만 가져오기)
	int create(MemberVO vo); // 회원 가입
	int update(MemberVO vo); // 회원정보 수정
	int pwUpdate(MemberVO vo); // 비밀번호 찾기 후 비밀번호 변경
	int delete(MemberVO vo); // 회원 탈퇴
	String readById(String id); // 회원 아이디 중복확인
	MemberVO readFindId(MemberVO vo); // 회원 아이디 찾기
	MemberVO readFindPw(MemberVO vo); // 회원 비밀번호 찾기
	
} // end MemberService
