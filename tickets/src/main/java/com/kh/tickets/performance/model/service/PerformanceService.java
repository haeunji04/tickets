package com.kh.tickets.performance.model.service;

import java.util.List;
import java.util.Map;

import com.kh.tickets.performance.model.vo.Performance;
import com.kh.tickets.performance.model.vo.PerformanceHall;

public interface PerformanceService {

	int performanceRegister(Performance performance);

	List<Performance> selectPerformanceList();

	List<Performance> categoryListView(String category);

	String getCategoryName(String category);

	int approvePerRegister(int perNo);

	List<Performance> adminApprovalPerList();


	List<Performance> companyPerList(String memberId);

	Performance selectOnePerformance(int perNo);

	

	List<PerformanceHall> searchHallName(String keyword);

	int perUpdate(Performance performance);

	int getPerNo(String perTitle);

	int insertSchedule(Map<String, Object> param);
}
