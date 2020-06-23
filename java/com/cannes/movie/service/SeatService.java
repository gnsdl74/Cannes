package com.cannes.movie.service;

import java.util.List;

import com.cannes.movie.domain.SeatVO;

public interface SeatService {

	/* 관리자용 메소드 */
	int create(SeatVO vo); // 좌석 등록
	

	List<SeatVO> readByScheduleNo(int scheduleNo); // 좌석 가져오기(상영관번호)
	SeatVO readDetail(int seatNo); // 좌석 가져오기(좌석 번호) 
	int updateOfActive(SeatVO vo); // 좌석 수정	
	
} // end SeatService
