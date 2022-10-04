package com.deepblue.dab.qna.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.deepblue.dab.common.Paging;
import com.deepblue.dab.common.SearchDate;
import com.deepblue.dab.qna.model.vo.QNA;

@Repository("QNADao")
public class QNADao {

	@Autowired
	private SqlSessionTemplate session;


	public QNA selectQNA(int q_no) {
		return session.selectOne("qnaMapper.selectQNA", q_no);
	}

	public int updateAddReadcount(int q_no) {
		return session.update("qnaMapper.addReadCount", q_no);
	}

	public int selectListCount() {
		return session.selectOne("qnaMapper.getListCount");
	}


	public ArrayList<QNA> selectList() {
		List<QNA> list = session.selectList("qnaMapper.selectAll");
		return (ArrayList<QNA>)list;
	}

	public ArrayList<QNA> selectList(Paging page) {
		List<QNA> list = session.selectList("qnaMapper.selectList", page);
		return (ArrayList<QNA>)list;
	}

	public ArrayList<QNA> selectSearchTitle(String keyword) {
		List<QNA> list = session.selectList("qnaMapper.searchTitle", keyword);
		return (ArrayList<QNA>)list;
	}

	public ArrayList<QNA> selectSearchWriter(String keyword) {
		List<QNA> list = session.selectList("qnaMapper.searchWriter", keyword);
		return (ArrayList<QNA>)list;
	}

	public ArrayList<QNA> selectSearchDate(SearchDate date) {
		List<QNA> list = session.selectList("qnaMapper.searchDate", date);
		return (ArrayList<QNA>)list;
	}


}
