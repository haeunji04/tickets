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
public class Ticket implements Serializable{

	private int ticNo;
	private int ticPrice;
	private int schNo;
	private int seatNo;
	private String memberId;
	private String orderNo;
}
