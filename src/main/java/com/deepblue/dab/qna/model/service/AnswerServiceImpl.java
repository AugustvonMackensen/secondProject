package com.deepblue.dab.qna.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.deepblue.dab.qna.model.dao.AnswerDao;
import com.deepblue.dab.qna.model.vo.Answer;

@Service("answerService")
public class AnswerServiceImpl implements AnswerService {
	
	@Autowired
	private AnswerDao answerDao;

	@Override
	public ArrayList<Answer> replyList(int a_ref) {
		return answerDao.replyList(a_ref);
	}

	@Override
	public int insertreplyWriter(Answer answer) {
		return answerDao.insertreplyWriter(answer);
	}

	@Override
	public int updatereplyModify(Answer answer) {
		return answerDao.updatereplyModify(answer);
	}

	@Override
	public int replyDelete(Answer answer) {
		return answerDao.replyDelete(answer);
	}

	@Override
	public Answer selectAnswer(int a_ref) {
		return answerDao.selectAnswer(a_ref);
	}

}
