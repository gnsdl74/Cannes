package com.cannes.movie.service;

import java.util.Date;
import java.util.List;

import com.cannes.movie.domain.MovieVO;
import com.cannes.movie.domain.SearchVO;
import com.cannes.movie.pageutil.PageCriteria;

public interface MovieService {
	/* 공용 메소드(회원, 관리자, 비회원) */
	List<MovieVO> readAll(); // 영화 전체 목록 (movie 페이지)
	List<MovieVO> readPage(PageCriteria c); // 영화 20개씩 가져오기(movieList 페이지)
	List<MovieVO> readByTitle(SearchVO search); // 영화 제목 검색
	MovieVO readDetail(int movieNo); // 영화 세부정보 가져오기
	MovieVO readPoster(int movieNo); // 영화 포스터정보 가져오기
	List<MovieVO> readByDate(Date scheduleDate); // 선택날짜에 상영중인 영화 제목 가져오기(scheduleDate)
	List<MovieVO> readBoxOffice(String[] movieNums); // 박스오피스 가져오기(main 페이지)
	int readTotalCnt(); // 영화 총 개수
	
	/* 관리자용 메소드 */
	int create(MovieVO vo); // 영화 등록
	int update(MovieVO vo); // 영화 수정
	int delete(int movieNo); // 영화 삭제
	
} // end MovieService
