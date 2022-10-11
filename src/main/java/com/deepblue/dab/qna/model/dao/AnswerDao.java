package com.deepblue.dab.qna.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.deepblue.dab.qna.model.vo.Answer;

@Repository("answerDao")
public class AnswerDao {
	@Autowired
	private SqlSessionTemplate session;


	public int insertreplyWriter(Answer answer) {
		return session.insert("answerMapper.replyWrite", answer);
	}

	public int updatereplyModify(Answer answer) {
		return session.update("answerMapper.replyModify", answer);
	}

	public int replyDelete(Answer answer) {
		return session.delete("answerMapper.replyDelete", answer);
	}

	public ArrayList<Answer> replyList(int a_ref) {
		List<Answer> list = session.selectList("answerMapper.replyReply", a_ref);
		return (ArrayList<Answer>)list;
	}

	public Answer selectAnswer(int a_ref) {
		return session.selectOne("answerMapper.selectAnswer", a_ref);
	}


}
