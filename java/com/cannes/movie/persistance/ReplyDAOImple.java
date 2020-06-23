package com.cannes.movie.persistance;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cannes.movie.domain.ReplyVO;
import com.cannes.movie.pageutil.PageCriteria;

@Repository
public class ReplyDAOImple implements ReplyDAO {
	
	private static final String NAMESPACE =
			"com.cannes.movie.ReplyMapper";
	private static final Logger logger = LoggerFactory.getLogger(ReplyDAOImple.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int replyInsert(ReplyVO vo) {
		logger.info("replyInsert 호출");
		return sqlSession.insert(NAMESPACE + ".replyInsert", vo);
	} // end replyInsert()

	@Override
	public List<ReplyVO> replySelectAll(int movieNo) {
		logger.info("replySelectAll 호출");
		return sqlSession.selectList(NAMESPACE + ".replySelectAll", movieNo);
	} // end replySelectAll()
	
	@Override
	public List<ReplyVO> replySelectByMemberId(String memberId) {
		logger.info("replySelectByMemberId 호출");
		return sqlSession.selectList(NAMESPACE + ".replySelectByMemberId", memberId);
	} // end replySelectByMemberNo
	
	@Override
	public List<ReplyVO> replySelectPage(PageCriteria c) {
		logger.info("replySelectPage 호출");
		return sqlSession.selectList(NAMESPACE + ".replySelectPaging",  c);
	} // end replySelectPage	
	
	@Override
	public int replyUpdate(ReplyVO vo) {
		logger.info("replySelectAll 호출");
		return sqlSession.update(NAMESPACE + ".replyUpdate", vo);
	} // end replyUpdate()

	@Override
	public int replyDelete(int replyNo) {
		logger.info("replyDelete 호출");
		return sqlSession.delete(NAMESPACE + ".replyDelete" , replyNo);
	} // end replyDelete

	@Override
	public int getTotalNumByMovieNo(int movieNo) {
		logger.info("replyCountByMovieNo 호출");
		return sqlSession.selectOne(NAMESPACE + ".replyCountByMovieNo", movieNo);
	} // end replyCountByMovieNo

	



} // end ReplyDAOImple
