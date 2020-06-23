package com.cannes.movie.domain;

import java.util.Date;

public class MovieVO {
	private int movieNo;
	private String movieType;
	private int movieAge;
	private String movieTitle;
	private String movieContent;
	private String movieDirector;
	private String movieActor;
	private Date movieDate;
	private String moviePoster;
	private String movieVideo;
	private int movieCount;
	
	// 생성자
	public MovieVO() {}
	public MovieVO(int movieNo, String movieType, int movieAge, String movieTitle, String movieContent,
			String movieDirector, String movieActor, Date movieDate, String moviePoster, String movieVideo) {
		super();
		this.movieNo = movieNo;
		this.movieType = movieType;
		this.movieAge = movieAge;
		this.movieTitle = movieTitle;
		this.movieContent = movieContent;
		this.movieDirector = movieDirector;
		this.movieActor = movieActor;
		this.movieDate = movieDate;
		this.moviePoster = moviePoster;
		this.movieVideo = movieVideo;
	}
	// end 생성자
	
	// getter, setter
	public int getMovieNo() {
		return movieNo;
	}
	public void setMovieNo(int movieNo) {
		this.movieNo = movieNo;
	}
	public String getMovieType() {
		return movieType;
	}
	public void setMovieType(String movieType) {
		this.movieType = movieType;
	}
	public int getMovieAge() {
		return movieAge;
	}
	public void setMovieAge(int movieAge) {
		this.movieAge = movieAge;
	}
	public String getMovieTitle() {
		return movieTitle;
	}
	public void setMovieTitle(String movieTitle) {
		this.movieTitle = movieTitle;
	}
	public String getMovieContent() {
		return movieContent;
	}
	public void setMovieContent(String movieContent) {
		this.movieContent = movieContent;
	}
	public String getMovieDirector() {
		return movieDirector;
	}
	public void setMovieDirector(String movieDirector) {
		this.movieDirector = movieDirector;
	}
	public String getMovieActor() {
		return movieActor;
	}
	public void setMovieActor(String movieActor) {
		this.movieActor = movieActor;
	}
	public Date getMovieDate() {
		return movieDate;
	}
	public void setMovieDate(Date movieDate) {
		this.movieDate = movieDate;
	}
	public String getMoviePoster() {
		return moviePoster;
	}
	public void setMoviePoster(String moviePoster) {
		this.moviePoster = moviePoster;
	}
	public String getMovieVideo() {
		return movieVideo;
	}
	public void setMovieVideo(String movieVideo) {
		this.movieVideo = movieVideo;
	}
	public int getMovieCount() {
		return movieCount;
	}
	public void setMovieCount(int movieCount) {
		this.movieCount = movieCount;
	}
	// end getter, setter
	
	@Override
	public String toString() {
		String str = "영화 번호 : " + movieNo + "\n"
				+ "영화 장르 : " + movieType + "\n"
				+ "영화 연령 : " + movieAge + "\n"
				+ "영화 제목 : " + movieTitle + "\n"
				+ "영화 내용 : " + movieContent + "\n"
				+ "영화 감독 : " + movieDirector + "\n"
				+ "영화 출연진 : " + movieActor + "\n"
				+ "영화 개봉일 : " + movieDate + "\n"
				+ "영화 포스터 : " + moviePoster + "\n"
				+ "영화 트레일러 : " + movieVideo + "\n"
				+ "영화 총 갯수 : " + movieCount;
		return str;
	} // end toString()
	
} // end MovieVO
