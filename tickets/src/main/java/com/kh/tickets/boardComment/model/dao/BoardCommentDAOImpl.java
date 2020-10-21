package com.kh.tickets.boardComment.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.tickets.boardComment.model.vo.BoardComment;
import com.kh.tickets.boardComment.model.vo.ReviewComment;

@Repository
public class BoardCommentDAOImpl implements BoardCommentDAO {
	
	@Autowired 
	private SqlSessionTemplate sqlSession;

	@Override
	public int boardCommentInsert(BoardComment boardComment) {
		return sqlSession.insert("boardComment.boardCommentInsert", boardComment);
	}

	@Override
	public List<BoardComment> selectCommentList(int perNo) {
		return sqlSession.selectList("boardComment.selectCommentList", perNo);
	}

	@Override
	public int boardCommentDelete(BoardComment boardComment) {
		return sqlSession.delete("boardComment.boardCommentDelete", boardComment);
	}

	@Override
	public List<ReviewComment> selectReviewList(int perNo) {
		return sqlSession.selectList("boardComment.selectReviewList", perNo);
	}

	@Override
	public String searchReservationMember(Map<String, Object> param) {
		return sqlSession.selectOne("boardComment.searchReservationMember", param);
	}

	@Override
	public int insertReview(ReviewComment review) {
		return sqlSession.insert("boardComment.insertReview", review);
	}

	@Override
	public List<ReviewComment> reivewPerList(String boardCommentWriter) {
		return sqlSession.selectList("boardComment.reivewPerList", boardCommentWriter);
	}

	@Override
	public int deleteReview(int reviewCommentNo) {
		return sqlSession.delete("boardComment.deleteReview", reviewCommentNo);
	}
	
	

}
