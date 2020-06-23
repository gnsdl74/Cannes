package com.cannes.movie.persistance;

import java.util.List;

import com.cannes.movie.domain.NoticeVO;
import com.cannes.movie.domain.SearchVO;
import com.cannes.movie.pageutil.PageCriteria;

public interface NoticeDAO {
	/* 공용 메소드(회원, 관리자, 비회원) */
	List<NoticeVO> noticeSelectAll(); // 공지 전체 목록
	List<NoticeVO> noticeSelectByTitle(SearchVO search); // keyword에 맞는 공지 가져오기
	NoticeVO noticeSelectDetail(int noticeNo); // 선택한 공지의 세부사항 가져오기
	List<NoticeVO> noticeSelectPage(PageCriteria c); // 공지 전체 목록을 나눠서 가져오기
	int getTotalNumsOfRecords(); // 공지 전체 갯수
	
	/* 관리자용 메소드 */
	int noticeInsert(NoticeVO vo); // 공지사항 등록
	int noticeUpdate(NoticeVO vo); // 공지사항 수정
	int noticeDelete(int noticeNo); // 공지사항 삭제
	
} // end NoticeDAO
