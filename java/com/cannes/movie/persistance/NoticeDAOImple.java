package com.cannes.movie.persistance;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cannes.movie.domain.NoticeVO;
import com.cannes.movie.domain.SearchVO;
import com.cannes.movie.pageutil.PageCriteria;

@Repository
public class NoticeDAOImple implements NoticeDAO {
	private static final String NAMESPACE =
			"com.cannes.movie.NoticeMapper";
	
	private static final Logger logger = LoggerFactory.getLogger(NoticeDAOImple.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<NoticeVO> noticeSelectAll() {
		logger.info("noticeSelectAll() 호출");
		return sqlSession.selectList(NAMESPACE + ".noticeSelectAll");
	} // end noticeSelectAll()

	@Override
	public List<NoticeVO> noticeSelectByTitle(SearchVO search) {
		logger.info("noticeSelectByTitle() 호출");
		
		search.setKeyword("%" + search.getKeyword() + "%");
		return sqlSession.selectList(NAMESPACE + ".noticeSelectByTitle", search);
	} // end noticeSelectByTitle()

	@Override
	public NoticeVO noticeSelectDetail(int noticeNo) {
		logger.info("noticeSelectDetail() 호출");
		return sqlSession.selectOne(NAMESPACE + ".noticeSelectDetail", noticeNo);
	} // end noticeSelectDetail()

	@Override
	public int noticeInsert(NoticeVO vo) {
		logger.info("noticeInsert() 호출");
		return sqlSession.insert(NAMESPACE + ".noticeInsert", vo);
	} // end noticeInsert()

	@Override
	public int noticeUpdate(NoticeVO vo) {
		logger.info("noticeUpdate() 호출");
		return sqlSession.update(NAMESPACE, vo);
	} // end noticeUpdate()

	@Override
	public int noticeDelete(int noticeNo) {
		logger.info("noticeDelete() 호출");
		return sqlSession.delete(NAMESPACE, noticeNo);
	} // end noticeDelete()

	@Override
	public List<NoticeVO> noticeSelectPage(PageCriteria c) {
		logger.info("select_paging() 호출 : page = " + c.getPage());
		return sqlSession.selectList(NAMESPACE + ".paging", c);
	} // end selectPage()

	@Override
	public int getTotalNumsOfRecords() {
		logger.info("getTotalNumsOfRecords() 호출");
		return sqlSession.selectOne(NAMESPACE + ".total_count");
	} // end getTotalNumsOfRecords()

} // end NoticeDAOImple
