<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"  %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/jquery.seat-charts.css">
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		
	<!-- bootstrap js: jquery load 이후에 작성할것.-->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

	<!-- css 시작  -->
		<!-- journal 테마 -->
       <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css" />
	<!-- css 끝 -->

<style>
li{
	list-style:none;
	display:inline-block;
}
li span,h5{
	display:inline-block;
}
a{
	text-decoration:none
}
.table{
	width:800px;
}
::-webkit-scrollbar { 
    display: none !important; // 윈도우 크롬 등
}
</style>
</head>
<body>
	
	<div id="test" class="seatCharts-container text-center" tabindex="0" style="margin-top:60px;margin-left:30px;width:800px;">
		<h3>결제가 완료되었습니다.</h3>
		 <p>${ date1 } 23시 59분까지 입금이 되어야 결제가 완료됩니다.</p>
		 <p>예매 상세내역은 마이페이지 > 예매확인/취소에서 확인하실 수 있습니다.</p>
    </div>
		
	<div id="test" class="seatCharts-container" tabindex="0" style="margin-top:60px;margin-left:30px;">
		<h5>결제내역</h5>
              <table class="table align-items-center table-flush">
                <tbody class="list">
                  <tr style="border-bottom:1px solid #eee;">
					<td>예매번호</td>
					<td>${ payed.orderNo }</td>
                  </tr>
                  <tr style="border-bottom:1px solid #eee;">
					<td>공연명</td>
					<td>${ performance.perTitle }</td>
                  </tr>
                  <tr style="border-bottom:1px solid #eee;">
					<td>공연장</td>
					<td>${ performanceHall.theaterName }</td>
                  </tr>
                  <tr style="border-bottom:1px solid #eee;">
					<td>좌석</td>
					<td>
					<c:forEach items="${ seatName }" var="seat">
						${ seat }<br/>
					</c:forEach>
					</td>
                  </tr>
                  <tr style="border-bottom:1px solid #eee;">
					<td>결제수단</td>
					<td>${ payed.payOption }
						
						</td>
                  </tr>
                  <tr style="border-bottom:1px solid #eee;">
					<td>취소가능일시</td>
					<td>${ date2 }</td>
                  </tr>
                  
                </tbody>
              </table>
            </div>
		
	</div>

	<div class="position-fixed text-center" style="top:60px;left:750px;width:400px;height:1000px;background-color:white;line-height:30px; ">
	<div class="show-seat h-30">
		
	</div>
	<div class="text-left" style="padding-left:50px;">
			<h5>${ performance.perTitle }</h5>
		<div class="seat-grade mx-3 mb-3 border text-left" style="margin-top:30px;">
			<ul style="padding-left:20px;">
				<li class="d-block" style="border-bottom:1px solid #eeeeee;line-height:40px;">2020.09.30</li>
				<li>
					총 ${ payed.seatCount }석 선택
					<br />
					<c:forEach items="${ seatName }" var="seat">
						${ seat }<br/>
					</c:forEach>
				</li>
			</ul>
		</div>
		<div class="side-bar d-block text-left" style="padding-left:20px;">
			<h5>티켓 결제 금액</h5>
			<div class="seat-grade mb-3 border text-left" style="margin-top:30px;width:316px;">
			<table>
				<tr>
					<td style="width:120px;padding-left:20px;">티켓금액</td>
					<td style="width:180px;text-align:right;padding-right:20px;">${ originTotal }원</td>
				</tr>
				<tr>
					<td style="width:120px;padding-left:20px;">기본가</td>
					<td style="width:180px;text-align:right;padding-right:20px;">${ originTotal }원</td>
				</tr>
				<tr>
					<td style="width:120px;padding-left:20px;">가격할인</td>
					<td style="width:180px;text-align:right;padding-right:20px;">${ sale }원</td>
				</tr>
				<tr>
					<td style="width:150px;padding-left:20px;"><h5>총결제금액</h5></td>
					<td style="width:150px;text-align:right;padding-right:20px;"><h5>${ payed.totPrice }원</h5></td>
				</tr>
			</table>
		</div>
			
		</div>
		<div class="button" style="padding-left:20px;padding-top:30px;">
		<button type="button" class="btn btn-secondary" style="width:150px;" onclick="window.close();">닫기</button>
		<button type="button" class="btn btn-primary" style="width:150px;" onclick="move();">예매내역확인</button>
		</div>
	</div>
	<div class="loading position-absolute" style="top:0;left:0;opacity:0.7;width:1000px;height:1000px;background-color:white;display:none;">
		<img class="position-absolute" src="${pageContext.request.contextPath }/resources/images/etc/loading.png" style="top:380px;left:300px;"/>
	</div>
	</div>
	<script>
		function move(){
			opener.parent.location.replace('${pageContext.request.contextPath }/member/memberBookingList.do');
		    self.close();

		}
	</script>
	

</body>
</html>