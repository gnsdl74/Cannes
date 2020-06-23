package com.cannes.movie.domain;

import java.util.Date;

public class BookingVO {
	private int ticketNo;
	private int payNo;
	private String seatNo;
	private Date payDate;
	private Date scheduleDate;
	private String scheduleTime;
	private String movieTitle;
	private String moviePoster;
	private String movieShowtime;
	private String theaterName;
	
	// 생성자
	public BookingVO(){}
	public BookingVO(int ticketNo,int payNo, String seatNo, Date payDate, Date scheduleDate, String scheduleTime,
			String movieTitle, String moviePoster, String movieShowtime, String theaterName) {
		super();
		this.ticketNo = ticketNo;
		this.payNo = payNo;
		this.seatNo = seatNo;
		this.payDate = payDate;
		this.scheduleDate = scheduleDate;
		this.scheduleTime = scheduleTime;
		this.movieTitle = movieTitle;
		this.moviePoster = moviePoster;
		this.movieShowtime = movieShowtime;
		this.theaterName = theaterName;
	}
	
	// getter/setter
	public int getTicketNo() {
		return ticketNo;
	}
	public void setTicketNo(int ticketNo) {
		this.ticketNo = ticketNo;
	}
	public int getPayNo() {
		return payNo;
	}
	public void setPayNo(int payNo) {
		this.payNo = payNo;
	}
	public String getSeatNo() {
		return seatNo;
	}
	public void setSeatNo(String seatNo) {
		this.seatNo = seatNo;
	}
	public Date getPayDate() {
		return payDate;
	}
	public void setPayDate(Date payDate) {
		this.payDate = payDate;
	}
	public Date getScheduleDate() {
		return scheduleDate;
	}
	public void setScheduleDate(Date scheduleDate) {
		this.scheduleDate = scheduleDate;
	}
	public String getScheduleTime() {
		return scheduleTime;
	}
	public void setScheduleTime(String scheduleTime) {
		this.scheduleTime = scheduleTime;
	}
	public String getMovieTitle() {
		return movieTitle;
	}
	public void setMovieTitle(String movieTitle) {
		this.movieTitle = movieTitle;
	}
	public String getMoviePoster() {
		return moviePoster;
	}
	public void setMoviePoster(String moviePoster) {
		this.moviePoster = moviePoster;
	}
	public String getMovieShowtime() {
		return movieShowtime;
	}
	public void setMovieShowtime(String movieShowtime) {
		this.movieShowtime = movieShowtime;
	}
	public String getTheaterName() {
		return theaterName;
	}
	public void setTheaterName(String theaterName) {
		this.theaterName = theaterName;
	}
	


	@Override
	public String toString() {
		String str = "ticketNo : " + ticketNo + "\n" +
					 "payNo : " + payNo + "\n" +
					 "seatNo : " + seatNo + "\n" +
					 "payDate : " + payDate + "\n" +
					 "scheduleDate : " + scheduleDate + "\n" +
					 "scheduleTime : " + scheduleTime + "\n" +
					 "movieTitle : " + movieTitle + "\n" +
					 "moviePoster : " + moviePoster + "\n" +
					 "movieShowtime : " + movieShowtime + "\n" +
					 "theaterName : " + theaterName + "\n";
		return str;
	} // end toString()
	
} // end BookingVO
