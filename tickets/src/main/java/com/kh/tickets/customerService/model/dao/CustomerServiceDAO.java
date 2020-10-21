package com.kh.tickets.customerService.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.tickets.customerService.model.vo.Notice;
import com.kh.tickets.member.model.vo.Auth;
import com.kh.tickets.member.model.vo.Member;
import com.kh.tickets.member.model.vo.MemberPayList;

public interface CustomerServiceDAO {

	List<Notice> selectNoticeList(int limit, int offset);

	Notice selectOneNoticeCollection(int noticeNo);

	int insertNotice(Notice notice);


}
