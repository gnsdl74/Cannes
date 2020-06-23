package com.cannes.movie.persistance;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cannes.movie.domain.BookingVO;
import com.cannes.movie.domain.TicketVO;

@Repository
public class TicketDAOImple implements TicketDAO {
	
	private static final String NAMESPACE =
			"com.cannes.movie.TicketMapper";
	private static final Logger logger = LoggerFactory.getLogger(TicketDAOImple.class);
	
	@Autowired
	private SqlSession sqlSession;	
	
	@Override
	public int ticketInsert(TicketVO vo) {
		logger.info("ticketInsert 호출");
		return sqlSession.insert(NAMESPACE + ".ticketInsert", vo);
	} // end ticketInsert()

	@Override
	public List<TicketVO> ticketSelectAll() {
		logger.info("ticketSelectAll 호출");
		return sqlSession.selectList(NAMESPACE + ".ticketSelectAll");
	} // end ticketSelectAll()

	@Override
	public List<BookingVO> ticketSelectByMember(int memberNo) {
		logger.info("ticketSelectByMember 호출");
		return sqlSession.selectList(NAMESPACE + ".ticketSelectByMember", memberNo);
	} // end ticketSelectByMember()

	@Override
	public TicketVO ticketSelectByNo(int ticketNo) {
		logger.info("ticketSelectByNo 호출");
		return sqlSession.selectOne(NAMESPACE + ".ticketSelectByNo", ticketNo);
	} // end ticketSelectByNo()

	@Override
	public int ticketDelete(int ticketNo) {
		logger.info("ticketDelete 호출");
		return sqlSession.delete(NAMESPACE + ".ticketDelete", ticketNo);
	} // end ticketDelete()

} // end TicketDAOImple
