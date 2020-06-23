package com.cannes.movie.persistance;

import java.util.Date;
import java.util.List;

import com.cannes.movie.domain.MovieVO;
import com.cannes.movie.domain.SearchVO;
import com.cannes.movie.pageutil.PageCriteria;

public interface MovieDAO {
	/* 공용 메소드(회원, 관리자, 비회원) */
	List<MovieVO> movieSelectAll(); // 영화 전체 목록(movie 페이지)
	List<MovieVO> movieSelectByTitle(SearchVO search); // 영화 제목 검색
	MovieVO movieSelectDetail(int movieNo); // 영화 세부정보 가져오기
	MovieVO posterSelect(int movieNo); // 영화 포스터정보 가져오기
	List<MovieVO> movieSelectByDate(Date scheduleDate); // 예매 페이지에서 상영중인 영화 제목 가져오기(scheduleDate)
	List<MovieVO> movieSelectBoxOffice(String[] movieNums); // 박스오피스 가져오기(main 페이지)
	List<MovieVO> movieSelectPage(PageCriteria c); // 영화 20개씩 가져오기(movieList 페이지)
	int totalMovie(); // 영화 총 개수
	
	/* 관리자용 메소드 */
	int movieInsert(MovieVO vo); // 영화 등록
	int movieUpdate(MovieVO vo); // 영화 수정
	int movieDelete(int movieNo); // 영화 삭제
	
} // end MovieDAO
