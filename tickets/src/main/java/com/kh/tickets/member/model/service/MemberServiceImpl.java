package com.kh.tickets.member.model.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.tickets.member.model.dao.MemberDAO;
import com.kh.tickets.member.model.vo.Member;

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
	
}
