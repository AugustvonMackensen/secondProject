package com.deepblue.dab.qna.model.service;

import java.util.ArrayList;

import com.deepblue.dab.common.Paging;
import com.deepblue.dab.qna.model.vo.QNA;

public interface QNAService {	// 번호로 상세보기
	int updateAddReadcount(int q_no); // 조회수 1증가 
	int selectListCount();
	ArrayList<QNA> selectList(Paging page);
	QNA selectQNA(int q_no);
	ArrayList<QNA> selectAll();

}
