package com.cannes.movie.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.cannes.movie.domain.NoticeVO;
import com.cannes.movie.domain.SearchVO;
import com.cannes.movie.pageutil.PageCriteria;
import com.cannes.movie.pageutil.PageMaker;
import com.cannes.movie.service.NoticeService;

@RestController
public class NoticeRESTController {
	private static final Logger logger = LoggerFactory.getLogger(NoticeRESTController.class);
	private PageCriteria c;
	
	@Autowired
	private NoticeService noticeService;
	
	@ResponseBody
	@GetMapping(value = "/notice/search")
	public ResponseEntity<List<NoticeVO>> search(HttpServletRequest request) {
		logger.info("notice search() 호출");
		
		String keyword = (String) request.getParameter("keyword");
		logger.info(keyword);
		
		String page = (String) request.getParameter("page");
		if(page == null) {
			c = new PageCriteria();
		} else {
			c.setPage(Integer.parseInt(page));
		}
		
		// c와 키워드를 같이 묶는 SearchVO
		SearchVO search = new SearchVO(c, keyword);
		
		// 검색한 키워드에 해당하는 List 가져옴
		List<NoticeVO> noticeList = noticeService.readByTitle(search);
		if (noticeList == null || noticeList.size() == 0) {
			return null;
		}
		
		// 리스트의 첫번째 요소에서 총 공지 갯수 가져옴
		int totalCnt = noticeList.get(0).getNoticeCount();
		
		// 페이징 처리를 위한 maker를 설정
		PageMaker maker = new PageMaker();
		maker.setCriteria(c);
		maker.setTotalCount(totalCnt);
		maker.setPageData();
		
		// 리스트의 첫번째 요소에 maker 저장
		noticeList.get(0).setPageMaker(maker);
		
		System.out.println(noticeList);
		
		return new ResponseEntity<List<NoticeVO>>(noticeList, HttpStatus.OK);
	} // end search()
	
} // end NoticeRESTController
