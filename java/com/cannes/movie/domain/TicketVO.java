package com.cannes.movie.domain;

public class TicketVO {
	private int ticketNo;
	private int payNo;
	private int scheduleNo;
	private String seatNo;
	private int ticketPrice;
	private String ticketPersonnel;
	
	
	// 생성자
	public TicketVO() {}	
	public TicketVO(int ticketNo, int payNo, int scheduleNo, String seatNo, int ticketPrice, String ticketPersonnel) {
		super();
		this.ticketNo = ticketNo;
		this.payNo = payNo;
		this.scheduleNo = scheduleNo;
		this.seatNo = seatNo;
		this.ticketPrice = ticketPrice;
		this.ticketPersonnel = ticketPersonnel;
	}

	// end 생성자
	
	// getter, setter
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
	public int getScheduleNo() {
		return scheduleNo;
	}
	public void setScheduleNo(int scheduleNo) {
		this.scheduleNo = scheduleNo;
	}
	public String getSeatNo() {
		return seatNo;
	}
	public void setSeatNo(String seatNo) {
		this.seatNo = seatNo;
	}
	public int getTicketPrice() {
		return ticketPrice;
	}
	public void setTicketPrice(int ticketPrice) {
		this.ticketPrice = ticketPrice;
	}
	public String getTicketPersonnel() {
		return ticketPersonnel;
	}
	public void setTicketPersonnel(String ticketPersonnel) {
		this.ticketPersonnel = ticketPersonnel;
	}
	
	// end getter, setter
	
	@Override
	public String toString() {
		String str = "티켓 번호 : " + ticketNo + "\n"
					+ "티켓 결제 번호 : " + payNo + "\n"
					+ "상영일자 번호 : " + scheduleNo + "\n"
					+ "좌석 번호 : " + seatNo + "\n"
					+ "티켓 가격 : " + ticketPrice + "\n"
					+ "티켓 인원 : " + ticketPersonnel;
		return str;
	} // end toString()
	
	
} // end TicketVO
