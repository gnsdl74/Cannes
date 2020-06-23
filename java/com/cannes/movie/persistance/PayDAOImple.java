package com.cannes.movie.persistance;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cannes.movie.domain.PayVO;

@Repository
public class PayDAOImple implements PayDAO {
	
	private static final String NAMESPACE =
			"com.cannes.movie.PayMapper";
	private static final Logger logger = LoggerFactory.getLogger(PayDAOImple.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	
	@Override
	public int payInsert(PayVO vo) { 
		logger.info("payInsert 호출");
		System.out.println("스트레스... " + vo.toString());
		return sqlSession.insert(NAMESPACE + ".payInsert", vo );
	} // end payInsert()

	@Override
	public List<PayVO> paySelectAll() {
		logger.info("paySelectAll 호출");
		return sqlSession.selectList(NAMESPACE + ".paySelectAll");
	} // end paySelectAll()
	
	@Override
	public List<PayVO> paySelectByMember(int memberNo) {
		logger.info("paySelectByMember 호출");
		return sqlSession.selectList(NAMESPACE + ".paySelectByMember", memberNo);
	} // end paySelectByMember()

	@Override
	public PayVO paySelectByPayNo(int payNo) {
		logger.info("paySelectByPayNo 호출" );
		return sqlSession.selectOne(NAMESPACE + ".paySelectByPayNo", payNo);
	} // end paySelectByPayNo()

	@Override
	public int payDelete(int payNo) {
		logger.info("payDelete 호출");
		System.out.println("왜안돼? " + payNo);
		return sqlSession.delete(NAMESPACE + ".payDelete", payNo);
	} // end payDelete()

	
} // end PayDAOImple
