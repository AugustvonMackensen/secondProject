package com.deepblue.dab.notice.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.deepblue.dab.common.Paging;
import com.deepblue.dab.common.SearchDate;
import com.deepblue.dab.common.SearchPaging;
import com.deepblue.dab.notice.model.vo.Notice;

@Repository("noticeDao")
public class NoticeDao {
	//스프링-마이바티스 연동 객체 사용 : root-context.xml 에 있음
	
	@Autowired
	private SqlSessionTemplate session;
	
	public ArrayList<Notice> selectNewTop3(){
		List<Notice> list = session.selectList("noticeMapper.selectNewTop3");
		return (ArrayList<Notice>)list;
	}
	
	public ArrayList<Notice> selectList(){
		List<Notice> list = session.selectList("noticeMapper.selectAll");
		return (ArrayList<Notice>)list;
	}
	
	public ArrayList<Notice> selectSearchTitle(SearchPaging searchpaging){
		List<Notice> list = session.selectList("noticeMapper.searchTitle", searchpaging);
		return (ArrayList<Notice>)list;
	}
	
	public ArrayList<Notice> selectSearchDate(SearchPaging searchpaging){
		List<Notice> list = session.selectList("noticeMapper.searchDate", searchpaging);
		return (ArrayList<Notice>)list;
	}
	
	//상세보기용 공지글 하나 조회
	public Notice selectOne(int noticeno) {
		return session.selectOne("noticeMapper.selectNotice", noticeno);
	}
	
	//공지글 삭제 처리
	public int delectNotice(int noticeno) {
		return session.delete("noticeMapper.deleteNotice", noticeno);
	}
	
	//새 공지글 등록 처리
	public int insertNotice(Notice notice) {
		return session.insert("noticeMapper.insertNotice", notice);
	}
	
	//기존 공지글 수정 처리
	public int updateNotice(Notice notice) {
		return session.update("noticeMapper.updateNotice", notice);
	}
	
	// 페이징 부분
	public ArrayList<Notice> selectList(Paging page) {
		List<Notice> list = session.selectList("noticeMapper.selectList", page);
		return (ArrayList<Notice>)list;
	}

	public int updateAddReadcount(int noticeno) {
		return session.update("noticeMapper.addReadCount", noticeno);
	}

	public int selectListCount() {
		return session.selectOne("noticeMapper.getListCount");
	}

	public int selectSearchTListCount(String keyword) {
		return session.selectOne("noticeMapper.getSearchTListCount", keyword);
	}

	public int selectSearchDListCount(SearchDate date) {
		return session.selectOne("noticeMapper.getSearchDListCount", date);
	}

}
