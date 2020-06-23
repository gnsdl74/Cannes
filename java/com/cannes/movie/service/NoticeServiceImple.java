package com.cannes.movie.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cannes.movie.domain.NoticeVO;
import com.cannes.movie.domain.SearchVO;
import com.cannes.movie.pageutil.PageCriteria;
import com.cannes.movie.persistance.NoticeDAO;

@Service
public class NoticeServiceImple implements NoticeService {
	private static final Logger logger = 
			LoggerFactory.getLogger(NoticeServiceImple.class);
	
	@Autowired
	private NoticeDAO noticeDao;
	
	@Override
	public List<NoticeVO> readAll() {
		logger.info("readAll() 호출");
		return noticeDao.noticeSelectAll();
	} // end readAll()

	@Override
	public List<NoticeVO> readByTitle(SearchVO search) {
		logger.info("readByTitle() 호출");
		return noticeDao.noticeSelectByTitle(search);
	} // end readByTitle()

	@Override
	public NoticeVO readDetail(int noticeNo) {
		logger.info("readDetail() 호출");
		return noticeDao.noticeSelectDetail(noticeNo);
	} // end readDetail()

	@Override
	public List<NoticeVO> readPage(PageCriteria c) {
		logger.info("read_paging() 호출");
		return noticeDao.noticeSelectPage(c);
	} // end readAll()

	@Override
	public int getTotalNumsOfRecords() {
		logger.info("getTotalNumsOfRecords() 호출");
		return noticeDao.getTotalNumsOfRecords();
	} // end getTotalNumsOfRecords()
	
	@Override
	public int create(NoticeVO vo) {
		logger.info("create() 호출");
		return noticeDao.noticeInsert(vo);
	} // end create()

	@Override
	public int update(NoticeVO vo) {
		logger.info("update() 호출");
		return noticeDao.noticeUpdate(vo);
	} // end update()

	@Override
	public int delete(int noticeNo) {
		logger.info("delete() 호출");
		return noticeDao.noticeDelete(noticeNo);
	} // end delete()

} // end NoticeServiceImple
