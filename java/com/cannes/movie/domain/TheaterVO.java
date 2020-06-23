package com.cannes.movie.domain;

public class TheaterVO {
	private int theaterNo;
	private String theaterName;
	private int theaterSeat;
	
	// 생성자
	public TheaterVO() {}
	public TheaterVO(int theaterNo, String theaterName, int theaterSeat) {
		super();
		this.theaterNo = theaterNo;
		this.theaterName = theaterName;
		this.theaterSeat = theaterSeat;
	}
	// end 생성자
	
	// getter, setter
	
	public int getTheaterNo() {
		return theaterNo;
	}
	public void setTheaterNo(int theaterNo) {
		this.theaterNo = theaterNo;
	}
	public String getTheaterName() {
		return theaterName;
	}
	public void setTheaterName(String theaterName) {
		this.theaterName = theaterName;
	}
	public int getTheaterSeat() {
		return theaterSeat;
	}
	public void setTheaterSeat(int theaterSeat) {
		this.theaterSeat = theaterSeat;
	}
	// end getter, setter
	
	@Override
	public String toString() {
		String str = "상영관 번호 : " + theaterNo + "\n"
					+ "상영관 이름 : " + theaterName + "\n"
					+ "상영관 좌석수 : " + theaterSeat;
		return str;
	} // end toString()
	
} // TheaterVO
