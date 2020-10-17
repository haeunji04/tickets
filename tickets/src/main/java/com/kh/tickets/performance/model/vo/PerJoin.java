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
public class PerJoin implements Serializable{

	private int perNo;
	private String memberId;
	private String categoryCode;
	private String categoryName;
	private String locationCode;
	private String locationName;
	private String perTitle;
	private String perDirector;
	private String perActor;
	private int theaterNo;
	private String theaterLocation;
	private String theaterCity;
	private String theaterAddress;
	private String theaterName;
	private int totalSeat;
	private int perTime;
	private String perContent;
	private String perImgOriginalFileName;
	private String perImgRenamedFileName;
	private String detailImgOriginalFileName;
	private String detailImgRenamedFileName;
	private int perRating;
	private String perDisplay;
	private String adminApproval;
	private Date perRegisterDate;
	private Date perStartDate;
	private Date perEndDate;
	private int saleCnt;	
	//오픈관련
	private String aloneSale;
	
	
	
	
}
