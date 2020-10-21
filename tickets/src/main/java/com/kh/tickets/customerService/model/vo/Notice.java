package com.kh.tickets.customerService.model.vo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

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
public class Notice implements Serializable{
	
	private int noticeNo;
	private String noticeKind;
	private String noticeTitle;
	private String noticeContent;
	private Date noticeRegDate;
}
