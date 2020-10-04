package com.kh.tickets.member.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.tickets.member.model.vo.Member;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Autowired 
	private SqlSessionTemplate sqlSession;
	
	private Logger log = 
			LoggerFactory.getLogger(getClass());

	@Override
	public int memberEnroll(Member member) {
		return sqlSession.insert("member.memberEnroll", member);
	}

	@Override
	public Member selectOneMember(String memberId) {
		return sqlSession.selectOne("member.selectOneMember", memberId);
	}

	@Override
	public List<Member> selectMemberList() {
		log.debug("memberList DAO@@");
		return sqlSession.selectList("member.selectMemberList");
	}

	@Override
	public int deleteMember(String memberId) {
		return sqlSession.delete("member.deleteMember", memberId);
	}

	@Override
	public int updatePassword(Member member) {
		return sqlSession.update("member.updatePassword", member);
	}

	@Override
	public int updateMember(Member member) {
		return sqlSession.update("member.updateMember", member);
	}

//	@Override
//	public List<Member> selectMemberList(int limit, int offset) {
//		RowBounds rowBounds = new RowBounds(offset, limit);
//		return sqlSession.selectList("member.selectMemberList", null, rowBounds);
//	}

	@Override
	public int selectBoardTotalContents() {
		return sqlSession.selectOne("member.selectBoardTotalContents");
	}

	@Override
	public List<Member> searchMemberList(Map<String, Object> map) {
		return sqlSession.selectList("member.searchMemberList", map);
	}

	@Override
	public int totalSearchMemberList(Map<String, Object> map) {
		return sqlSession.selectOne("member.totalSearchMemberList", map);
	}

	@Override
	public List<Member> selectMemberList(Map<String, Object> map) {
		return sqlSession.selectList("member.selectMemberList", map);
	}
	
	
}
