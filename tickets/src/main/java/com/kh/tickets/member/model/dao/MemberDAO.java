package com.kh.tickets.member.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.tickets.member.model.vo.Auth;
import com.kh.tickets.member.model.vo.Member;

public interface MemberDAO {

	int memberEnroll(Member member);

	Member selectOneMember(String memberId);

	List<Member> selectMemberList();

	int deleteMember(String memberId);

	int updatePassword(Member member);

	int updateMember(Member member);

//	List<Member> selectMemberList(int limit, int offset);

	int selectBoardTotalContents();

	List<Member> searchMemberList(Map<String, Object> map);

	int totalSearchMemberList(Map<String, Object> map);

	List<Member> selectMemberList(Map<String, Object> map);

	Member findId(Map<String, Object> param);

	Member findPwd(Map<String, Object> param);

	int updatePwd(Map<String, Object> param);

	int authEnroll(Auth auth);
}
