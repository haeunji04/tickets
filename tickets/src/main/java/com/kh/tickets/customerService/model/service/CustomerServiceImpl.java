package com.kh.tickets.customerService.model.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.tickets.customerService.model.dao.CustomerServiceDAO;
import com.kh.tickets.customerService.model.vo.Notice;
import com.kh.tickets.member.model.dao.MemberDAO;
import com.kh.tickets.member.model.vo.Auth;
import com.kh.tickets.member.model.vo.Member;
import com.kh.tickets.member.model.vo.MemberPayList;

@Service
public class CustomerServiceImpl implements CustomerService {

	@Autowired
	private CustomerServiceDAO customerServiceDAO;

	@Override
	public List<Notice> selectNoticeList(int limit, int offset) {
		return customerServiceDAO.selectNoticeList(limit, offset);
	}

	@Override
	public Notice selectOneNoticeCollection(int noticeNo) {
		return customerServiceDAO.selectOneNoticeCollection(noticeNo);
	}

	@Transactional(rollbackFor = { Exception.class })
	@Override
	public int insertNotice(Notice notice) {
		int result = 0;
		
		//1.board테이블에 insert
		result = customerServiceDAO.insertNotice(notice);	
		return result;
	}
	
}
