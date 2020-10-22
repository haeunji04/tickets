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
public class Pay implements Serializable{

	private String orderNo;
	private int schNo;
	private int totPrice;
	private int seatCount;
	private String payOption;
	private Date payDate;
	private String memberId;
	private String payYn;
	private String cancelYn;
}
