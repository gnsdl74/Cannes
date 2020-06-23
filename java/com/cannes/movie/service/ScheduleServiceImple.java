package com.cannes.movie.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cannes.movie.domain.ScheduleDetailVO;
import com.cannes.movie.domain.ScheduleVO;
import com.cannes.movie.persistance.ScheduleDAO;

@Service
public class ScheduleServiceImple implements ScheduleService {
	private static final Logger logger =
			LoggerFactory.getLogger(ScheduleServiceImple.class);
	
	@Autowired
	private ScheduleDAO scheduleDao;
	
	@Override
	public int create(ScheduleVO vo) {
		logger.info("create() 호출");
		return scheduleDao.scheduleInsert(vo);
	} // end create

	@Override
	public int update(ScheduleVO vo) {
		logger.info("update() 호출");
		return scheduleDao.scheduleUpdate(vo);
	} // end update

	@Override
	public int delete(int scheduleNo) {
		logger.info("delete() 호출");
		return scheduleDao.scheduleDelete(scheduleNo);
	} // end delete

	@Override
	public List<ScheduleVO> readByMovie(int movieNo) {
		logger.info("readByMovie() 호출");
		return scheduleDao.scheduleSelectByMovie(movieNo);
	} // end readByMovie

	@Override
	public List<ScheduleVO> readByDate(Date scheduleDate) {
		logger.info("readByDate() 호출");
		return scheduleDao.scheduleSelectByDate(scheduleDate);
	} // end readDate()

	@Override
	public List<ScheduleDetailVO> readDetailByDate(ScheduleDetailVO vo) {
		logger.info("readDetailByDate() 호출");
		Date today = new Date(); // 현재 시간
		Date date	= vo.getScheduleDate(); // 입력받은 시간
		
		int result = date.compareTo(today);  // 현재 날짜와 비교해서
		if(result == -1) { //입력받은 시간이 작으면 오늘날짜 00:00시이므로 현재시간 이후를 
								// 입력해줘야 이후 상영되는 영화를 불러온다(쿼리참조) 
			SimpleDateFormat sdfTime = new SimpleDateFormat("HH:mm");
			String currentTime = sdfTime.format(today); // 현재 시간 구하기
			vo.setScheduleTime(currentTime);
		}
		
		return scheduleDao.scheduleDetailSelectByDate(vo);
	} // end readDetail()

	@Override
	public List<ScheduleDetailVO> readDetailByMovie(ScheduleDetailVO vo) {
		logger.info("readDetailByMovie() 호출");

		Date today = new Date(); // 현재 시간
		Date date	= vo.getScheduleDate(); // 입력받은 시간
		
		int result = date.compareTo(today);  // 현재 날짜와 비교해서
		if(result == -1) { //입력받은 시간이 작으면 오늘날짜 00:00시이므로 현재시간 이후를 
								// 입력해줘야 이후 상영되는 영화를 불러온다(쿼리참조) 
			SimpleDateFormat sdfTime = new SimpleDateFormat("HH:mm");
			String currentTime = sdfTime.format(today); // 현재 시간 구하기
			vo.setScheduleTime(currentTime);
		}
		return scheduleDao.scheduleDetailSelectByMovie(vo);
	} // end readDetailByMovie()

	@Override
	public ScheduleDetailVO readDetailByScheduleNo(int scheduleNo) {
		logger.info("readDetailByScheduleNo() 호출");
		return scheduleDao.scheduleDetailSelectByScheduleNo(scheduleNo);
	} // end readDetailByScheduleNo()

} // end ScheduleServiceImple
