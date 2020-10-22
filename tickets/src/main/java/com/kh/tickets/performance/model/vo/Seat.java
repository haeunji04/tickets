package com.kh.tickets.performance.model.vo;

import java.io.Serializable;
import java.util.Date;

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
public class Seat implements Serializable {

	private int seatNo;
	private int seatPrice;
	private String seatGrade;
	private int floor;
	private int x;
	private int y;
	
}
