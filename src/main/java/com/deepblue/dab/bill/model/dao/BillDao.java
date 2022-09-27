package com.deepblue.dab.bill.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.deepblue.dab.bill.model.vo.Bill;
import com.deepblue.dab.common.SearchDate;

@Repository("noticeDao")
public class BillDao {
	// 스프링-마이바티스(mybatis) 연동 객체 사용 : root-context.xml 에 있음
	
	@Autowired
	private SqlSessionTemplate session;
	
	public ArrayList<Bill> selectNewTop3(){
		List<Bill> list = session.selectList("noticeMapper.selectNewTop3");
		return (ArrayList<Bill>)list;
	}
	
	public ArrayList<Bill> selectList(){
		List<Bill> list = session.selectList("noticeMapper.selectAll");
		return (ArrayList<Bill>)list;
	}
	
	public ArrayList<Bill> selectSearchTitle(String keyword){
		List<Bill> list = session.selectList("noticeMapper.searchTitle", keyword);
		return (ArrayList<Bill>)list;
	}
	
	public ArrayList<Bill> selectSearchWriter(String keyword){
		List<Bill> list = session.selectList("noticeMapper.searchWriter", keyword);
		return (ArrayList<Bill>)list;
	}
	
	public ArrayList<Bill> selectSearchDate(SearchDate date){
		List<Bill> list = session.selectList("noticeMapper.searchDate", date);
		return (ArrayList<Bill>)list;
	}
	
	// 상세보기용 공지글 하나 조회
	public Bill selectOne(int noticeno) {
		return session.selectOne("noticeMapper.selectNotice", noticeno);
	}
	
	// 공지글 삭제 처리
	public int deleteNotice(int noticeno) {
		return session.delete("noticeMapper.deleteNotice", noticeno);
	}
	
	// 새 공지글 등록 처리
	public int insertNotice(Bill notice) {
		return session.insert("noticeMapper.insertNotice", notice);
	}
	
	// 기존 공지글 수정 처리
	public int updateNotice(Bill notice) {
		return session.update("noticeMapper.updateNotice", notice);
	}
}
