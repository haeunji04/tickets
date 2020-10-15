package com.kh.tickets.performance.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.tickets.performance.model.vo.CommentPerList;
import com.kh.tickets.performance.model.vo.MyRecentlyPerList;
import com.kh.tickets.performance.model.vo.MyWishList;
import com.kh.tickets.performance.model.vo.PerJoin;
import com.kh.tickets.performance.model.vo.Performance;
import com.kh.tickets.performance.model.vo.PerformanceHall;
import com.kh.tickets.performance.model.vo.RecentlyPerList;
import com.kh.tickets.performance.model.vo.Schedule;
import com.kh.tickets.performance.model.vo.WishList;

@Repository
public class PerformanceDAOImpl implements PerformanceDAO {
	
	@Autowired 
	private SqlSessionTemplate sqlSession;

	@Override
	public int performanceRegister(Performance performance) {
		return sqlSession.insert("performance.performanceRegister", performance);
	}

	@Override
	public List<Performance> selectPerformanceList() {
		return sqlSession.selectList("performance.selectPerformanceList");
	}

//	@Override
//	public List<PerJoin> categoryListView(String category) {
//		return sqlSession.selectList("performance.categoryListView", category);
//	}

	@Override
	public String getCategoryName(String category) {
		return sqlSession.selectOne("performance.getCategoryName", category);
	}

	@Override
	public int approvePerRegister(int perNo) {
		return sqlSession.update("performance.approvePerRegister", perNo);
	}

	@Override
	public List<Performance> adminApprovalPerList() {
		return sqlSession.selectList("performance.adminApprovalPerList");
	}

	@Override

	public List<Performance> companyPerList(String memberId) {
		return sqlSession.selectList("performance.companyPerList", memberId);
	}

	@Override
	public Performance selectOnePerformance(int perNo) {
		return sqlSession.selectOne("performance.selectOnePerformance", perNo);
	}

	@Override
	public PerJoin selectOnePerJoin(int perNo) {
		return sqlSession.selectOne("performance.selectOnePerJoin", perNo);
	}
	
	public List<PerformanceHall> searchHallName(String keyword) {
		return sqlSession.selectList("performance.searchHallName", keyword);
	}

	@Override
	public int perUpdate(Performance performance) {		
		return sqlSession.update("performance.perUpdate", performance);
	}	

	@Override
	public int wishListInsert(WishList wishList) {
		return sqlSession.insert("performance.wishListInsert", wishList);
	}

	@Override
	public int wishListDelete(WishList wishList) {
		return sqlSession.delete("performance.wishListDelete", wishList);
	}

	@Override
	public List<MyWishList> wishListView(String memberId) {
		return sqlSession.selectList("performance.wishListView", memberId);
	}


	public int getPerNo(String perTitle) {
		return sqlSession.selectOne("performance.getPerNo", perTitle);
	}

	@Override
	public int insertSchedule(Map<String, Object> param) {
		return sqlSession.insert("performance.insertSchedule", param);
	}

	@Override
	public int recentlyPerListInsert(RecentlyPerList recentlyPerList) {
		return sqlSession.insert("performance.recentlyPerListInsert", recentlyPerList);
	}

	@Override
	public List<MyRecentlyPerList> recentlyPerList(String memberId) {
		return sqlSession.selectList("performance.recentlyPerList", memberId);
	}

	@Override
	public int recentlyPerListDelete(RecentlyPerList recentlyPerList2) {
		return sqlSession.delete("performance.recentlyPerListDelete", recentlyPerList2);
	}

	@Override
	public List<Schedule> selectPerSchedule(int perNo) {
		return sqlSession.selectList("performance.selectPerSchedule", perNo);
	}

	@Override
	public int addRecommendedPer(int perNo) {
		return sqlSession.update("performance.addRecommendedPer", perNo);
	}

	@Override
	public int turnOffRecommendedPer(int perNo) {
		return sqlSession.update("performance.turnOffRecommendedPer", perNo);
	}
	
	@Override
	public int deleteDate(int schNo) {
		return sqlSession.delete("performance.deleteDate", schNo);
	}
	
	@Override
	public List<PerJoin> searchPerformance(String keyword) {
		return sqlSession.selectList("performance.searchPerformance", keyword);
	}

//	@Override
//	public List<PerJoin> categoryListView(String category, int limit, int offset) {
//		RowBounds rowBounds = new RowBounds(offset, limit);
//		return sqlSession.selectList("performance.categoryListView", category, rowBounds);
//	}
	@Override
	public List<PerJoin> categoryListView(Map<String, Object> map) {
		return sqlSession.selectList("performance.categoryListView", map);
	}

	@Override
	public int selectCategoryListTotalContents(String category) {
		return sqlSession.selectOne("performance.selectCategoryListTotalContents", category);
	}	
	

	public List<Performance> searchPerformanceList(Map<String, Object> map) {
		return sqlSession.selectList("performance.searchPerformanceList", map);
	}

	@Override
	public int selectTotalPerformanceList(Map<String, Object> map) {
		return sqlSession.selectOne("performance.selectTotalPerformanceList", map);
	}

	@Override
	public List<Performance> allPerformanceList(Map<String, Object> map) {
		return sqlSession.selectList("performance.allPerformanceList", map);
	}

	@Override
	public int totalAllPerformanceList() {
		return sqlSession.selectOne("performance.totalAllPerformanceList");
	}

	@Override
	public List<Performance> recommendList() {
		return sqlSession.selectList("performance.recommendList");
	}
	
	@Override
	public List<Schedule> selectDate(Map<String, Object> param) {
		return sqlSession.selectList("performance.selectDate", param);
	}

	@Override
	public int perDelete(int perNo) {
		return sqlSession.delete("performance.perDelete", perNo);
	}

	@Override
	public List<Performance> selectPerRank(Map<String, Object> param) {
		return sqlSession.selectList("performance.selectPerRank", param);
	}

	@Override
	public List<Performance> selectPickList() {
		return sqlSession.selectList("performance.selectPickList");
	}

	@Override
	public List<CommentPerList> commentPerList(String boardCommentWriter) {
		return sqlSession.selectList("performance.commentPerList", boardCommentWriter);
	}
	
	
	@Override
	public int selectScheduleHall(int schNo) {
		return sqlSession.selectOne("performance.selectScheduleHall",schNo);
	}

	@Override
	public PerformanceHall selectOneTheater(int theaterNo) {
		return sqlSession.selectOne("performance.selectOneTheater",theaterNo);
	}
	
	@Override
	public List<PerJoin> allPerformanceList() {
		return sqlSession.selectList("performance.allPerJoinList");
	}

	@Override
	public List<Performance> selectCategoryList(String category) {
		return sqlSession.selectList("performance.selectCategoryList", category);
	}

	
	
}
