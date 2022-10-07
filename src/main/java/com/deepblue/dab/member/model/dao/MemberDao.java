package com.deepblue.dab.member.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.deepblue.dab.common.SearchDate;
import com.deepblue.dab.common.SearchPaging;
import com.deepblue.dab.member.model.vo.Member;
import com.deepblue.dab.member.utils.PagingMember;

@Repository("memberDao")	// xml 자동 등록됨 (id 지정함)
public class MemberDao {
	@Autowired
	private SqlSessionTemplate session;
	
	public Member selectMember(String userid) {
		return session.selectOne("memberMapper.selectMember", userid);
	}
	public int selectDupCheckId(String userid) {
		return session.selectOne("memberMapper.selectCheckId", userid);
	}
	public int insertMember(Member member) {
		return session.insert("memberMapper.insertMember", member);
	}
	public Member selectByMail(String email) {
		return session.selectOne("memberMapper.selectByMail", email);
	}
	public Member selectByid(String userid) {
		return session.selectOne("memberMapper.selectByid", userid);
	}
	public int findPwd(Member member) {
		return session.update("memberMapper.findPwd", member);
	}
	public int updateMember(Member member) {
		return session.update("memberMapper.updateMember", member);
	}
	public int deleteMember(String userid) {
		return session.delete("memberMapper.deleteMember", userid);
	}
	public int selectMailCheck(String email) {
		return session.selectOne("memberMapper.selectMailCheck", email);
	}
	public int chkSelectForPwd(Member loginMember) {
		return session.selectOne("memberMapper.chkSelectForPwd", loginMember);
	}
	public ArrayList<Member> selectList(PagingMember page){
		List<Member> list = session.selectList("memberMapper.selectList", page);
		return (ArrayList<Member>)list;
	}
	public int updateLoginok(Member member) {
		return session.update("memberMapper.updateLoginOK", member);
	}
	
	// 검색 처리용 --------------------------------
	public ArrayList<Member> selectSearchUserid(String keyword) {
		List<Member> list = session.selectList("memberMapper.selectSearchUserid", keyword);
		return (ArrayList<Member>)list;
	}
	public ArrayList<Member> selectSearchEnrollDate(SearchDate searchDate) {
		List<Member> list = session.selectList("memberMapper.selectSearchEnrollDate", searchDate);
		return (ArrayList<Member>)list;
	}
	public ArrayList<Member> selectSearchLoginOK(String keyword) {
		List<Member> list = session.selectList("memberMapper.selectSearchLoginOK", keyword);
		return (ArrayList<Member>)list;
	}
	
	// 관리자 모드에서 회원 수정용
	public int aupdateMember(Member member) {
		return session.update("memberMapper.aupdateMember", member);
	}
	
	public int getSearchIdCount(String keyword) {
		return session.selectOne("memberMapper.getSearchIdCount", keyword);
	}
	public int getSearchLoginCount(String keyword) {
		return session.selectOne("memberMapper.getSearchLoginCount", keyword);
	}
	public int getSearchEnrollCount(SearchDate date) {
		return session.selectOne("memberMapper.getSearchEnrollCount", date);
	}
	public ArrayList<Member> searchId(SearchPaging searchpaging) {
		List<Member> list = session.selectList("memberMapper.searchId", searchpaging);
		return (ArrayList<Member>)list;
	}
	public ArrayList<Member> searchLoginok(SearchPaging searchpaging) {
		List<Member> list = session.selectList("memberMapper.searchLoginok", searchpaging);
		return (ArrayList<Member>)list;
	}
	public ArrayList<Member> searchDate(SearchPaging searchpaging) {
		List<Member> list = session.selectList("memberMapper.searchDate", searchpaging);
		return (ArrayList<Member>)list;
	}
	public int selectListCount() {
		return session.selectOne("memberMapper.getListCount");
	}

}
