package com.deepblue.dab.member.model.service;

import java.util.ArrayList;

import com.deepblue.dab.common.SearchDate;
import com.deepblue.dab.common.SearchPaging;
import com.deepblue.dab.member.model.vo.Member;
import com.deepblue.dab.member.utils.PagingMember;

public interface MemberService {

	Member selectMember(String userid);
	int selectDupcheckId(String userid);
	int insertMember(Member member);
	int findPwd(Member member);
	int selectMailCheck(String email);
	Member selectByid(String userid);
	Member selectByMail(String email);
	int updateMember(Member member);
	int deleteMember(String userid);
	int chkSelectForPwd(Member loginMember);
	int updateLoginok(Member member);
	ArrayList<Member> selectList(PagingMember page);
	int aupdateMember(Member member);
	int selectListCount();
	int getSearchIdCount(String keyword);
	int getSearchLoginCount(String keyword);
	int getSearchEnrollCount(SearchDate date);
	ArrayList<Member> searchId(SearchPaging searchpaging);
	ArrayList<Member> searchLoginok(SearchPaging searchpaging);
	ArrayList<Member> searchDate(SearchPaging searchpaging);
}
