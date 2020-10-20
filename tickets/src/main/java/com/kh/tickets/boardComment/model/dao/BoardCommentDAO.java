package com.kh.tickets.boardComment.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.tickets.boardComment.model.vo.BoardComment;
import com.kh.tickets.boardComment.model.vo.ReviewComment;

public interface BoardCommentDAO {

	int boardCommentInsert(BoardComment boardComment);

	List<BoardComment> selectCommentList(int perNo);

	int boardCommentDelete(BoardComment boardComment);

	List<ReviewComment> selectReviewList(int perNo);

	String searchReservationMember(Map<String, Object> param);

	int insertReview(ReviewComment review);

}
