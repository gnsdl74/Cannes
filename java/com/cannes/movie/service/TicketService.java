package com.cannes.movie.service;

import java.util.List;

import com.cannes.movie.domain.BookingVO;
import com.cannes.movie.domain.TicketVO;

public interface TicketService {

	/* 관리자용 메소드 */
	List<TicketVO> readAll(); // 예매내역 전체 가져오기(전체)
	
	/* 공용 메소드(회원, 관리자, 비회원) */
	int create(TicketVO vo); // 결제 후 예매내역 등록
	List<BookingVO> readByMember(int memberNo); // Pay테이블 회원번호로 예매내역 가져오기
	TicketVO readDetail(int ticketNo); // 예매내역 가져오기(해당번호)
	int delete(int ticketNo); // 예매내역 삭제
	
} // end TicketDAO
