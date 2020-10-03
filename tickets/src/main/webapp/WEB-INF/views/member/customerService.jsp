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
/* 	 .nav-item{
	    border: solid 1px #aaa;
    	width: 170px;
	 } */
	 #btn-add{
	    color: #eb6864;
    	border-color: #eb6864;
    }
    #notice-title{
    	text-align: left;
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
	<div class="form-group text-center">
		<nav>
			<div class="nav nav-tabs" id="nav-tab" role="tablist">
				<a class="nav-item nav-link active" id="notice-list-tab" data-toggle="tab" href="#notice-list" role="tab" aria-controls="notice-list" aria-selected="true">공지사항</a>
				<a class="nav-item nav-link" id="howto-list-tab" data-toggle="tab" href="#howto-list" role="tab" aria-controls="howto-list" aria-selected="false">이용안내</a>
				<a class="nav-item nav-link" id="faq-list-tab" data-toggle="tab" href="#faq-list" role="tab" aria-controls="faq-list" aria-selected="false">FAQ</a>
			</div>
		</nav>
		<div class="tab-content" id="nav-tabContent">
			<!-- 공지사항 -->
			<div class="tab-pane fade show active" id="notice-list" role="tabpanel" aria-labelledby="notice-list-tab">
				<!-- 관리자에게만 보이는 버튼 -->
				<div style="float: right; padding: 10px 5px;">
					<input type="button" value="글쓰기" id="btn-add" class="btn" onclick="goCustomerServiceBoardForm();"/>
				</div>
				<div style="padding-top: 20px; text-align:left">
					<p style="font-weight: bold; font-size: 20px">공지사항</p>
					<table id="tbl-board" class="table table-striped table-hover" style="width:90%; margin: auto">
						<tr>
							<th>No</th>
							<th>분류</th>
							<th>제목</th>
							<th>등록일</th>
						</tr>
						<tr>
							<td>3</td>
							<td>안내</td>
							<td id="notice-title">추석 연휴 배송업체 업무 실시 마감 안내</td>
							<td>2020.09.25</td>
						</tr>
						<tr>
							<td>2</td>
							<td>서비스점검</td>
							<td id="notice-title">［시스템작업］SK텔링크 전산작업으로 인한 결제중단 안내</td>
							<td>2020.09.24</td>
						</tr>
						<tr>
							<td>1</td>
							<td>서비스점검</td>
							<td id="notice-title">［시스템작업］09.13(일) 경남은행 전산작업으로 인한 결제중단 안내</td>
							<td>2020.09.11</td>
						</tr>
					</table>
				</div>
			</div>
			
			<!-- 이용안내 -->
			<div class="tab-pane fade" id="howto-list" role="tabpanel" aria-labelledby="howto-list-tab"  style="margin-top: 20px">
				<div class="form-group text-center">
					<ul class="nav nav-pills mb-3 justify-content-center" id="pills-tab" role="tablist">
						<li class="nav-item">
							<a class="nav-link active" id="pills-home-tab" data-toggle="pill" href="#pills-home" role="tab" aria-controls="pills-home" aria-selected="true">예매방법</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" id="pills-profile-tab" data-toggle="pill" href="#pills-profile" role="tab" aria-controls="pills-profile" aria-selected="false">취소/환불</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" id="pills-contact-tab" data-toggle="pill" href="#pills-contact" role="tab" aria-controls="pills-contact" aria-selected="false">발권/배송</a>
						</li>
					</ul>
					<div class="tab-content" id="pills-tabContent">
						<div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
							티켓츠의 예매 방법을 안내드립니다.
						</div>
						<div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
							티켓츠의 취소/환불 규정을 안내드립니다.
						</div>
						<div class="tab-pane fade" id="pills-contact" role="tabpanel" aria-labelledby="pills-contact-tab">
							티켓츠의 발권/배송 관련한 안내드립니다.
						</div>
					</div>
			  	</div>
			</div>
				
			<!-- FAQ -->	
			<div class="tab-pane fade" id="faq-list" role="tabpanel" aria-labelledby="faq-list-tab">
				<!-- 관리자에게만 보이는 버튼 -->
				<div style="float: right; padding: 10px 5px;">
					<input type="button" value="글쓰기" id="btn-add" class="btn" onclick="goCustomerServiceBoardForm();"/>
				</div>
				<div style="padding-top: 20px; text-align:left">
					<p style="font-weight: bold; font-size: 20px">자주하는 질문 BEST 10</p>
					<table id="tbl-board" class="table table-striped table-hover" style="width:90%; margin: auto;">
						<tr>
							<td>1</td>
							<td>티켓예매</td>
							<td><a href="#none" onclick="javascript:getCont('1073195296', this);">공연예매는 어디서 할 수 있나요?</a></td>
						</tr>
						<!-- 클릭시 tr 추가 -->
						<tr>
							<td><div class="arrow"><span></span></div></td>
							<td colspan="2">
								<p>예매 완료 후에는 좌석을 변경할 수 없습니다.</p>
								<p>변경을 원하시는 경우 [마이티켓 > 예매/취소] 메뉴에서 해당 예매 건을 취소하시고 재 예매하셔야 합니다.</p>
								<p>예매 건을 취소하는 경우 예매수수료, 취소수수료는 멜론티켓 수수료 정책에 따라 발생합니다.</p>																
							</td>
						</tr>
						<tr>
							<td>2</td>
							<td>티켓예매</td>
							<td>공연예매 후 좌석변경을 할 수 있나요?</td>
						</tr>
						<tr>
							<td>3</td>
							<td>티켓예매</td>
							<td>모바일 티켓 예매는 어떻게 하나요?</td>
						</tr>
											<tr>
							<td>4</td>
							<td>티켓예매</td>
							<td>무통장입금 결제수단은 언제까지 이용가능 한가요?</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
	
	<!-- footer -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
