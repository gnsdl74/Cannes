package com.cannes.movie.service;

import java.util.List;

import com.cannes.movie.domain.NoticeVO;
import com.cannes.movie.domain.SearchVO;
import com.cannes.movie.pageutil.PageCriteria;

public interface NoticeService {
	/* 공용 메소드(회원, 관리자, 비회원) */
	List<NoticeVO> readAll(); // 공지 전체 목록
	List<NoticeVO> readByTitle(SearchVO search); // keyword에 맞는 공지 가져오기
	NoticeVO readDetail(int noticeNo); // 선택한 공지의 세부사항 가져오기
	List<NoticeVO> readPage(PageCriteria c); // 공지 전체 목록을 나눠서 가져오기
	int getTotalNumsOfRecords(); // 전체 게시글 갯수가져오기
	
	/* 관리자용 메소드 */
	int create(NoticeVO vo); // 공지사항 등록
	int update(NoticeVO vo); // 공지사항 수정
	int delete(int noticeNo); // 공지사항 삭제
	
} // end NoticeService
