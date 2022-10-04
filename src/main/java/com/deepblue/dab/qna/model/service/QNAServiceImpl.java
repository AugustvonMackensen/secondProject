package com.deepblue.dab.qna.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.deepblue.dab.common.Paging;
import com.deepblue.dab.common.SearchDate;
import com.deepblue.dab.qna.model.dao.QNADao;
import com.deepblue.dab.qna.model.vo.QNA;

@Service("QNAService")
public class QNAServiceImpl implements QNAService {
	@Autowired  //자동 의존성 주입 처리됨 (자동 객체 생성됨)
	private QNADao qnaDao; 
	
	@Override
	public int updateAddReadcount(int q_no) {
		return qnaDao.updateAddReadcount(q_no);
	}

	@Override
	public QNA selectQNA(int q_no) {
		return qnaDao.selectQNA(q_no);
	}

	@Override
	public int selectListCount() {
		return qnaDao.selectListCount();
	}
	@Override
	public ArrayList<QNA> selectAll() {
		return qnaDao.selectList();
	}

	@Override
	public ArrayList<QNA> selectList(Paging page) {
		return qnaDao.selectList(page);
	}

	@Override
	public ArrayList<QNA> selectSearchTitle(String keyword) {
		return qnaDao.selectSearchTitle(keyword);
	}

	@Override
	public ArrayList<QNA> selectSearchWriter(String keyword) {
		return qnaDao.selectSearchWriter(keyword);
	}

	@Override
	public ArrayList<QNA> selectSearchDate(SearchDate date) {
		return qnaDao.selectSearchDate(date);
	}



}
