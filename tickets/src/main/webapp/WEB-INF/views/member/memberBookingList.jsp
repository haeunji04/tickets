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
	 .table th, .table td {
    padding: 0.75rem;
    vertical-align: middle !important; 
    border-top: 1px solid #dee2e6;
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
	 ul{
	 	padding:0;
	 }

	</style>
	<script>
		$(function(){
			$('.rounded-pill').click(function(){
				$('.rounded-pill').css('z-index','');
				$(this).css('z-index','5');
				
			});
			$('#pill1').click(function(){
				$('#reserv-list').css('display','block');
				$('#reserv-cn-list').css('display','none');
			});
			$('#pill2').click(function(){
				$('#reserv-cn-list').css('display','block');
				$('#reserv-list').css('display','none');
			});
			
		});
	</script>
	<div class="form-group text-center my-5" style="position:relative;">
		<div class="reserve-btn">
	    <button id="pill1" class="btn btn-outline-secondary rounded-pill mx-auto" style="width:200px;height:40px;position:absolute;left:500px;z-index:1;background-color:white;">예매확인</button>
		</div>
		<div class="reserve-cn-btn" style="margin-left:180px;">
	    <button id="pill2" class="btn btn-outline-secondary rounded-pill" style="width:200px;height:40px;position:relative;z-index:0;background-color:white;">예매취소</button>
		</div>
  	</div>
  	<div class="list text-center" >
	  	<div id="reserv-list" class="reserv-list mx-auto" style="width:90%;">
	  		<table class="table table-hover ">
			<tr class="border-top border-bottom" >
				<th style="width:80px;">예매일</th>
				<th colspan="2" id="perInfo" style="width:600px;">공연정보</th>
				<th>예매정보</th>
				<th>예매상태</th>
			</tr>
			<!-- 티켓예매테이블 -->
			<c:forEach items="${ list }" var="pay">
			<tr class="border-bottom">
				<td class="px-3" valign="middle">${ dateformat.format(pay.payDate) }</td>
				<td align="right">
					<a class="text-reset" href="${pageContext.request.contextPath }/member/memberOneBooking.do?orderNo=${ pay.orderNo }">
						<img style="width:120px;height:160px;top:0;left:10px;" src="<c:url value='/resources/upload/performance/${ pay.perImgRenamedFileName}' />"/>
					</a>
				</td>
				<td align="left">
					<a href="${pageContext.request.contextPath }/member/memberOneBooking.do" style="text-decoration: none; color: black;">
						<p>
							<span class="d-block"><strong>${ pay.perTitle }</strong> <br />
								<small>${ dateformat2.format(pay.perStartDate) } - ${ dateformat2.format(pay.perEndDate) }</small> <br />
								${ pay.theaterName }
							</span>
						</p>
					</a>
					<!-- </div> -->
				</td>
				<td>
					<div class="booking-info" style="text-align:left;">
						<dl>
							<dt>예약 정보</dt>
							<dd>${ pay.orderNo }</dd>
						</dl>
						<dl>
							<dt>관람일</dt>
							<dd>${ dateformat.format(pay.schDateTime) }</dd>
						</dl>
						<dl>
							<dt>매수</dt>
							<dd>M045355</dd>
						</dl>
						<dl>
							<dt>취소가능</dt>
							<dd>2020.11.26(목) 17:00 까지</dd>
						</dl>
					</div>
				</td>
				<td>
					<p>예매완료(미입금)</p>
					<p>결제방식(${ pay.payOption })</p>
				</td>
			</tr>
			</c:forEach>
		</table>
			<div class="text-center">
				<c:if test="${ empty list }"> 
					<p>예매한 공연이 없습니다.</p>
				</c:if>
			</div>
	  	</div>
	</div>
  	<div class="list text-center" >
	  	<div id="reserv-cn-list" class="reserv-cn-list mx-auto" style="width:90%; display:none;">
	  		<table class="table table-hover ">
			<tr class="border-top border-bottom" >
				<th style="width:80px;">예매일</th>
				<th colspan="2" id="perInfo" style="width:600px;">공연정보</th>
				<th style="width:270px;">예매정보</th>
				<th style="width:190px;">예매상태</th>
			</tr>
			<!-- 티켓예매테이블 -->

			<tr class="border-bottom">
				<td class="px-3" valign="middle">2020.09.22</td>
				<td align="right">
					<!-- <div class="performInfo" style="position:relative;text-align:left;padding-right:50px;"> -->
					<a class="text-reset" href="#">
						<img style="width:120px;height:160px;top:0;left:10px;" src="<c:url value='/resources/images/poster/캣츠.jpg' />"/>
					</a>
				</td>
				<td align="left">
					<a href="#" style="text-decoration: none; color: black;">
						<p>
							<span class="d-block"><strong>캣츠</strong> <br />
								<small>2020.09.10-2020.09.30</small> <br />
								롯데콘서트몰
							</span>
						</p>
					</a>
					<!-- </div> -->
				</td>
				<td>
					<div class="booking-info" style="text-align:left;">
						<dl>
							<dt>예약 정보</dt>
							<dd>[취소]M045355</dd>
						</dl>
						<dl>
							<dt>관람일</dt>
							<dd>2020.09.22(목)</dd>
						</dl>
						<dl>
							<dt>매수</dt>
							<dd>M045355</dd>
						</dl>
						<dl>
							<dt>취소일</dt>
							<dd>2020.09.22(목) 12:30</dd>
						</dl>
					</div>
				</td>
				<td>
					<p>취소완료</p>
				</td>
			</tr>
		</table>
	  	</div>
  	</div>
  	<div class="mt-3">
  		<pre>
  			취소 안내
			예매상세에서 상세내역 확인 및 취소를 진행하실 수 있습니다.
			배송이 시작된 경우 취소마감시간이전까지 멜론티켓 고객센터로 티켓을 반환해주셔야 환불이 가능하며, 도착한 일자 기준으로 취소수수료가 부과됩니다.
			(* 단, 반환된 티켓의 배송료는 환불되지 않으며 일괄배송 상품의 경우 취소에 대한 자세한 문의는 고객센터로 문의해 주시기 바랍니다.)
  		</pre>
  	</div>

	<!-- footer -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
