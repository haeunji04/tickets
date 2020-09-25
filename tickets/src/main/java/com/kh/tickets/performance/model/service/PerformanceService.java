package com.kh.tickets.performance.model.service;

import java.util.List;

import com.kh.tickets.performance.model.vo.MyWishList;
import com.kh.tickets.performance.model.vo.Performance;
import com.kh.tickets.performance.model.vo.PerformanceHall;
import com.kh.tickets.performance.model.vo.WishList;

public interface PerformanceService {

	int performanceRegister(Performance performance);

	List<Performance> selectPerformanceList();

	List<Performance> categoryListView(String category);

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
}
