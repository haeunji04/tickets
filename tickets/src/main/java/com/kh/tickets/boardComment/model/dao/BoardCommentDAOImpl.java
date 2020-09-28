package com.kh.tickets.boardComment.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.tickets.boardComment.model.vo.BoardComment;

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

}
