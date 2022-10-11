package com.deepblue.dab.qna.controller;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.deepblue.dab.qna.model.service.AnswerService;
import com.deepblue.dab.qna.model.vo.Answer;


@Controller
public class AnswerController {
	private static final Logger logger = 
			LoggerFactory.getLogger(AnswerController.class);
		
	@Autowired
	private AnswerService answerService;
	
	@RequestMapping(value="reply.do", method=RequestMethod.POST)
	public String insertreplyWriter(Answer answer, 
			@RequestParam("page") int page, Model model) {
		logger.info("answer : " + answer );
		if(answerService.insertreplyWriter(answer) > 0) {
			return "redirect:qnadetail.do?q_no="+answer.getA_ref() +"&page=" + page;
			
		}else {
			model.addAttribute("message", 
					answer.getA_ref() + "번 글에 대한 댓글 등록 실패");
			return "common/error";
			
		}
	}
	@RequestMapping("aupview.do")
	public String moveAnswerUpdateView(
			@RequestParam("a_ref") int a_ref,
			@RequestParam("page") int currentPage, 
			Model model) {
		//수정페이지로 보낼 Board 객체 정보 조회함
		Answer answer = answerService.selectAnswer(a_ref);
		if(answer != null) {
			model.addAttribute("answer", answer);
			// currentPage 값을 page 로 값을 전달
			model.addAttribute("page", currentPage);
			return "qna/qnaReplyUpdateForm";
		}else {
			model.addAttribute("message", 
					a_ref + "번 글 수정페이지로 이동 실패");
			return "common/error";
		}
	}
	
	//댓글, 대댓글 수정 처리용
	@RequestMapping(value="areplyup.do", method=RequestMethod.POST)
	public String updatereplyModify(Answer answer, 
			@RequestParam("page") int page, Model model) {
		if(answerService.updatereplyModify(answer) > 0) {
			//댓글, 대댓글 수정 성공시 다시 상세페이지가 보여지게 한다면
			model.addAttribute("q_no", answer.getA_ref());
			model.addAttribute("page", page);
			return "redirect:qnadetail.do";
		}else {
			model.addAttribute("message", 
					answer.getA_ref() + "번 글 수정 실패");
			return "common/error";
		}
	}
	
	
	
	@RequestMapping("adel.do")
	public String replyDelete(Answer answer,
			HttpServletRequest request, Model model) {
		
		if(answerService.replyDelete(answer) > 0) {
			return "redirect:qnadetail.do?q_no="+answer.getA_ref();
		}else {
			model.addAttribute("message", 
					answer.getA_ref() + "번 글 삭제 실패");
			return "common/error";
		}
	}
	
	
}
	
