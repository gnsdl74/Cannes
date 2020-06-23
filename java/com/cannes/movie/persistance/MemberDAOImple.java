package com.cannes.movie.persistance;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cannes.movie.domain.MemberVO;

@Repository
public class MemberDAOImple implements MemberDAO {
	private static final String NAMESPACE =
			"com.cannes.movie.MemberMapper";
	
	private static final Logger logger = LoggerFactory.getLogger(MemberDAOImple.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<MemberVO> memberSelectAll() {
		logger.info("memberSelectAll() 호출");
		return sqlSession.selectList(NAMESPACE + ".memberSelectAll");
	} // end memberSelectAll()

	@Override
	public List<MemberVO> memberSelectById_Name_Phone(String keyword) {
		logger.info("memberSelectById_Name_Phone() 호출");
		keyword = "%" + keyword + "%";
		return sqlSession.selectList(NAMESPACE + ".memberSelectById_Name_Phone", keyword);
	} // end memberSelectById_Name_Phone

	@Override
	public MemberVO memberSelectDetail(MemberVO vo) {
		logger.info("memberSelectDetail() 호출");
		return sqlSession.selectOne(NAMESPACE + ".memberSelectDetail", vo);
	} // end memberSelectById_Pw

	@Override
	public String memberSelectById(String id) {
		logger.info("memberSelectById() 호출");
		return sqlSession.selectOne(NAMESPACE + ".memberSelectById", id);
	} // end memberSelectById()
	
	@Override
	public MemberVO memberSelectDetailById(String id) {
		logger.info("memberSelectDetailById() 호출");
		return  sqlSession.selectOne(NAMESPACE + ".memberSelectDetailById", id);
	} // end memberSelectDetailById()
	
	@Override
	public int memberInsert(MemberVO vo) {
		logger.info("memberInsert() 호출");
		return sqlSession.insert(NAMESPACE + ".memberInsert", vo);
	} // end memberInsert()

	@Override
	public int memberUpdate(MemberVO vo) {
		logger.info("memberUpdate() 호출");
		return sqlSession.update(NAMESPACE + ".memberUpdate", vo);
	} // end memberUpdate()

	@Override
	public int memberDelete(MemberVO vo) {
		logger.info("memberDelete() 호출");
		return sqlSession.delete(NAMESPACE + ".memberDelete", vo);
	} // end memberDelete()

	@Override
	public MemberVO memberSelectFindId(MemberVO vo) {
		logger.info("memberSelectFindId() 호출");
		logger.info(vo + " : 아이디찾기");
		return sqlSession.selectOne(NAMESPACE + ".memberSelectFindId", vo);
	}

	@Override
	public MemberVO memberSelectFindPw(MemberVO vo) {
		logger.info("memberSelectFindPw() 호출");
		logger.info(vo + " : 비밀번호찾기");
		return sqlSession.selectOne(NAMESPACE + ".memberSelectFindPw", vo);
	}

	@Override
	public int memberPwUpdate(MemberVO vo) {
		logger.info("memberPwUpdate() 호출");
		return sqlSession.update(NAMESPACE + ".memberPwUpdate", vo);
	}

} // end MemberDAOImple
