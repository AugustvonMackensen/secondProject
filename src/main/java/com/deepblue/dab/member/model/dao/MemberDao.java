package com.deepblue.dab.member.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.deepblue.dab.member.model.vo.Member;

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
	public ArrayList<Member> selectList(){
		List<Member> list = session.selectList("memberMapper.selectList");
		return (ArrayList<Member>)list;
	}
	public int updateLoginok(Member member) {
		return session.update("memberMapper.updateLoginOK", member);
	}

}
