package com.cannes.movie.domain;

import java.util.Date;

public class ScheduleVO {
	private int scheduleNo;
	private int movieNo;
	private int theaterNo;
	private Date scheduleDate;
	private String scheduleTime;
	
	// 생성자
	public ScheduleVO() {}
	public ScheduleVO(int scheduleNo, int movieNo, int theaterNo, Date scheduleDate, String scheduleTime) {
		super();
		this.scheduleNo = scheduleNo;
		this.movieNo = movieNo;
		this.theaterNo = theaterNo;
		this.scheduleDate = scheduleDate;
		this.scheduleTime = scheduleTime;
	}
	// end 생성자

	// getter, setter
	public int getScheduleNo() {
		return scheduleNo;
	}

	public void setScheduleNo(int scheduleNo) {
		this.scheduleNo = scheduleNo;
	}

	public int getMovieNo() {
		return movieNo;
	}

	public void setMovieNo(int movieNo) {
		this.movieNo = movieNo;
	}

	public int getTheaterNo() {
		return theaterNo;
	}

	public void setTheaterNo(int theaterNo) {
		this.theaterNo = theaterNo;
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
	// end getter, setter
	
	@Override
	public String toString() {
		String str = "상영일자 번호 : " + scheduleNo + "\n"
					+ "영화 번호 : " + movieNo + "\n"
					+ "상영관 번호 : " + theaterNo + "\n"
					+ "상영일자 : " + scheduleDate;
		return str;
	} // end toString()
	
} // end ScheduleVO
