package com.kh.tickets.performance.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.tickets.performance.model.dao.PerformanceDAO;
import com.kh.tickets.performance.model.vo.CommentPerList;
import com.kh.tickets.performance.model.vo.MyRecentlyPerList;
import com.kh.tickets.performance.model.vo.MyWishList;
import com.kh.tickets.performance.model.vo.PerJoin;
import com.kh.tickets.performance.model.vo.Performance;
import com.kh.tickets.performance.model.vo.PerformanceHall;
import com.kh.tickets.performance.model.vo.RecentlyPerList;
import com.kh.tickets.performance.model.vo.Schedule;
import com.kh.tickets.performance.model.vo.Seat;
import com.kh.tickets.performance.model.vo.WishList;

@Service
public class PerformanceServiceImpl implements PerformanceService {
	
	@Autowired
	private PerformanceDAO performanceDAO;

	@Override
	public int performanceRegister(Performance performance) {
		return performanceDAO.performanceRegister(performance);
	}

	@Override
	public List<Performance> selectPerformanceList() {
		return performanceDAO.selectPerformanceList();
	}

//	@Override
//	public List<PerJoin> categoryListView(String category) {
//		return performanceDAO.categoryListView(category);
//	}

	@Override
	public String getCategoryName(String category) {
		return performanceDAO.getCategoryName(category);
	}

	@Override
	public int approvePerRegister(int perNo) {
		return performanceDAO.approvePerRegister(perNo);
	}

	@Override
	public List<Performance> adminApprovalPerList() {
		return performanceDAO.adminApprovalPerList();
	}

	@Override

	public List<Performance> companyPerList(String memberId) {
		return performanceDAO.companyPerList(memberId);
	}

	@Override
	public PerJoin selectOnePerformance(int perNo) {
		return performanceDAO.selectOnePerformance(perNo);
	}

	@Override
	public PerJoin selectOnePerJoin(int perNo) {
		return performanceDAO.selectOnePerJoin(perNo);
	}

	public List<PerformanceHall> searchHallName(String keyword) {
		return performanceDAO.searchHallName(keyword);
	}

	@Override
	public int perUpdate(Performance performance) {
		return performanceDAO.perUpdate(performance);
	}	

	@Override
	public int wishListInsert(WishList wishList) {
		return performanceDAO.wishListInsert(wishList);
	}

	@Override
	public int wishListDelete(WishList wishList) {
		return performanceDAO.wishListDelete(wishList);
	}

	@Override
	public List<MyWishList> wishListView(String memberId) {
		return performanceDAO.wishListView(memberId);
	}
	
	public int getPerNo(String perTitle) {
		return performanceDAO.getPerNo(perTitle);
	}

	@Override
	public int insertSchedule(Map<String, Object> param) {
		return performanceDAO.insertSchedule(param);
	}	

	@Override
	public List<MyRecentlyPerList> recentlyPerList(String memberId) {
		return performanceDAO.recentlyPerList(memberId);
	}

	@Override
	public int recentlyPerListInsert(RecentlyPerList recentlyPerList) {
		return performanceDAO.recentlyPerListInsert(recentlyPerList);
	}

	@Override
	public int recentlyPerListDelete(RecentlyPerList recentlyPerList2) {
		return performanceDAO.recentlyPerListDelete(recentlyPerList2);
	}

	@Override
	public List<Schedule> selectPerSchedule(int perNo) {
		return performanceDAO.selectPerSchedule(perNo);
	}

	@Override
	public int addRecommendedPer(int perNo) {
		return performanceDAO.addRecommendedPer(perNo);
	}

	@Override
	public int turnOffRecommendedPer(int perNo) {
		return performanceDAO.turnOffRecommendedPer(perNo);
	}

	@Override
	public int deleteDate(int schNo) {
		return performanceDAO.deleteDate(schNo);
	}

	@Override
	public List<PerJoin> searchPerformance(String keyword) {
		return performanceDAO.searchPerformance(keyword);
	}

//	@Override
//	public List<PerJoin> categoryListView(String category, int limit, int offset) {
//		return performanceDAO.categoryListView(category, limit, offset);
//	}
	
	@Override
	public List<PerJoin> categoryListView(Map<String, Object> map) {
		return performanceDAO.categoryListView(map);
	}
	
	@Override
	public int selectCategoryListTotalContents(String category) {
		return performanceDAO.selectCategoryListTotalContents(category);
	}	

	public List<Performance> selectPerformanceList(Map<String, Object> map) {
		return performanceDAO.searchPerformanceList(map);
	}

	@Override
	public int selectTotalPerformanceList(Map<String, Object> map) {
		return performanceDAO.selectTotalPerformanceList(map);
	}

	@Override
	public List<Performance> allPerformanceList(Map<String, Object> map) {
		return performanceDAO.allPerformanceList(map);
	}

	@Override
	public int totalAllPerformanceList() {
		return performanceDAO.totalAllPerformanceList();
	}

	@Override
	public List<Performance> recommendList() {
		return performanceDAO.recommendList();
	}

	@Override
	public List<Schedule> selectDate(Map<String, Object> param) {
		return performanceDAO.selectDate(param);
	}

	@Override
	public int perDelete(int perNo) {
		return performanceDAO.perDelete(perNo);
	}

	@Override
	public List<Performance> selectPerRank(Map<String, Object> param) {
		return performanceDAO.selectPerRank(param);
	}

	@Override
	public List<Performance> selectPickList() {
		return performanceDAO.selectPickList();
	}

	@Override
	public List<CommentPerList> commentPerList(String boardCommentWriter) {
		return performanceDAO.commentPerList(boardCommentWriter);
	}
	
	@Override
	public int selectScheduleHall(int schNo) {
		return performanceDAO.selectScheduleHall(schNo);
	}

	@Override
	public PerformanceHall selectOneTheater(int theaterNo) {
		return performanceDAO.selectOneTheater(theaterNo);
	}

	@Override
	public List<PerJoin> allPerJoinList(Map<String, Object> param) {
		return performanceDAO.allPerJoinList(param);
	}


	@Override
	public List<Performance> selectCategoryList(String category) {
		return performanceDAO.selectCategoryList(category);
	}

	@Override
	public List<Seat> selectSeatList(int theaterNo) {
		return performanceDAO.selectSeatList(theaterNo);
	}

	@Override
	public int addSelect(Map<String, Object> param) {
		return performanceDAO.addSelect(param);
	}
	
	

	
}
