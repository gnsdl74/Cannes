package com.cannes.movie.domain;

public class SeatVO {
	private int seatNo;
	private int scheduleNo;
	private String seatRow;
	private int seatColumn;
	private String seatActive;
	
	// 생성자
	public SeatVO() {}
	public SeatVO(int seatNo, int scheduleNo, String seatRow, int seatColumn, String seatActive) {
		super();
		this.seatNo = seatNo;
		this.scheduleNo = scheduleNo;
		this.seatRow = seatRow;
		this.seatColumn = seatColumn;
		this.seatActive = seatActive;
	}
	// end 생성자
	
	// getter, setter
	public int getSeatNo() {
		return seatNo;
	}
	public void setSeatNo(int seatNo) {
		this.seatNo = seatNo;
	}
	public int getScheduleNo() {
		return scheduleNo;
	}
	public void setScheduleNo(int scheduleNo) {
		this.scheduleNo = scheduleNo;
	}
	public String getSeatRow() {
		return seatRow;
	}
	public void setSeatRow(String seatRow) {
		this.seatRow = seatRow;
	}
	public int getSeatColumn() {
		return seatColumn;
	}
	public void setSeatColumn(int seatColumn) {
		this.seatColumn = seatColumn;
	}
	public String getSeatActive() {
		return seatActive;
	}
	public void setSeatActive(String seatActive) {
		this.seatActive = seatActive;
	}
	// end getter, setter
	
	@Override
	public String toString() {
		String str = "좌석 번호 : " + seatNo + "\n"
					+ "상영관 번호 : " + scheduleNo + "\n"
					+ "좌석 행 : " + seatRow + "\n"
					+ "좌석 열 : " + seatColumn + "\n"
					+ "좌석 배정 유/무 : " + seatActive;
		return str;
	} // end toString()
	
} // end SeatVO
