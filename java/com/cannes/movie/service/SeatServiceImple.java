package com.cannes.movie.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cannes.movie.domain.SeatVO;
import com.cannes.movie.persistance.SeatDAO;

@Service
public class SeatServiceImple implements SeatService {
	private static final Logger logger = LoggerFactory.getLogger(SeatServiceImple.class);
	
	@Autowired
	private SeatDAO seatDao;
	
	@Override
	public int create(SeatVO vo) {
		logger.info("create() 호출");
		return seatDao.seatInsert(vo);
	} // end create()
	
	@Override
	public List<SeatVO> readByScheduleNo(int scheduleNo) {
		logger.info("readByScheduleNo() 호출");
		return seatDao.seatSelectByScheduleNo(scheduleNo);
	} // end readByScheduleNo()
	
	@Override
	public SeatVO readDetail(int seatNo) {
		logger.info("readDetail() 호출");
		return seatDao.seatSelectByNo(seatNo);
	} // end readDetail()

	@Override
	public int updateOfActive(SeatVO vo) {
		logger.info("updateOfActive() 호출");
		return seatDao.seatUpdateOfActive(vo);
	} // end updateOfActive()

	

} // end SeatServiceImple
