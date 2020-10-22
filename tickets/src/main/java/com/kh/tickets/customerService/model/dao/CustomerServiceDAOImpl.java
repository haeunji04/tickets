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
	public List<Notice> selectNoticeList(Map<String, Object> map) {
		return sqlSession.selectList("customerService.selectNoticeList", map);
	}

	@Override
	public Notice selectOneNoticeCollection(int noticeNo) {
		return sqlSession.selectOne("customerService.selectOneNoticeCollection", noticeNo);
	}

	@Override
	public int insertNotice(Notice notice) {
		return sqlSession.insert("customerService.insertNotice", notice);
	}

	@Override
	public List<Notice> selectFaqList(Map<String, Object> map) {
		return sqlSession.selectList("customerService.selectFaqList", map);
	}

	@Override
	public int selectNoticeTotalContents() {
		return sqlSession.selectOne("customerService.selectNoticeTotalContents");
	}

	@Override
	public int deleteNotice(int noticeNo) {
		return sqlSession.delete("customerService.deleteNotice", noticeNo);
	}
	
	
	
}
