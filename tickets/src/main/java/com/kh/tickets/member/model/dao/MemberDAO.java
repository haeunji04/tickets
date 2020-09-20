package com.kh.tickets.member.model.dao;

import java.util.List;

import com.kh.tickets.member.model.vo.Member;

public interface MemberDAO {

	int memberEnroll(Member member);

	Member selectOneMember(String memberId);

	List<Member> selectMemberList();

	int deleteMember(String memberId);

	int updatePassword(Member member);

	int updateMember(Member member);

	

}
