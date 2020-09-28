package com.kh.tickets.boardComment.model.dao;

import java.util.List;

import com.kh.tickets.boardComment.model.vo.BoardComment;

public interface BoardCommentDAO {

	int boardCommentInsert(BoardComment boardComment);

	List<BoardComment> selectCommentList(int perNo);

	int boardCommentDelete(BoardComment boardComment);

}
