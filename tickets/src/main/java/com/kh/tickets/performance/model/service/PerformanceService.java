package com.kh.tickets.performance.model.service;

import java.util.List;

import com.kh.tickets.performance.model.vo.Performance;

public interface PerformanceService {

	int performanceRegister(Performance performance);

	List<Performance> selectPerformanceList();

}
