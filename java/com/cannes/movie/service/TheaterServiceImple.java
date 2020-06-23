package com.cannes.movie.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.cannes.movie.domain.TheaterVO;
import com.cannes.movie.persistance.TheaterDAO;

@Service
public class TheaterServiceImple implements TheaterService {
	private static final Logger logger = LoggerFactory.getLogger(TheaterServiceImple.class);
	
	@Autowired
	private TheaterDAO theaterDao;
	
	@Override
	public int create(TheaterVO vo) {
		logger.info("create() 호출");
		return theaterDao.theaterInsert(vo);
	} // end create()

	@Override
	public int update(TheaterVO vo) {
		logger.info("update() 호출");
		return theaterDao.theaterUpdate(vo);
	} // end update()

	@Override
	public int delete(int theaterNo) {
		logger.info("delete() 호출");
		return theaterDao.theaterDelete(theaterNo);
	} // end delete()
 
	@Override
	public List<TheaterVO> readAll() {
		logger.info("readAll() 호출");
		return theaterDao.theaterSelectAll();
	} // end readAll()

	@Override
	public TheaterVO readDetail(int theaterNo) {
		logger.info("readDetail() 호출");
		return theaterDao.theaterSelectByNo(theaterNo);
	} // end readDetail

} // end TheaterService
