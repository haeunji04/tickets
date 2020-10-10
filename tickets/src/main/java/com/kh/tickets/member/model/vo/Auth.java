package com.kh.tickets.member.model.vo;

import java.io.Serializable;
import java.sql.Date;
import java.util.List;

import org.springframework.security.core.authority.SimpleGrantedAuthority;

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
public class Auth implements Serializable {
	
	private String memberId;
	private String authority;
	

}
