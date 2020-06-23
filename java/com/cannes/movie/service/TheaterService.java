package com.cannes.movie.service;

import java.util.List;

import com.cannes.movie.domain.TheaterVO;

public interface TheaterService {

	/* 관리자용 메소드 */
	int create(TheaterVO vo); // 상영관 등록
	int update(TheaterVO vo); // 상영관 수정
	int delete(int theaterNo); // 상영관 삭제
	
	/* 공용 메소드(회원, 관리자, 비회원) */
	List<TheaterVO> readAll(); // 상영관 목록 가져오기
	TheaterVO readDetail(int theaterNo); // 상영관 세부 내용 가져오기
} // end TheaterService
