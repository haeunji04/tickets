package com.kh.tickets.boardComment.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.tickets.boardComment.model.dao.BoardCommentDAO;
import com.kh.tickets.boardComment.model.vo.BoardComment;

@Service
public class BoardCommentServiceImpl implements BoardCommentService {
	
	@Autowired
	private BoardCommentDAO boardCommentDAO;

	@Override
	public int boardCommentInsert(BoardComment boardComment) {
		return boardCommentDAO.boardCommentInsert(boardComment);
	}

	@Override
	public List<BoardComment> selectCommentList(int perNo) {
		return boardCommentDAO.selectCommentList(perNo);
	}

	@Override
	public int boardCommentDelete(BoardComment boardComment) {
		return boardCommentDAO.boardCommentDelete(boardComment);
	}

}
