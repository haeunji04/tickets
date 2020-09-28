package com.kh.tickets.boardComment.model.service;

import java.util.List;

import com.kh.tickets.boardComment.model.vo.BoardComment;

public interface BoardCommentService {

	int boardCommentInsert(BoardComment boardComment);

	List<BoardComment> selectCommentList(int perNo);

	int boardCommentDelete(BoardComment boardComment);

}
