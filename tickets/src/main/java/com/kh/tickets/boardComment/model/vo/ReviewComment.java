package com.kh.tickets.boardComment.model.vo;

import java.io.Serializable;
import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class ReviewComment implements Serializable{

	private int reviewCommentNo;
	private String reviewCommentContent;
	private Date reviewCommentDate;
	private int perNo;
	private String memberId;
	
}
