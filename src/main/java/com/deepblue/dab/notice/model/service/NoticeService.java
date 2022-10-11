package com.deepblue.dab.notice.model.service;

import java.util.ArrayList;

import com.deepblue.dab.common.Paging;
import com.deepblue.dab.common.SearchDate;
import com.deepblue.dab.common.SearchPaging;
import com.deepblue.dab.notice.model.vo.Notice;

public interface NoticeService {
	ArrayList<Notice> selectAll();
	Notice selectNotice(int noticeno);
	int insertNotice(Notice notice);
	int updateNotice(Notice notice);
	int deleteNotice(int noticeno);
	int updateAddReadcount(int noticeno);  //상세보기시에 조회수 1증가 처리용
	int selectListCount();	//총 게시글 갯수 조회용(페이지 수 계산용)
	ArrayList<Notice> selectNewTop3();
	ArrayList<Notice> selectSearchTitle(SearchPaging searchpaging);
	ArrayList<Notice> selectSearchDate(SearchPaging searchpaging);
	ArrayList<Notice> selectList(Paging page);  //한 페이지 출력할 공지사항 조회용
	int selectSearchTListCount(String keyword);
	int selectSearchDListCount(SearchDate date);

}
