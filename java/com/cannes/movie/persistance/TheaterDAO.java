package com.cannes.movie.persistance;

import java.util.List;

import com.cannes.movie.domain.TheaterVO;

public interface TheaterDAO {
	
	/* 관리자용 메소드 */
	int theaterInsert(TheaterVO vo); // 상영관 등록	
	int theaterUpdate(TheaterVO vo); // 상영관 수정
	int theaterDelete(int theaterNo); // 상영관 삭제
	
	/* 공용 메소드(회원, 관리자, 비회원) */
	List<TheaterVO> theaterSelectAll(); // 상영관 목록 가져오기
	TheaterVO theaterSelectByNo(int theaterNo);
	
} // end TheaterDAO
