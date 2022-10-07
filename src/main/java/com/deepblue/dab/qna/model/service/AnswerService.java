package com.deepblue.dab.qna.model.service;

import java.util.ArrayList;

import com.deepblue.dab.qna.model.vo.Answer;

public interface AnswerService {
	ArrayList<Answer> replyList(int a_ref); // 댓글 등록
	int insertreplyWriter(Answer answer); // 댓글 등록
	int updatereplyModify(Answer answer); // 댓글 수정
	int replyDelete(Answer answer); // 댓글삭제
	Answer selectAnswer(int a_ref);


}
