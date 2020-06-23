package com.cannes.movie.domain;

import java.util.Date;

public class MemberVO {
	private int memberNo;
	private String memberId;
	private String memberPw;
	private String memberName;
	private Date memberBirth;
	private String memberPhone;
	private String memberEmail;
	private String memberActive;
	
	// 생성자
	public MemberVO() {}
	public MemberVO(int memberNo, String memberId, String memberPw, String memberName, Date memberBirth,
			String memberPhone, String memberEmail, String memberActive) {
		super();
		this.memberNo = memberNo;
		this.memberId = memberId;
		this.memberPw = memberPw;
		this.memberName = memberName;
		this.memberBirth = memberBirth;
		this.memberPhone = memberPhone;
		this.memberEmail = memberEmail;
		this.memberActive = memberActive;
	}
	// end 생성자
	
	// getter, setter
	public int getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getMemberPw() {
		return memberPw;
	}
	public void setMemberPw(String memberPw) {
		this.memberPw = memberPw;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public Date getMemberBirth() {
		return memberBirth;
	}
	public void setMemberBirth(Date memberBirth) {
		this.memberBirth = memberBirth;
	}
	public String getMemberPhone() {
		return memberPhone;
	}
	public void setMemberPhone(String memberPhone) {
		this.memberPhone = memberPhone;
	}
	public String getMemberEmail() {
		return memberEmail;
	}
	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}
	public String getMemberActive() {
		return memberActive;
	}
	public void setMemberActive(String memberActive) {
		this.memberActive = memberActive;
	}
	// end getter, setter
	
	@Override
	public String toString() {
		String str = "회원 번호 : " + memberNo + "\n"
					+ "회원 아이디 : " + memberId + "\n"
					+ "회원 비밀번호 : " + memberPw + "\n"
					+ "회원 이름 : " + memberName + "\n"
					+ "회원 생년월일 : " + memberBirth + "\n"
					+ "회원 전화번호 : " + memberPhone + "\n"
					+ "회원 이메일 : " + memberEmail + "\n"
					+ "휴면계정 유/무 : " + memberActive;
		return str;
	} // end toString()
	
} // end MemberVO
