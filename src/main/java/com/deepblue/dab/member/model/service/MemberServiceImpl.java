package com.deepblue.dab.member.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.deepblue.dab.common.SearchDate;
import com.deepblue.dab.common.SearchPaging;
import com.deepblue.dab.member.model.dao.MemberDao;
import com.deepblue.dab.member.model.vo.Member;
import com.deepblue.dab.member.utils.PagingMember;

@Service("memberService")
public class MemberServiceImpl implements MemberService{
	@Autowired
	private MemberDao memberDao;
	
	@Override
	public Member selectMember(String userid) {
		return memberDao.selectMember(userid);
	}

	@Override
	public int selectDupcheckId(String userid) {
		return memberDao.selectDupCheckId(userid);
	}

	@Override
	public int insertMember(Member member) {
		return memberDao.insertMember(member);
	}

	@Override
	public int findPwd(Member member) {
		return memberDao.findPwd(member);
	}

	@Override
	public int updateMember(Member member) {
		return memberDao.updateMember(member);
	}

	@Override
	public int deleteMember(String userid) {
		return memberDao.deleteMember(userid);
	}

	@Override
	public Member selectByid(String userid) {
		// TODO Auto-generated method stub
		return memberDao.selectByid(userid);
	}

	@Override
	public Member selectByMail(String email) {
		// TODO Auto-generated method stub
		return memberDao.selectByMail(email);
	}

	@Override
	public int selectMailCheck(String email) {
		return memberDao.selectMailCheck(email);
	}

	@Override
	public int chkSelectForPwd(Member loginMember) {
		return memberDao.chkSelectForPwd(loginMember);
	}

	@Override
	public ArrayList<Member> selectList(PagingMember page) {
		return memberDao.selectList(page);
	}

	@Override
	public int updateLoginok(Member member) {
		return memberDao.updateLoginok(member);
	}


	@Override
	public int aupdateMember(Member member) {
		return memberDao.aupdateMember(member);
	}
	@Override
	public int getSearchIdCount(String keyword) {
		return memberDao.getSearchIdCount(keyword);
	}

	@Override
	public int getSearchLoginCount(String keyword) {
		return memberDao.getSearchLoginCount(keyword);
	}

	@Override
	public int getSearchEnrollCount(SearchDate date) {
		return memberDao.getSearchEnrollCount(date);
	}

	@Override
	public ArrayList<Member> searchId(SearchPaging searchpaging) {
		return memberDao.searchId(searchpaging);
	}

	@Override
	public ArrayList<Member> searchLoginok(SearchPaging searchpaging) {
		return memberDao.searchLoginok(searchpaging);
	}

	@Override
	public ArrayList<Member> searchDate(SearchPaging searchpaging) {
		return memberDao.searchDate(searchpaging);
	}

	// 전체 회원 조회
	@Override
	public int selectListCount() {
		return memberDao.selectListCount();
	}
}
