package com.kh.tickets.performance.model.service;

import java.util.List;
import java.util.Map;

import com.kh.tickets.performance.model.vo.Seat;
import com.kh.tickets.performance.model.vo.Selected;
import com.kh.tickets.performance.model.vo.Ticket;
import com.kh.tickets.performance.model.vo.CommentPerList;
import com.kh.tickets.performance.model.vo.MyRecentlyPerList;
import com.kh.tickets.performance.model.vo.MyWishList;
import com.kh.tickets.performance.model.vo.Pay;
import com.kh.tickets.performance.model.vo.PerJoin;
import com.kh.tickets.performance.model.vo.Performance;
import com.kh.tickets.performance.model.vo.PerformanceHall;
import com.kh.tickets.performance.model.vo.RecentlyPerList;
import com.kh.tickets.performance.model.vo.Schedule;
import com.kh.tickets.performance.model.vo.WishList;

public interface PerformanceService {

	int performanceRegister(Performance performance);

	List<Performance> selectPerformanceList();

	//List<PerJoin> categoryListView(String category);

	String getCategoryName(String category);

	int approvePerRegister(int perNo);

	List<Performance> adminApprovalPerList();


	List<Performance> companyPerList(String memberId);

	PerJoin selectOnePerformance(int perNo);
	
	PerJoin selectOnePerJoin(int perNo);

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

	//List<PerJoin> categoryListView(String category, int limit, int offset);
	List<PerJoin> categoryListView(Map<String, Object> map);
	
	int selectCategoryListTotalContents(String category);

	List<Performance> selectPerformanceList(Map<String, Object> map);
	
	int selectTotalPerformanceList(Map<String, Object> map);
	// 추천공연 페이징 시작
	List<Performance> allPerformanceList(Map<String, Object> map);

	int totalAllPerformanceList();
	// 추천공연 페이징 끝

	List<Performance> recommendList();

	List<Schedule> selectDate(Map<String, Object> param);

	int perDelete(int perNo);

	List<Performance> selectPerRank(Map<String, Object> param);

	List<Performance> selectPickList();

	List<CommentPerList> commentPerList(String boardCommentWriter);

	int selectScheduleHall(int schNo);

	PerformanceHall selectOneTheater(int theaterNo);

	List<PerJoin> allPerJoinList(Map<String, Object> param);

	List<Performance> selectCategoryList(String category);

	List<Seat> selectSeatList(int theaterNo);

	int addSelect(Map<String, Object> param);

	int removeSelect(Map<String, Object> param);

	List<PerJoin> todayPerList();

	List<Performance> openNewsPerList(Map<String, Object> map);

	int totalOpenNewsPerList();

	List<Selected> selectSelectedList(int schNo);

	int seatPrice(int i);

	int seatLength(int schNo);

	int selectOneSchedule(int schNo);

	int insertPay(Pay pay);

	Pay selectorderNo(Pay pay);

	int insertTicket(Ticket ticket);

	int updateSelected(Selected selected);




	
}
