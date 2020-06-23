package com.cannes.movie.persistance;

import java.util.List;

import com.cannes.movie.domain.ReplyVO;
import com.cannes.movie.pageutil.PageCriteria;

public interface ReplyDAO {	
	/* 공용 메소드(회원, 관리자, 비회원) */
	int replyInsert(ReplyVO vo);  // 영화 감상평 등록 
	List<ReplyVO> replySelectAll(int movieNo); // 영화 감상평 전체 가져오기(해당영화)
	List<ReplyVO> replySelectByMemberId(String memberId); // 영화 감상평 전체 가져오기(해당회원)
	List<ReplyVO> replySelectPage(PageCriteria c); // 영화 감상평 페이징 처리 해서 가져오기
	int replyUpdate(ReplyVO vo); // 영화 감상평 수정
	int replyDelete(int replyNo); // 영화 감상평 삭제	
	int getTotalNumByMovieNo(int movieNo); // 선택 영화의 댓글 개수 가져오기 
} // end ReplyDAO
