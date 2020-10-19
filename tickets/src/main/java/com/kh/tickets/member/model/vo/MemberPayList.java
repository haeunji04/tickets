package com.kh.tickets.member.model.vo;

import java.io.Serializable;
import java.sql.Date;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

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
public class MemberPayList implements Serializable {

	//pay table
	private int payNo;
	private int totPrice;
	private String payOption;
	private Date payDate;
	private String memberId;
	private String payYn;
	private String cancelYn;
	private int seatNo;
	private int schNo;
	//private int orderNumber;
	
	//schedule table
	private Date schDateTime;
	private int perNo;
	
	//performance table
	private String perTitle;
	private String perImgOriginalFileName;
	private String perImgRenamedFileName;
	private String theaterNo;
	private Date perStartDate;
	private Date perEndDate;
	private int perTime;
	private int perRating;
	
	//theater table
	private String theaterLocation;
	private String theaterCity;
	private String theaterAddress;
	private String theaterName;
	
	
	
	
	
	
}
