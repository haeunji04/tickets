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

	private int no;
	private String location;
	private String city;
	private String address;
	private String name;
	private int totalSeat;
	private String locationCode;
	
}
