package com.kh.tickets.customerService.model.service;

import java.util.List;
import java.util.Map;

import com.kh.tickets.customerService.model.vo.Notice;

public interface CustomerService {

	List<Notice> selectNoticeList(Map<String, Object> map);

	Notice selectOneNoticeCollection(int noticeNo);

	int insertNotice(Notice notice);

	List<Notice> selectFaqList(Map<String, Object> map);

	int selectNoticeTotalContents();

}
