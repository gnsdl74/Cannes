package com.cannes.movie.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cannes.movie.domain.ReplyVO;
import com.cannes.movie.pageutil.PageCriteria;
import com.cannes.movie.persistance.ReplyDAO;

@Service
public class ReplyServiceImple implements ReplyService{
	private static final Logger logger = LoggerFactory.getLogger(ReplyServiceImple.class);
	
	@Autowired
	private ReplyDAO replyDao;
	
	@Override
	public int create(ReplyVO vo) {
		logger.info("create() 호출");
		return replyDao.replyInsert(vo);
	} // end create()

	@Override
	public List<ReplyVO> readAll(int movieNo) {
		logger.info("readAll() 호출");
		return replyDao.replySelectAll(movieNo);
	} // end readAll()
	
	@Override
	public List<ReplyVO> readByMemberId(String memberId) {
		logger.info("readByMemberId() 호출");
		return replyDao.replySelectByMemberId(memberId);
	} // end readByMemberNo
	
	@Override
	public List<ReplyVO> readPage(PageCriteria c) {
		logger.info("readPage() 호출");
		return replyDao.replySelectPage(c);
	} // end readPage()
	
	@Override
	public int update(ReplyVO vo) {
		logger.info("update() 호출");
		return replyDao.replyUpdate(vo);
	} // end update()

	@Override
	public int delete(int replyNo) {
		logger.info("delete() 호출");
		return replyDao.replyDelete(replyNo);
	} // end delete()

	@Override
	public int getTotalNumByMovieNo(int movieNo) {
		logger.info("readCountByMovieNo() 호출");
		return replyDao.getTotalNumByMovieNo(movieNo);
	} // end readCountByMovieNo

	

	

} // end ReplyServiceImple
