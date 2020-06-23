package com.cannes.movie.persistance;

import java.util.Date;
import java.util.List;

import com.cannes.movie.domain.ScheduleDetailVO;
import com.cannes.movie.domain.ScheduleVO;

public interface ScheduleDAO {
	/* 관리자용 메소드 */
	int scheduleInsert(ScheduleVO vo); // 영화 상영일정 등록	
	int scheduleUpdate(ScheduleVO vo); // 영화 상영일정 수정
	int scheduleDelete(int scheduleNo); // 영화 상영일정 삭제
	
	/* 공용 메소드(회원, 관리자, 비회원) */
	List<ScheduleVO> scheduleSelectByMovie(int movieNo); // 영화 상영일정 가져오기(선택영화)
	List<ScheduleVO> scheduleSelectByDate(Date scheduleDate); // 영화 상영일정 가져오기(선택날짜)
	List<ScheduleDetailVO> scheduleDetailSelectByDate(ScheduleDetailVO vo); // 영화 상영일정 새부내용 가져오기(날짜,시간)
	List<ScheduleDetailVO> scheduleDetailSelectByMovie(ScheduleDetailVO vo); // 영화 상영일정 새부내용 가져오기(영화번호1,날짜,시간)
	ScheduleDetailVO scheduleDetailSelectByScheduleNo(int scheduleNo);
} // end ScheduleDAO
