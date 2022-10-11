package com.deepblue.dab.board.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.deepblue.dab.board.vo.Board;
import com.deepblue.dab.common.Paging;
import com.deepblue.dab.common.SearchDate;
import com.deepblue.dab.common.SearchPaging;

@Repository("boardDao")
public class BoardDao {
	@Autowired
	private SqlSessionTemplate session;
	

	public ArrayList<Board> selectTop3() {
		List<Board> list = session.selectList("boardMapper.selectTop3");
		return (ArrayList<Board>)list;
	}

	public int selectListCount() {
		return session.selectOne("boardMapper.getListCount");
	}

	public ArrayList<Board> selectList(Paging page) {
		List<Board> list = session.selectList("boardMapper.selectList", page);
		return (ArrayList<Board>)list;
	}

	public int updateAddReadcount(int board_num) {
		return session.update("boardMapper.addReadCount", board_num);
	}

	public Board selectBoard(int board_num) {
		return session.selectOne("boardMapper.selectBoard", board_num);
	}

	public int updateReplySeq(Board reply) {
		int result = 0;
		
		if(reply.getBoard_lev() == 2) { //댓글이면
			result = session.update("boardMapper.updateReplySeq1", reply);
		}
		if(reply.getBoard_lev() == 3) { //대댓글이면
			result = session.update("boardMapper.updateReplySeq2", reply);
		}
		
		return result;
	}

	public int insertReply(Board reply) {
		int result = 0;
		
		if(reply.getBoard_lev() == 2) { //댓글이면
			result = session.insert("boardMapper.insertReply1", reply);
		}
		if(reply.getBoard_lev() == 3) { //대댓글이면
			result = session.insert("boardMapper.insertReply2", reply);
		}
		
		return result;
	}

	public int insertOriginBoard(Board board) {
		return session.insert("boardMapper.insertOrigin", board);
	}

	public int deleteBoard(Board board) {
		return session.delete("boardMapper.deleteBoard", board);
	}

	public int updateReply(Board reply) {
		return session.update("boardMapper.updateReply", reply);
	}

	public int updateOrigin(Board board) {
		return session.update("boardMapper.updateOrigin", board);
	}
	
	public ArrayList<Board> selectSearchTitle(SearchPaging searchpaging) {
		List<Board> list = session.selectList("boardMapper.searchTitle", searchpaging);
		return (ArrayList<Board>)list;
	}


	public ArrayList<Board> selectSearchWriter(SearchPaging searchpaging) {
		List<Board> list = session.selectList("boardMapper.searchWriter", searchpaging);
		return (ArrayList<Board>)list;
	}

	public ArrayList<Board> selectSearchDate(SearchPaging searchpaging) {
		List<Board> list = session.selectList("boardMapper.searchDate", searchpaging);
		return (ArrayList<Board>) list;
	}

	public int selectSearchWListCount(String keyword) {
		return session.selectOne("boardMapper.getSearchWListCount", keyword);
	}

	public int selectSearchTListCount(String keyword) {
		return session.selectOne("boardMapper.getSearchTListCount", keyword);
	}

	public int selectSearchDListCount(SearchDate date) {
		return session.selectOne("boardMapper.getSearchDListCount", date);
	}

	public ArrayList<Board> selectReply(int board_ref) {
		List<Board> list = session.selectList("boardMapper.selectReply", board_ref);
		return (ArrayList<Board>) list;
	}
	

	
	
	


	

	
	
}