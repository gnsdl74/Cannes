package com.cannes.movie.persistance;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cannes.movie.domain.TheaterVO;

@Repository
public class TheaterDAOImple implements TheaterDAO {

	private static final String NAMESPACE =
			"com.cannes.movie.TheaterMapper";
	private static final Logger logger = LoggerFactory.getLogger(TheaterDAOImple.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int theaterInsert(TheaterVO vo) {
		logger.info("theaterInsert 호출");
		return sqlSession.insert(NAMESPACE + ".theaterInsert", vo);
	} // end theaterInsert()

	@Override
	public List<TheaterVO> theaterSelectAll() {
		logger.info("theaterSelectAll 호출");
		return sqlSession.selectList(NAMESPACE + ".theaterSelectAll");
	} // end theaterSelectAll()

	@Override
	public TheaterVO theaterSelectByNo(int theaterNo) {
		logger.info("theaterByNo 호출");
		return sqlSession.selectOne(NAMESPACE + ".theaterSelectByNo", theaterNo);
	} // end theaterSelectByNo
	
	@Override
	public int theaterUpdate(TheaterVO vo) {
		logger.info("theaterUpdate 호출");
		return sqlSession.update(NAMESPACE + ".theaterUpdate", vo);
	} // end theaterUpdate()

	@Override
	public int theaterDelete(int theaterNo) {
		logger.info("theaterDelete 호출");
		return sqlSession.delete(NAMESPACE + ".theaterDelete", theaterNo);
	} // end theaterDelete()

	

} // TheaterDAOImple
