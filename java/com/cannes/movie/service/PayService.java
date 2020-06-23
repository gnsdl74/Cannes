package com.cannes.movie.service;

import java.util.List;

import com.cannes.movie.domain.BookingVO;
import com.cannes.movie.domain.PayVO;

public interface PayService {

	/* 관리자용 메소드 */
	List<PayVO> readAll(); // 전체 결제 내역 가져오기
	
	/* 공용 메소드(회원, 관리자, 비회원) */
	int create(PayVO vo); // 결제 후 내역을 등록하기
	List<PayVO> readByMember(int memberNo); // 회원 결제 내역 가져오기
	PayVO readDetail(int payNo); // 해당 결제번호에 맞는 결제 내역 하나 가져오기
	int delete(BookingVO vo); // 결제 내역 삭제하기
	
} // end PayService
