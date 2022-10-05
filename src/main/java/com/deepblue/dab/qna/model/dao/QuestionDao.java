package com.deepblue.dab.qna.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.deepblue.dab.common.Paging;
import com.deepblue.dab.common.SearchDate;
import com.deepblue.dab.qna.model.vo.Question;

@Repository("QuestionDao")
public class QuestionDao {

	@Autowired
	private SqlSessionTemplate session;


	public Question selectQuestion(int q_no) {
		return session.selectOne("questionMapper.selectQuestion", q_no);
	}

	public int updateAddReadcount(int q_no) {
		return session.update("questionMapper.addReadCount", q_no);
	}

	public int selectListCount() {
		return session.selectOne("questionMapper.getListCount");
	}


	public ArrayList<Question> selectList() {
		List<Question> list = session.selectList("questionMapper.selectAll");
		return (ArrayList<Question>)list;
	}

	public ArrayList<Question> selectList(Paging page) {
		List<Question> list = session.selectList("questionMapper.selectList", page);
		return (ArrayList<Question>)list;
	}

	public ArrayList<Question> selectSearchTitle(String keyword) {
		List<Question> list = session.selectList("questionMapper.searchTitle", keyword);
		return (ArrayList<Question>)list;
	}

	public ArrayList<Question> selectSearchWriter(String keyword) {
		List<Question> list = session.selectList("questionMapper.searchWriter", keyword);
		return (ArrayList<Question>)list;
	}

	public ArrayList<Question> selectSearchDate(SearchDate date) {
		List<Question> list = session.selectList("questionMapper.searchDate", date);
		return (ArrayList<Question>)list;
	}

	public int insertOriginqna(Question qna) {
		return session.insert("questionMapper.insertOrigin", qna);
	}

	public int updateOrigin(Question question) {
		return session.update("questionMapper.updateOrigin", question);
	}

	public int deleteQuestion(Question question) {
		return session.delete("questionMapper.deletequestion", question);
	}

}
