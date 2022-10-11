package com.deepblue.dab.qna.model.service;

import java.util.ArrayList;

import com.deepblue.dab.common.Paging;
import com.deepblue.dab.common.SearchDate;
import com.deepblue.dab.qna.model.vo.Question;

public interface QuestionService {	// 번호로 상세보기
	int updateAddReadcount(int q_no); // 조회수 1증가 
	int selectListCount();
	ArrayList<Question> selectList(Paging page);
	Question selectQuestion(int q_no); // 번호로 상세보기
	ArrayList<Question> selectAll();
	ArrayList<Question> selectSearchTitle(String keyword); // 제목검색
	ArrayList<Question> selectSearchDate(SearchDate date); // 날자 검색
	int insertOriginqna(Question qna); // 게시글 등록
	int updateOrigin(Question question); // 게시글 수정
	int deletequestion(Question question);  //게시글 삭제용
}
