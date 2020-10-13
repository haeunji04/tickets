package com.kh.tickets.performance.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Schedule implements Serializable {

	private int schNo;
	private int perNo;
	private int schRound;
	private Date schDateTime;
	private int theaterNo;
		
}
