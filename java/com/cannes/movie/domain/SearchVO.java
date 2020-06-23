package com.cannes.movie.domain;

import com.cannes.movie.pageutil.PageCriteria;

public class SearchVO {
	private PageCriteria c;
	private String keyword;
	
	// 생성자
	public SearchVO() {}
	public SearchVO(PageCriteria c, String keyword) {
		super();
		this.c = c;
		this.keyword = keyword;
	}
	// end 생성자
	
	// getter, setter
	public PageCriteria getC() {
		return c;
	}
	public void setC(PageCriteria c) {
		this.c = c;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	// end getter, setter
	
	@Override
	public String toString() {
		String str = "PageCriteria page : " + c.getPage() + "\n"
					+ "Pagecriteria numperpage : " + c.getNumsPerPage() + "\n"
					+ "검색 keyword : " + keyword;
		return str;
	} // end toString()
	
} // end SearchVO
