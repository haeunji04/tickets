package com.kh.tickets.member.model.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.tickets.member.model.dao.MemberDAO;
import com.kh.tickets.member.model.vo.Auth;
import com.kh.tickets.member.model.vo.Member;
import com.kh.tickets.member.model.vo.MemberPayList;
import com.kh.tickets.member.model.vo.MemberPayTicket;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDAO memberDAO;
	
	private Logger log = 
			LoggerFactory.getLogger(getClass());

	@Override
	public int memberEnroll(Member member) {
		return memberDAO.memberEnroll(member);
	}

	@Override
	public Member selectOneMember(String memberId) {
		return memberDAO.selectOneMember(memberId);
	}

	@Override
	public List<Member> selectMemberList() {
		log.debug("memberList Service@@");
		return memberDAO.selectMemberList();
	}

	@Override
	public int deleteMember(String memberId) {
		log.debug("memberList Service@@");
		return memberDAO.deleteMember(memberId);
	}

	@Override
	public int updatePassword(Member member) {
		return memberDAO.updatePassword(member);
	}

	@Override
	public int updateMember(Member member) {
		return memberDAO.updateMember(member);
	}

//	@Override
//	public List<Member> selectMemberList(int limit, int offset) {
//		return memberDAO.selectMemberList(limit, offset);
//	}

	@Override
	public int selectBoardTotalContents() {
		return memberDAO.selectBoardTotalContents();
	}

	@Override
	public List<Member> searchMemberList(Map<String, Object> map) {
		return memberDAO.searchMemberList(map);
	}

	@Override
	public int totalSearchMemberList(Map<String, Object> map) {
		return memberDAO.totalSearchMemberList(map);
	}

	@Override
	public List<Member> selectMemberList(Map<String, Object> map) {
		return memberDAO.selectMemberList(map);
	}
	
	@Override
	public Member findId(Map<String, Object> param) {
		return memberDAO.findId(param);
	}

	@Override
	public Member findPwd(Map<String, Object> param) {
		return memberDAO.findPwd(param);
	}

	@Override
	public int updatePwd(Map<String, Object> param) {
		return memberDAO.updatePwd(param);
	}

	@Override
	public int authEnroll(Auth auth) {
		return memberDAO.authEnroll(auth);
	}

	@Override
	public List<MemberPayList> selectMemberPayList(String memberId) {
		return memberDAO.selectMemberPayList(memberId);
	}

	@Override
	public List<MemberPayTicket> selectMemberPayTicket(String orderNo) {
		return memberDAO.selectMemberPayTicket(orderNo);
	}

	@Override
	public List<MemberPayList> selectCompanyPayList(int perNo) {
		return memberDAO.selectCompanyPayList(perNo);
	}

	

	
	
}
