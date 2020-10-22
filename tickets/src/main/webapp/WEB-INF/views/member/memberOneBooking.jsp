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
		.booking-one{
			background-position:center;
			background-size:1000px;
			background-repeat:no-repeat;
			height:400px;
			
		}
		.table td{
			border:0;
			padding-bottom:0;
			font-size:15px;
		}
		.order td{
			padding:10px;
			padding-left:30px;
		}
		.order td:last-child{
			padding-left:100px;
		}
		.seat th,td{
			padding-left:70px;
			padding-right:70px;
			padding-top:10px;
			padding-bottom:10px;
		}
		.fees th,td{
			font-size:15px;
		}
	</style>
	<script>
	function checkAll(){
	    var check = document.getElementsByName("check");
	    var all = document.getElementById("allcheck");
	    for(var i=0; i<check.length; i++){
	    	check[i].checked = all.checked;
	    }
	}
	</script>
	

		<c:forEach items="${ list }" var="pay" varStatus="status">
		<div class="total-container p-3">
		<h4 class="text-center">── 티켓 ${ status.count } ──</h4>
		<div class="booking-one" style="background-image:url('${pageContext.request.contextPath}/resources/images/etc/1.png');">
			<div class="table" style="padding-top:80px;padding-left:160px;">
			<table id="perform-info-tbl">
			
			<tr>
				<td rowspan=5 colspan=3>
					<%-- <img src="${pageContext.request.contextPath }/resources/images/poster/캣츠.jpg" 
	                    		 style="width: 150px;"> 	 --%>			
					<img src="<c:url value='/resources/upload/performance/${ pay.perImgRenamedFileName}' />" 
	                    		 style="width: 150px;"> 				
				</td>
				<td colspan=5><h5>${ pay.perTitle }</h5></td>
			</tr>
			<tr>
				<td>예매 번호</td>
				<td>${ pay.orderNo }</td>
				<td></td>
				<td>공연장</td>
				<td>${ pay.theaterName }</td>
			</tr>
			<tr>
				<td>예매일시</td>
				<td>${ dateformat2.format(pay.payDate) }</td>
				<td></td>
				<td>예매자</td>
				<td>${ pay.name }</td>
			</tr>
			<tr>
				<td>관람일시</td>
				<!-- <td>2020.11.27(금) 19:30</td> -->
				<td>${ dateformat2.format(pay.schDateTime) }</td>
				<td></td>
				<!-- <td>취소가능</td>
				<td>관림일시 하루 전날까지(기간에 따라 수수료 차등)</td> -->
			</tr>
			<tr>
				<td>매수</td>				
				<td>1매</td>				
				<td></td>				
				<td>좌석번호</td>				
				<td>${ pay.seatName }</td>	 			
			</tr>
			</table>
			</div>	
		</div>
		<br />
		<div class="person-perform">
		<h4 class="text-left mb-3">구매내역</h4>	
			
			<div class="perform border py-4" style="width:100%;">
				<table class="order">
					<tr>
						<td>티켓금액</td>
						<td>${ pay.ticPrice }원</td>
					</tr>
					<!-- <tr>
						<td>예매 수수료</td>
						<td>500</td>
					</tr>
					<tr>
						<td>가격할인</td>
						<td>0</td>
					</tr> 
					<tr>
						<td>총 가격</td>
						<td>50,500원</td>
					</tr> -->
					<tr>
						<td>결제방식</td>
						<td>${ pay.payOption }</td>
					</tr>
				</table>
			</div>
		</div>
		<br />
		<%-- <c:if test="${ pay.payOption eq '' }"></c:if>  --%>
<%-- 		<div class="person-perform mt-3">

		<h4 class="text-left d-inline-block mb-3">무통장입금 결제내역</h4>	
		<!-- <div class="more" style="float:right;">
				<button class="btn btn-outline-secondary rounded-pill d-inline-block text-right" value="">결제수단변경</button>
		</div> -->
			<div class="perform border py-4" style="width:100%;">

				<table class="order">
					<tr>
						<td>결제방법</td>
						<td>${ pay.payOption }</td>
					</tr>
					<tr>
						<td>입금마감시간</td>
						<td>${ dateformat.format(pay.payDate) } 23시 59분</td>
					</tr>
					<tr>
						<td>입금계좌</td>
						<td>농협 79015826684536</td>
					</tr>
					<tr>
						<td>결제방법</td>
						<td>무통장</td>
					</tr>
					<tr>
						<td>예금주명</td>
						<td>TiCats</td>
					</tr>
					<tr>
						<td>입금상태</td>
						<td>미입금</td>
					</tr>
				</table>
			</div>
		</div> --%>
		
		<!-- <div class="person-perform mt-3">
		<h4 class="text-left d-inline-block mb-3">구매좌석</h4>	
			<div class="more" style="float:right;">
				<input type="checkbox" name="allcheck" id="allcheck" onchange="checkAll();" />
				<label for="allcheck">전체선택</label>
			</div>
			<div class="perform border pt-4" style="width:100%;text-align:center">
				<table class="seat" align="center">
					<tr>
						<th>좌석등급</th>
						<th>좌석번호</th>
						<th>가격등급</th>
						<th>구매</th>
						<th>예매/취소</th>
					</tr>
					<tr>
						<td>S석</td>
						<td>1층 7열 26번</td>
						<td>일반</td>
						<td>50,000원</td>
						<td>
							<label for="check" style="margin:0;">취소가능</label>
							<input type="checkbox" name="check" />
						</td>
					</tr>
					
				</table>
			</div>

		</div> -->
				<!-- <button type="button" class="btn btn-outline-primary rounded-pill btn-lg btn-block mx-auto mb-3" style="width:30%">예매취소 요청</button> -->
		<hr class="mt-5"/>
		</c:forEach>
		<!-- ========================================================= -->
		<div class="person-perform mt-5">
		<h4 class="text-left d-inline-block mb-3">취소수수료</h4>	
			<div class="perform border py-4" style="width:100%;text-align:center">
				<table class="fees" align="center">
					<tr>
						<th>취소기간</th>
						<th>미부과기간</th>
						<th>예매후 8일~관람일 10일 이내</th>
						<th>관람일 7일전</th>
						<th>관람일 1일전</th>
					</tr>
					<tr>
						<td>취소수수료</td>
						<td>없음</td>
						<td>장당 4000원</td>
						<td>티켓의 10%</td>
						<td>티켓의 20%</td>
					</tr>
				</table>
			</div>
		</div>
		<div class="rule mt-3">
		<pre style="font-size:12px;line-height:20px;">
			유의사항
			취소마감시간 이후 또는 관람일 당일 예매하신 건에 대해서는 취소/변경/환불이 불가합니다.
			예매수수료는 예매 당일 밤 12시 이전까지 취소 시 환불 가능합니다.
			구매한 모바일티켓을 타인에게 전달한 경우, 구매자 본인에게 티켓이 회수된 후에 예매취소가 가능합니다.
			예매취소 시점과 결제 시 사용하신 신용카드사의 환불 처리기준에 따라 취소금액의 환급방법과 환급일은 다소 차이가 있을 수 있습니다.
			신용카드 할부결제로 구매하신 과티켓 수량의 일부를 취소하실 경우, 신용카드사의 사정에 따라 혜택(무이자 할부 등)의 적용 여부가 달라질 수 있음을 유의하시기 바랍니다.
			기타 문의사항은 이용안내를 참조하시거나 고객센터 1899-0042 혹은 1:1문의를 이용하시기 바랍니다.
		</pre>
		</div>
		</div>
		
		
	<!-- footer -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
