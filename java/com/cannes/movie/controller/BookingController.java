package com.cannes.movie.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.catalina.servlet4preview.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cannes.movie.domain.BookingVO;
import com.cannes.movie.domain.MemberVO;
import com.cannes.movie.domain.MovieVO;
import com.cannes.movie.domain.PayVO;
import com.cannes.movie.domain.ScheduleDetailVO;
import com.cannes.movie.domain.SeatVO;
import com.cannes.movie.domain.TicketVO;
import com.cannes.movie.service.MemberService;
import com.cannes.movie.service.MovieService;
import com.cannes.movie.service.PayService;
import com.cannes.movie.service.ScheduleService;
import com.cannes.movie.service.SeatService;
import com.cannes.movie.service.TicketService;

@Controller
@RequestMapping(value = "/booking")
public class BookingController {
	private static final Logger logger = LoggerFactory.getLogger(BookingController.class);

	@Autowired
	private MovieService movieService;
	@Autowired
	private ScheduleService scheduleService;
	@Autowired
	private SeatService seatService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private PayService payService;
	@Autowired
	private TicketService ticketService;
	
	@GetMapping
	public String booking(Model model) {
		logger.info("bookingMain() 호출");

		// 현재 이후 상영중인 영화제목 가져오기
		Date today = new Date();

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String sdfToday = sdf.format(today);

		SimpleDateFormat sdfTime = new SimpleDateFormat("HH:mm");
		String currentTime = sdfTime.format(today); // 현재 시간 구하기
		today = null;
		try {
			today = sdf.parse(sdfToday); // 오늘 날짜 00:00분으로 변경
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		logger.info("오늘날짜 : " + today);
		logger.info("현재시간 : " + currentTime);

		List<MovieVO> movieList = movieService.readByDate(today); // 상영중인 영화만 출력

		ScheduleDetailVO scheduleVO = new ScheduleDetailVO(0, today, currentTime,null, null, null, null, 0, 0, 0);
		List<ScheduleDetailVO> scheduleList = scheduleService.readDetailByDate(scheduleVO); // 오늘 날짜 현재시간 이후의 영화 가져오기
		for (ScheduleDetailVO vo : scheduleList) {
			logger.info(vo.toString());
		}
		model.addAttribute("movieList", movieList);
		model.addAttribute("scheduleList", scheduleList);

		return "booking/booking";
	} // end ticketingMain()

	@ResponseBody
	@GetMapping(value = "/movies/{strDate}")
	public ResponseEntity<List<MovieVO>> readMovieListByDate(@PathVariable String strDate) {
		logger.info("readMovieListByDate() 호출");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Date date = null;
		try {
			date = sdf.parse(strDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		List<MovieVO> movieList = movieService.readByDate(date); // 상영중인 영화만 출력
		return new ResponseEntity<List<MovieVO>>(movieList, HttpStatus.OK);
	} // end readMovieListByDate()

	@ResponseBody
	@GetMapping(value = "/moviePoster/{movieNo}")
	public ResponseEntity<MovieVO> readMoviePoster(@PathVariable("movieNo") int movieNo) {
		logger.info("readMoviePoster() 호출");
		MovieVO movieVO = movieService.readPoster(movieNo);

		return new ResponseEntity<MovieVO>(movieVO, HttpStatus.OK);
	} // end readMovies()

	@ResponseBody
	@GetMapping(value = "/schedules/{strDate}")
	public ResponseEntity<List<ScheduleDetailVO>> readScheduleListByDate(@PathVariable String strDate) {
		logger.info("readScheduleListByDate() 호출");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Date date = null;
		try {
			date = sdf.parse(strDate); // 받아온 날짜
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ScheduleDetailVO scheduleVO = new ScheduleDetailVO(0, date, null,null, null, null, null, 0, 0, 0);
		List<ScheduleDetailVO> scheduleList = scheduleService.readDetailByDate(scheduleVO);
		
		return new ResponseEntity<List<ScheduleDetailVO>>(scheduleList, HttpStatus.OK);
	} // end readScheduleListByDate()

	@ResponseBody
	@GetMapping(value = "/schedules/{strDate}/{movieNo}")
	public ResponseEntity<List<ScheduleDetailVO>> readScheduleListByMovie(@PathVariable String strDate,
			@PathVariable int movieNo) {
		logger.info("readScheduleBymovie() 호출");

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd"); //bean으로 생성
		Date date = null;
		try {
			date = sdf.parse(strDate); // 받아온 날짜
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		ScheduleDetailVO scheduleVO = new ScheduleDetailVO(0, date, null, null, null,null, null, 0, 0,movieNo);
		List<ScheduleDetailVO> scheduleList = scheduleService.readDetailByMovie(scheduleVO);

		return new ResponseEntity<List<ScheduleDetailVO>>(scheduleList, HttpStatus.OK);

	} // end readScheduleListByMovie()

	@PostMapping(value = "/seat")
	public String seatMain(int scheduleNo, Model model ,HttpServletRequest request) {
		logger.info("seatMain() 호출");

		List<SeatVO> seatList = seatService.readByScheduleNo(scheduleNo);	
		ScheduleDetailVO scheduleVO = scheduleService.readDetailByScheduleNo(scheduleNo);
	
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		MemberVO memberVO = null;
		if(memberId != null) {
			memberVO = memberService.readDetailById(memberId);	
		}		
		
		model.addAttribute("memberVO", memberVO);
		model.addAttribute("seatList", seatList);		
		model.addAttribute("scheduleDetailVO", scheduleVO);
		return "/booking/seat";
	} // end seatMain()

	
	@PostMapping(value = "result")
	public String payment(PayVO payVO, TicketVO ticketVO, HttpServletRequest request) {
			logger.info("payment() 호출");			
		
			HttpSession session = request.getSession();
			Integer memberNo = (Integer) session.getAttribute("memberNo");
			
			//TODO 회원번호가 null이면 결제 취소기능 추가
			payVO.setMemberNo(memberNo);
			System.out.println(payVO.getMemberNo());
			ticketVO.setTicketPrice(payVO.getPayPrice());
			int payResult = payService.create(payVO);			
			if(payResult == 1) {				
			ticketService.create(ticketVO);
			// TODO : 트렌젝션 처리
			}			
			
		return "redirect:/mypage";
	} // end payment()
	
	
	@ResponseBody
	@DeleteMapping
	public ResponseEntity<Integer> deleteBooking(@RequestBody BookingVO vo){
		logger.info(vo.toString());		
		try {			
			payService.delete(vo);		
			return new ResponseEntity<Integer>(1, HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<Integer>(0, HttpStatus.OK);
		}
		
	}
} // end BookingController
