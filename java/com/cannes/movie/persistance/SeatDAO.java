package com.cannes.movie.persistance;

import java.util.List;

import com.cannes.movie.domain.SeatVO;

public interface SeatDAO {
	/* 관리자용 메소드 */
	int seatInsert(SeatVO vo); // 좌석 등록
	
	/* 공용 메소드(회원, 관리자, 비회원) */
	List<SeatVO> seatSelectByScheduleNo(int scheduleNo); // 좌석 가져오기(상영관번호)
	SeatVO seatSelectByNo(int seatNo); // 좌석 가져오기(좌석 번호) 
	int seatUpdateOfActive(SeatVO vo); // 좌석 수정
} // end SeatDAO
