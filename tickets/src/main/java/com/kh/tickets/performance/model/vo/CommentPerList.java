package com.kh.tickets.performance.model.vo;

import java.io.Serializable;
import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class CommentPerList implements Serializable{
	
	private int perNo;
	private String memberId;
	private String perTitle;
	private int perTime;
	private String perImgOriginalFileName;
	private String perImgRenamedFileName;
	private int perRating;
	private Date perStartDate;
	private Date perEndDate;
	private String boardCommentWriter;
	private String boardCommentContent;
	private Date boardCommentDate;

}
