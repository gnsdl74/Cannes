package com.cannes.movie.domain;

import java.util.Date;

import com.cannes.movie.pageutil.PageMaker;

public class ReplyVO {
	private int replyNo;
	private String memberId;
	private int movieNo;
	private String replyContent;
	private Date replyDate;
	private int replyGrade;
	private PageMaker pageMaker;
	// 생성자
	public ReplyVO() {}
	public ReplyVO(int replyNo, String memberId, int movieNo, String replyContent, Date replyDate, int replyGrade) {
		this.replyNo = replyNo;
		this.memberId = memberId;
		this.movieNo = movieNo;
		this.replyContent = replyContent;
		this.replyDate = replyDate;
		this.replyGrade = replyGrade;
	}
	// end 생성자
	
	// getter, setter
	public int getReplyNo() {
		return replyNo;
	}
	public void setReplyNo(int replyNo) {
		this.replyNo = replyNo;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public int getMovieNo() {
		return movieNo;
	}
	public void setMovieNo(int movieNo) {
		this.movieNo = movieNo;
	}
	public String getReplyContent() {
		return replyContent;
	}
	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}
	public Date getReplyDate() {
		return replyDate;
	}
	public void setReplyDate(Date replyDate) {
		this.replyDate = replyDate;
	}
	public int getReplyGrade() {
		return replyGrade;
	}
	public void setReplyGrade(int replyGrade) {
		this.replyGrade = replyGrade;
	};
	public PageMaker getPageMaker() {
		return pageMaker;
	}
	public void setPageMaker(PageMaker pageMaker) {
		this.pageMaker = pageMaker;
	}
	// end getter, setter
	
	
	
	@Override
	public String toString() {
		String str = "댓글 번호 : " + replyNo + "\n"
					+ "회원 번호 : " + memberId + "\n"
					+ "영화 번호 : " + movieNo + "\n"
					+ "댓글 내용 : " + replyContent + "\n"
					+ "댓글 작성일 : " + replyDate + "\n"
					+ "댓글 평점 : " + replyGrade;
		return str;
	} // end toString()
	
	
} // end ReplyVO
