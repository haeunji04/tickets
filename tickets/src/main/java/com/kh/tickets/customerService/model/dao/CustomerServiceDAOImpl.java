package com.kh.tickets.customerService.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.tickets.customerService.model.vo.Notice;

@Repository
public class CustomerServiceDAOImpl implements CustomerServiceDAO {

	@Autowired 
	private SqlSessionTemplate sqlSession;

	@Override
	public List<Notice> selectNoticeList(int limit, int offset) {
		RowBounds rowBounds = new RowBounds(offset, limit);
		return sqlSession.selectList("customerService.selectNoticeList", null, rowBounds);
	}

	@Override
	public Notice selectOneNoticeCollection(int noticeNo) {
		return sqlSession.selectOne("customerService.selectOneNoticeCollection", noticeNo);
	}

	@Override
	public int insertNotice(Notice notice) {
		return sqlSession.selectOne("customerService.insertNotice", notice);
	}

	
	
}
