package com.kh.tickets.performance.model.vo;

import java.io.Serializable;

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
public class PerformanceHall implements Serializable {

	private int theaterNo;
	private String theaterLocation;
	private String theaterCity;
	private String theaterAddress;
	private String theaterName;
	private int totalSeat;
	private String locationCode;
	
}
