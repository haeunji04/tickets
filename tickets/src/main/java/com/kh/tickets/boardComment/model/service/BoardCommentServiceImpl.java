package com.kh.tickets.boardComment.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.tickets.boardComment.model.dao.BoardCommentDAO;
import com.kh.tickets.boardComment.model.vo.BoardComment;
import com.kh.tickets.boardComment.model.vo.ReviewComment;

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

	@Override
	public List<ReviewComment> selectReviewList(int perNo) {
		return boardCommentDAO.selectReviewList(perNo);
	}

	@Override
	public String searchReservationMember(Map<String, Object> param) {
		return boardCommentDAO.searchReservationMember(param);
	}

	@Override
	public int insertReview(ReviewComment review) {
		return boardCommentDAO.insertReview(review);
	}

	@Override
	public List<ReviewComment> reivewPerList(String boardCommentWriter) {
		return boardCommentDAO.reivewPerList(boardCommentWriter);
	
	}

	@Override
	public int deleteReview(int reviewCommentNo) {
		return boardCommentDAO.deleteReview(reviewCommentNo);
	}

	
	
}
