package com.cannes.movie.persistance;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cannes.movie.domain.SeatVO;
@Repository
public class SeatDAOImple implements SeatDAO {

	private static final String NAMESPACE =
			"com.cannes.movie.SeatMapper";
	private static final Logger logger = LoggerFactory.getLogger(SeatDAOImple.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int seatInsert(SeatVO vo) {
		logger.info("seatInsert 호출");
		return sqlSession.insert(NAMESPACE + ".seatInsert", vo);
	} // end seatInsert()
	
	@Override
	public List<SeatVO> seatSelectByScheduleNo(int scheduleNo) {
		logger.info("seatSelectByScheduleNo 호출");		
		return sqlSession.selectList(NAMESPACE + ".seatSelectByScheduleNo", scheduleNo);
	} // end seatSelectByScheduleNo
	
	@Override
	public SeatVO seatSelectByNo(int seatNo) {
		logger.info("seatSelectByNo 호출");
		return sqlSession.selectOne(NAMESPACE + ".seatSelectByNo", seatNo);
	} // end seatSelectByNo()

	@Override
	public int seatUpdateOfActive(SeatVO vo) {
		logger.info("seatUpdateOfActive 호출");
		return sqlSession.update(NAMESPACE + ".seatUpdateOfActive", vo);
	} // end seatUpdateOfActive()

	

} // end SeatDAO
