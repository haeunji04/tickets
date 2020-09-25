package com.kh.tickets.performance.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.tickets.performance.model.dao.PerformanceDAO;
import com.kh.tickets.performance.model.vo.Performance;
import com.kh.tickets.performance.model.vo.PerformanceHall;

@Service
public class PerformanceServiceImpl implements PerformanceService {
	
	@Autowired
	private PerformanceDAO performanceDAO;

	@Override
	public int performanceRegister(Performance performance) {
		return performanceDAO.performanceRegister(performance);
	}

	@Override
	public List<Performance> selectPerformanceList() {
		return performanceDAO.selectPerformanceList();
	}

	@Override
	public List<Performance> categoryListView(String category) {
		return performanceDAO.categoryListView(category);
	}

	@Override
	public String getCategoryName(String category) {
		return performanceDAO.getCategoryName(category);
	}

	@Override
	public int approvePerRegister(int perNo) {
		return performanceDAO.approvePerRegister(perNo);
	}

	@Override
	public List<Performance> adminApprovalPerList() {
		return performanceDAO.adminApprovalPerList();
	}

	@Override

	public List<Performance> companyPerList(String memberId) {
		return performanceDAO.companyPerList(memberId);
	}

	@Override
	public Performance selectOnePerformance(int perNo) {
		return performanceDAO.selectOnePerformance(perNo);
	}

	

	public List<PerformanceHall> searchHallName(String keyword) {
		return performanceDAO.searchHallName(keyword);
	}

	@Override
	public int perUpdate(Performance performance) {
		return performanceDAO.perUpdate(performance);
	}

	@Override
	public int getPerNo(String perTitle) {
		return performanceDAO.getPerNo(perTitle);
	}

	@Override
	public int insertSchedule(Map<String, Object> param) {
		return performanceDAO.insertSchedule(param);
	}


}
