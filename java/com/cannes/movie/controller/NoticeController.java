package com.cannes.movie.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.cannes.movie.domain.NoticeVO;
import com.cannes.movie.pageutil.PageCriteria;
import com.cannes.movie.pageutil.PageMaker;
import com.cannes.movie.service.NoticeService;

@Controller
public class NoticeController {
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);

	@Autowired
	private NoticeService noticeService;

	@GetMapping(value = "/notice")
	public String noticeMain(Model model, Integer page, Integer perPage) {
		logger.info("noticeMain() 호출");

		PageCriteria c = new PageCriteria();
		if (page != null) {
			c.setPage(page);
		}
		if (perPage != null) {
			c.setNumsPerPage(perPage);
		}

		List<NoticeVO> list = noticeService.readPage(c);
		System.out.println(list);
		
		model.addAttribute("noticeList", list);

		PageMaker maker = new PageMaker();
		maker.setCriteria(c);
		maker.setTotalCount(noticeService.getTotalNumsOfRecords());
		maker.setPageData();
		model.addAttribute("pageMaker", maker);
		
		return "/notice/list";
	} // end noticeMain()

	@GetMapping(value = "/detail")
	public String noticeDetail(int noticeNo, Model model, @ModelAttribute("criteria") PageCriteria c, @ModelAttribute("keyword") String keyword) {
		logger.info("detail() 호출");
		NoticeVO vo = noticeService.readDetail(noticeNo);
		System.out.println(vo);
		
		if (vo != null) {
			model.addAttribute("noticeVO", vo);
		}
		return "/notice/detail";
	} // end noticeDetail()
	
} // end NoticeController
