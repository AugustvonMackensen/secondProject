package com.deepblue.dab.qna.controller;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.deepblue.dab.common.Paging;
import com.deepblue.dab.qna.model.service.QNAService;
import com.deepblue.dab.qna.model.vo.QNA;

@Controller
public class QNAController {
	private static final Logger logger = LoggerFactory.getLogger(QNAController.class);
	
	@Autowired
	private QNAService qnaService;
	
	@RequestMapping("qnaListView.do")
	public ModelAndView qnaListMethod(
			@RequestParam(name="page", required=false) String page,
			ModelAndView mv) {
		
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		

		int limit = 10;  
		int listCount = qnaService.selectListCount();

		int maxPage = (int)((double)listCount / limit + 0.9);

		int startPage = (currentPage / 10) * 10 + 1;
		int endPage = startPage + 10 - 1;
		
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		Paging paging = new Paging(startRow, endRow);
		
		//페이징 계산 처리 끝 ---------------------------------------
		
		ArrayList<QNA> list = qnaService.selectList(paging);
		
		if(list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("listCount", listCount);
			mv.addObject("maxPage", maxPage);
			mv.addObject("currentPage", currentPage);
			mv.addObject("startPage", startPage);
			mv.addObject("endPage", endPage);
			mv.addObject("limit", limit);
			
			mv.setViewName("qna/qnaListView");
		}else {
			mv.addObject("message", 
					currentPage + " 페이지 목록 조회 실패.");
			mv.setViewName("common/error");
		}
		
		return mv;
	}

	// 게시글 상세보기 처리용
	@RequestMapping("qnadetail.do")
	public ModelAndView qnaDetailMethod(ModelAndView mv,
			@RequestParam("q_no") int q_no,
			@RequestParam(name="page", required=false) String page) {
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		
		// 조회수 1증가 처리
		qnaService.updateAddReadcount(q_no);
		
		//해당 게시글 조회
		QNA qna = qnaService.selectQNA(q_no);
		
		if(qna !=null) {
			mv.addObject("question", qna);
			mv.addObject("currentPage", currentPage);
			mv.setViewName("qna/qnaDetailView");
		}else {
			mv.addObject("message", 
					q_no + "번 게시글 조회 실패");
			mv.setViewName("common/error");
		}
		return mv;
	}
	
	
}
