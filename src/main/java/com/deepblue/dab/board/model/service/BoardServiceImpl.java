package com.deepblue.dab.board.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.deepblue.dab.board.model.dao.BoardDao;
import com.deepblue.dab.board.vo.Board;
import com.deepblue.dab.common.Paging;
import com.deepblue.dab.common.SearchDate;
import com.deepblue.dab.common.SearchPaging;

@Service("boardService")
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDao boardDao;
	
	@Override
	public ArrayList<Board> selectTop3() {
		return boardDao.selectTop3();
	}

	@Override
	public int selectListCount() {
		return boardDao.selectListCount();
	}

	@Override
	public ArrayList<Board> selectList(Paging page) {
		return boardDao.selectList(page);
	}

	@Override
	public Board selectBoard(int board_num) {
		return boardDao.selectBoard(board_num);
	}

	@Override
	public int updateAddReadcount(int board_num) {
		return boardDao.updateAddReadcount(board_num);
	}

	@Override
	public int insertOriginBoard(Board board) {
		return boardDao.insertOriginBoard(board);
	}

	@Override
	public int insertReply(Board reply) {
		return boardDao.insertReply(reply);
	}

	@Override
	public int updateReplySeq(Board reply) {
		return boardDao.updateReplySeq(reply);
	}

	@Override
	public int updateOrigin(Board board) {
		return boardDao.updateOrigin(board);
	}

	@Override
	public int updateReply(Board reply) {
		return boardDao.updateReply(reply);
	}

	@Override
	public int deleteBoard(Board board) {
		return boardDao.deleteBoard(board);
	}

	@Override
	public ArrayList<Board> selectSearchTitle(SearchPaging searchpaging) {
		return boardDao.selectSearchTitle(searchpaging);
	}

	@Override
	public ArrayList<Board> selectSearchWriter(SearchPaging searchpaging) {
		return boardDao.selectSearchWriter(searchpaging);
	}

	@Override
	public ArrayList<Board> selectSearchDate(SearchPaging searchpaging) {
		return boardDao.selectSearchDate(searchpaging);
	}

	@Override
	public int selectSearchWListCount(String keyword) {
		return boardDao.selectSearchWListCount(keyword);
	}

	@Override
	public int selectSearchTListCount(String keyword) {
		return boardDao.selectSearchTListCount(keyword);
	}

	@Override
	public int selectSearchDListCount(SearchDate date) {
		return boardDao.selectSearchDListCount(date);
	}

<<<<<<< HEAD
	@Override
	public ArrayList<Board> selectReply(int board_ref) {
		return boardDao.selectReply(board_ref);
	}

	
	

=======
>>>>>>> branch 'master' of https://github.com/uforset/secondprj.git
	
	
	
	
	


}
