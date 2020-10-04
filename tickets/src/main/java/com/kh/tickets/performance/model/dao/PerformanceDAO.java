package com.kh.tickets.performance.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.tickets.performance.model.vo.MyRecentlyPerList;
import com.kh.tickets.performance.model.vo.MyWishList;
import com.kh.tickets.performance.model.vo.PerJoin;
import com.kh.tickets.performance.model.vo.Performance;
import com.kh.tickets.performance.model.vo.PerformanceHall;
import com.kh.tickets.performance.model.vo.RecentlyPerList;
import com.kh.tickets.performance.model.vo.Schedule;
import com.kh.tickets.performance.model.vo.WishList;

public interface PerformanceDAO {

	int performanceRegister(Performance performance);

	List<Performance> selectPerformanceList();

	List<PerJoin> categoryListView(String category);

	String getCategoryName(String category);

	int approvePerRegister(int perNo);

	List<Performance> adminApprovalPerList();


	List<Performance> companyPerList(String memberId);

	Performance selectOnePerformance(int perNo);

	List<PerformanceHall> searchHallName(String keyword);

	int perUpdate(Performance performance);
	
	int wishListInsert(WishList wishList);

	int wishListDelete(WishList wishList);

	List<MyWishList> wishListView(String memberId);
	
	int getPerNo(String perTitle);

	int insertSchedule(Map<String, Object> param);

	List<MyRecentlyPerList> recentlyPerList(String memberId);

	int recentlyPerListInsert(RecentlyPerList recentlyPerList);

	int recentlyPerListDelete(RecentlyPerList recentlyPerList2);

	List<Schedule> selectPerSchedule(int perNo);

	int addRecommendedPer(int perNo);

	int turnOffRecommendedPer(int perNo);

	int deleteDate(int schNo);
	
	List<PerJoin> searchPerformance(String keyword);


	List<PerJoin> categoryListView(String category, int limit, int offset);

	int selectCategoryListTotalContents(String category);
	
	List<Performance> searchPerformanceList(Map<String, Object> map);

	int selectTotalPerformanceList(Map<String, Object> map);
	
	List<Performance> allPerformanceList(Map<String, Object> map);

	int totalAllPerformanceList();


}
