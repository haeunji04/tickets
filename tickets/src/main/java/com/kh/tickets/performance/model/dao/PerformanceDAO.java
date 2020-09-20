package com.kh.tickets.performance.model.dao;

import java.util.List;

import com.kh.tickets.performance.model.vo.Performance;

public interface PerformanceDAO {

	int performanceRegister(Performance performance);

	List<Performance> selectPerformanceList();

}
