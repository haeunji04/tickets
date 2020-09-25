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
public class MyWishList implements Serializable{
	
	private int perNo;
	private String memberId;
	private Date wishDate;
	private String perTitle;
	private String perImgOriginalFileName;
	private String perImgRenamedFileName;
	private String theaterNo;
	private Date perStartDate;
	private Date perEndDate;

}
