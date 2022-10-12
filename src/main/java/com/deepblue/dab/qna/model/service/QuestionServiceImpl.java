package com.deepblue.dab.qna.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.deepblue.dab.common.Paging;
import com.deepblue.dab.common.SearchDate;
import com.deepblue.dab.qna.model.dao.QuestionDao;
import com.deepblue.dab.qna.model.vo.Question;

@Service("QuestionService")
public class QuestionServiceImpl implements QuestionService {
	@Autowired  //자동 의존성 주입 처리됨 (자동 객체 생성됨)
	private QuestionDao qnaDao; 
	
	@Override
	public int updateAddReadcount(int q_no) {
		return qnaDao.updateAddReadcount(q_no);
	}

	@Override
	public Question selectQuestion(int q_no) {
		return qnaDao.selectQuestion(q_no);
	}

	@Override
	public int selectListCount() {
		return qnaDao.selectListCount();
	}
	@Override
	public ArrayList<Question> selectAll() {
		return qnaDao.selectList();
	}

	@Override
	public ArrayList<Question> selectList(Paging page) {
		return qnaDao.selectList(page);
	}

	@Override
	public ArrayList<Question> selectSearchTitle(String keyword) {
		return qnaDao.selectSearchTitle(keyword);
	}

	@Override
	public ArrayList<Question> selectSearchDate(SearchDate date) {
		return qnaDao.selectSearchDate(date);
	}

	@Override
	public int insertOriginqna(Question qna) {
		return qnaDao.insertOriginqna(qna);
	}

	@Override
	public int updateOrigin(Question question) {
		return qnaDao.updateOrigin(question);
	}

	@Override
	public int deletequestion(Question question) {
		return qnaDao.deleteQuestion(question);
	}
	
	   @Override
	   public ArrayList<Question> selectSearchWriter(String keyword) {
	      return qnaDao.selectSearchWriter(keyword);
	   }
}
