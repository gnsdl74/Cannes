package com.cannes.movie.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cannes.movie.domain.BookingVO;
import com.cannes.movie.domain.PayVO;
import com.cannes.movie.domain.SeatVO;
import com.cannes.movie.persistance.PayDAO;
import com.cannes.movie.persistance.SeatDAO;

@Service
public class PayServiceImple implements PayService {
	private static final Logger logger = LoggerFactory.getLogger(PayServiceImple.class);
	
	@Autowired
	private PayDAO payDao;
	@Autowired
	private SeatDAO seatDao;
	
	@Override
	public List<PayVO> readAll() {
		logger.info("readAll() 호출"); 
		return payDao.paySelectAll();
	} // end readAll()

	@Override
	public int create(PayVO vo) {
		logger.info("create() 호출");
		return payDao.payInsert(vo);
	} // end create()

	@Override
	public List<PayVO> readByMember(int memberNo) {
		logger.info("readByMember() 호출");
		return payDao.paySelectByMember(memberNo);
	} // end readByMember()

	@Override
	public PayVO readDetail(int payNo) {
		logger.info("readDetail() 호출");
		return payDao.paySelectByPayNo(payNo);
	} // end readDetail()

	@Override
	public int delete(BookingVO vo) {
		logger.info("delete() 호출");
		int payNo = vo.getPayNo();
		String[] seat = vo.getSeatNo().split(",");
		SeatVO seatVO = null;
		int seatNo = 0;
		
		try {
			for(int i =0; i < seat.length; i++) {
				seatNo = Integer.parseInt(seat[i]);			
				seatVO = new SeatVO(seatNo, 0, null, 0, "Y");
				
			int result = seatDao.seatUpdateOfActive(seatVO);
			System.out.println(result);
			// TODO : 트렌젝션 처리
			}
			return payDao.payDelete(payNo);
		} catch (Exception e) {
			logger.info("삭제실패");
			return 0;
		}		
		
	} // end delete()

} // end PayServiceImple
