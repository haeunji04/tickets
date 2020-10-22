package com.kh.tickets.customerService.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.tickets.customerService.model.vo.Notice;
import com.kh.tickets.member.model.vo.Auth;
import com.kh.tickets.member.model.vo.Member;
import com.kh.tickets.member.model.vo.MemberPayList;

public interface CustomerServiceDAO {

	List<Notice> selectNoticeList(Map<String, Object> map);

	Notice selectOneNoticeCollection(int noticeNo);

	int insertNotice(Notice notice);

	List<Notice> selectFaqList(Map<String, Object> map);

	int selectNoticeTotalContents();

	int deleteNotice(int noticeNo);

}
