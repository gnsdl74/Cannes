package com.cannes.movie.domain;

import java.util.Date;

public class PayVO {
	private int payNo;
	private int memberNo;
	private String payType;
	private int payPrice;
	private Date payDate;
	
	// 생성자
	public PayVO() {}
	public PayVO(int payNo, int memberNo, String payType, int payPrice, Date payDate) {
		super();
		this.payNo = payNo;
		this.memberNo = memberNo;
		this.payType = payType;
		this.payPrice = payPrice;
		this.payDate = payDate;
	}
	// end 생성자
	
	// getter, setter
	public int getPayNo() {
		return payNo;
	}
	public void setPayNo(int payNo) {
		this.payNo = payNo;
	}
	public int getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	public String getPayType() {
		return payType;
	}
	public void setPayType(String payType) {
		this.payType = payType;
	}
	public int getPayPrice() {
		return payPrice;
	}
	public void setPayPrice(int payPrice) {
		this.payPrice = payPrice;
	}
	public Date getPayDate() {
		return payDate;
	}
	public void setPayDate(Date payDate) {
		this.payDate = payDate;
	}
	// end getter, setter

	@Override
	public String toString() {
		String str = "결제 번호 : " + payNo + "\n"
					+ "회원 번호 : " + memberNo + "\n"
					+ "결제 방법 : " + payType + "\n"
					+ "결제 금액 : " + payPrice + "\n"
					+ "결제일 : " + payDate;
		return str;
	} // end toString()
	
} // end PayVO
