<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- param 한글 encoding 처리 -->
<fmt:requestEncoding value="utf-8"/>
	<!-- header -->
	<jsp:include page="/WEB-INF/views/common/header.jsp">
		<jsp:param value="" name="pageTitle"/>
	</jsp:include>
	<style>
	 th{
	 	padding:10px;
	 }
	 dt{
	 	width:63px;
	 }
	 dd, dt{
	  display:inline-block;
	  font-size:12px;
	 }
	 dl{
	 	margin:0;
	 }
	 .reser-table{
	 	padding-left:100px;
	 	margin-top:40px;
	 }
	 .booking-info{
	 	margin-top:20px;
	 	margin-bottom:20px;
	 	margin-right:40px;
	 }
	 .performInfo{
	 	margin-right:80px;
	 }
	 ul{
	 	padding:0;
	 }
	 #btn-add{
	     color: #eb6864;
    	border-color: #eb6864;
    }
	</style>
	<script>
		$(function(){
			$('.rounded-pill').click(function(){
				$('.rounded-pill').css('z-index','');
				$(this).css('z-index','5');
			});
			$('#pill1').click(function(){
				$('#notice-list').css('display','block');
				$('#howto-list').css('display','none');
			});
			$('#pill2').click(function(){
				$('#reserv-cn-list').css('display','block');
				$('#reserv-list').css('display','none');
			});
			$('#pill3').click(function(){
				$('#reserv-cn-list').css('display','block');
				$('#reserv-list').css('display','none');
			});	
		});
	</script>
	<h3>고객센터</h3>
	<div class="form-group text-center" style="">
		<div class="notice-btn">
	    <button id="notice" class="btn btn-outline-secondary" style="width:200px;height:40px;position:relative;background-color:white;">공지사항</button>
		</div>
		<div class="howto-btn">
	    <button id="howto" class="btn btn-outline-secondary" style="width:200px;height:40px;position:relative;background-color:white;">이용안내</button>
		</div>
		<div class="faq-btn">
	    <button id="faq" class="btn btn-outline-secondary" style="width:200px;height:40px;position:relative;background-color:white;">FAQ</button>
		</div>
		<div class="qna-btn">
	    <button id="qna" class="btn btn-outline-secondary" style="width:200px;height:40px;position:relative;background-color:white;">나의문의내역</button>
		</div>
  	</div>
  	

	<div class="list">
		<!-- 공지사항 -->
		<div id="notice-list" class="notice-list" style="display:block;">
			<!-- 관리자에게만 보이는 버튼 -->
			<div style="padding-bottom: 10px;">
				<input type="button" value="글쓰기" id="btn-add" class="btn" onclick="goCustomerServiceBoardForm();"/>
			</div>
			<table id="tbl-board" class="table table-striped table-hover">
				<tr>
					<th>No</th>
					<th>분류</th>
					<th>제목</th>
					<th>등록일</th>
				</tr>
				<tr>
					<td>3</td>
					<td>안내</td>
					<td>추석 연휴 배송업체 업무 실시 마감 안내</td>
					<td>2020.09.25</td>
				</tr>
				<tr>
					<td>2</td>
					<td>서비스점검</td>
					<td>［시스템작업］SK텔링크 전산작업으로 인한 결제중단 안내</td>
					<td>2020.09.24</td>
				</tr>
				<tr>
					<td>1</td>
					<td>서비스점검</td>
					<td>［시스템작업］09.13(일) 경남은행 전산작업으로 인한 결제중단 안내</td>
					<td>2020.09.11</td>
				</tr>
			</table>
		</div>
	
		<!-- 이용안내 -->
		<div id="howto-list" class="howto-list" style="display:block;">
			<div class="form-group text-center">
				<div class="notice-btn">
			    	<button id="pill1" class="btn btn-outline-secondary rounded-pill" style="width:200px;height:40px;position:absolute;left:350px;z-index:3;background-color:white;">예매방법</button>
				</div>
				<div class="howto-btn" style="margin-left:50px;">
			    	<button id="pill2" class="btn btn-outline-secondary rounded-pill" style="width:200px;height:40px;position:absolute;left:500px;z-index:2;background-color:white;">취소환불</button>
				</div>
				<div class="faq-btn" style="margin-left:50px;">
			    	<button id="pill3" class="btn btn-outline-secondary rounded-pill" style="width:200px;height:40px;position:absolute;left:650px;z-index:1;background-color:white;">발권/배송</button>
				</div>
		  	</div>
	  	</div>
		
		<!-- FAQ -->
		
		<!-- 나의 문의 내역 -->
	
	</div>
	
	
	<!-- footer -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
