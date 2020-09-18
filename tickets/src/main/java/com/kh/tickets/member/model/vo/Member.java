package com.kh.tickets.member.model.vo;

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
public class Member implements Serializable{

	private String memberId;
	private String password;
	private String name;
	private String email;
	private String phone;
	private String address;
	private String memberRole;
	private Date enrollDate;
	private String quitYn;
	
	
}
