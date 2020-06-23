package com.cannes.movie.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cannes.movie.domain.MovieVO;
import com.cannes.movie.domain.SearchVO;
import com.cannes.movie.pageutil.PageCriteria;
import com.cannes.movie.service.MovieService;

@Controller
public class MovieController {
	private static final Logger logger = LoggerFactory.getLogger(MovieController.class);
	// 메인화면에 나타낼 공지사항을 가져올 준비
	private static PageCriteria c;

	@Autowired
	private MovieService movieService;
	
	
	// 영화 전체 목록 페이지
	@GetMapping(value = "/movieList")
	public String movieList(Model model) {
		logger.info("movieMain() 호출");

		// 영화목록 가져오기(20개씩)
		c = new PageCriteria(1, 20);
		List<MovieVO> list = movieService.readPage(c);
		System.out.println(list);
		
		model.addAttribute("movieAll", list);
		model.addAttribute("pageCriteria", c);

		return "/movie/movieList";
	} // end movieList()

	// 영화 상세정보 페이지
	@GetMapping(value = "/movieList/{movieNo}")
	public String movieDetail(@PathVariable("movieNo") int movieNo, Model model) {
		logger.info("movieDetail() 호출");

		System.out.println(movieNo);
		MovieVO result = movieService.readDetail(movieNo);
		
		
		if (result != null) {
			model.addAttribute("movieDetail", result);
			
		} else {
			return "/error";
		}
		return "/movie/movieDetail";
	} // end movieDetail()

	@ResponseBody
	@PostMapping(value = "/movieList/more")
	public List<MovieVO> moreMovie() {
		logger.info("전체영화 더보기 호출");

		if (c != null) {
			c.setPage(c.getPage() + 1);

			System.out.println(c.getPage());

			List<MovieVO> moreList = movieService.readPage(c);
			for (MovieVO vo : moreList) {
				System.out.println(vo);
			}
			return moreList;
		}
		return null;
	} // end moreMovie()

	@ResponseBody
	@PostMapping(value = "/movieList/search")
	public List<MovieVO> searchMovie(HttpServletRequest request, Model model) {
		logger.info("searchMovie() 호출");

		// 검색한 영화 목록을 20개씩 가져오기 위해 1로 변경
		c.setPage(1);

		String keyword = request.getParameter("keyword");

		SearchVO search = new SearchVO(c, keyword);
		List<MovieVO> searchList = movieService.readByTitle(search);
		if (searchList == null || searchList.size() == 0) {
			return null;
		}
		System.out.println(searchList);
		return searchList;
	} // end searchMovie()

	@ResponseBody
	@PostMapping(value = "/movieList/searchMore")
	public List<MovieVO> searchMore(HttpServletRequest request, Model model) {
		logger.info("검색한 영화 더보기 호출");
		
		// 다음 페이지의 영화를 가져오기 위해 +1
		c.setPage(c.getPage() + 1);

		String keyword = request.getParameter("keyword");

		SearchVO searchMore = new SearchVO(c, keyword);
		List<MovieVO> searchMoreList = movieService.readByTitle(searchMore);

		return searchMoreList;
	} // end searchMovie()

} // end MovieController
