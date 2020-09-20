package com.kh.tickets.performance.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.tickets.performance.model.vo.Performance;

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

}
