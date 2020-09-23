package com.kh.tickets.performance.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.tickets.performance.model.vo.Performance;
import com.kh.tickets.performance.model.vo.PerformanceHall;

@Repository
public class PerformanceDAOImpl implements PerformanceDAO {
	
	@Autowired 
	private SqlSessionTemplate sqlSession;

	@Override
	public int performanceRegister(Performance performance) {
		return sqlSession.insert("performance.performanceRegister", performance);
	}

	@Override
	public List<Performance> selectPerformanceList() {
		return sqlSession.selectList("performance.selectPerformanceList");
	}

	@Override
	public List<Performance> categoryListView(String category) {
		return sqlSession.selectList("performance.categoryListView", category);
	}

	@Override
	public String getCategoryName(String category) {
		return sqlSession.selectOne("performance.getCategoryName", category);
	}

	@Override
	public int approvePerRegister(int perNo) {
		return sqlSession.update("performance.approvePerRegister", perNo);
	}

	@Override
	public List<Performance> adminApprovalPerList() {
		return sqlSession.selectList("performance.adminApprovalPerList");
	}

	@Override

	public List<Performance> companyPerList(String memberId) {
		return sqlSession.selectList("performance.companyPerList", memberId);
	}

	@Override
	public Performance selectOnePerformance(int perNo) {
		return sqlSession.selectOne("performance.selectOnePerformance", perNo);
	}

	public List<PerformanceHall> searchHallName(String keyword) {
		return sqlSession.selectList("performance.searchHallName", keyword);

	}

	@Override
	public int perUpdate(Performance performance) {		
		return sqlSession.update("performance.perUpdate", performance);
	}

}
