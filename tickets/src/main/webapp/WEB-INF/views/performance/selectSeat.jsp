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
<title>TICATS</title>
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
body {
  font-family: 'Roboto', sans-serif;
  background-color:#fafafa;
}
::-webkit-scrollbar { 
    display: none !important; // 윈도우 크롬 등
}
a {
	color: #b71a4c;
}
.front-indicator {
	width: 145px;
	margin: 5px 32px 15px 250px;
	background-color: #f6f6f6;	
	color: #adadad;
	text-align: center;
	padding: 3px;
	border-radius: 5px;
}
.wrapper {
	width: 100%;
	text-align: center;
  margin-top:150px;
}
.container {
	margin: 0 auto;
	width: 500px;
	text-align: left;
}
.booking-details {
	float: left;
	text-align: left;
	margin-left: 35px;
	font-size: 12px;
	position: relative;
	height: 401px;
}
.booking-details h2 {
	margin: 25px 0 20px 0;
	font-size: 17px;
}
.booking-details h3 {
	margin: 5px 5px 0 0;
	font-size: 14px;
}
div.seatCharts-cell {
	color: #182C4E;
	line-height: 15px;
	
}
div.seatCharts-seat {
	color: #FFFFFF;
	cursor: pointer;	
}
div.seatCharts-row {
	height: 35px;
}
div.seatCharts-seat.available {
	background-color: #B9DEA0;

}
div.seatCharts-seat.available.first-class {
	background-color: #e0e0e0;
}
div.seatCharts-seat.focused {
	background-color: #76B474;
}
div.seatCharts-seat.selected {
	background-color: #E6CAC4;
}
div.seatCharts-seat.unavailable {
	background-color: #472B34;
}
div.seatCharts-container {
	border-right: 1px dotted #adadad;
	width: 1000px;
	padding: 20px;
	float: left;
}
div.seatCharts-legend {
	padding-left: 0px;
	position: absolute;
	bottom: 16px;
}
ul.seatCharts-legendList {
	padding-left: 0px;
}
span.seatCharts-legendDescription {
	margin-left: 5px;
	line-height: 30px;
}
.checkout-button {
	display: block;
	margin: 10px 0;
	font-size: 14px;
}
#selected-seats {
	max-height: 90px;
	overflow-y: scroll;
	overflow-x: none;
	width: 170px;
}
.selected{
	border : 2px solid black !important;
}
.foo {
  width: 20px;
  height: 20px;
  margin: 5px;
  border: 1px solid rgba(0, 0, 0, .2);
}

.blue {
  background: #70D0EA;
}

.purple {
  background: #9076FF;
}

.brown {
  background: #BEA886;
}
.pink {
  background: pink;
}
.green {
  background: #AADE48;
}
</style>
</head>
<body>
	<div class="fixed-top" style="height:50px;padding:10px 50px 50px 50px;background-color:white;">
		<h3 style="float:left;">좌석선택 : ${performance.perTitle }</h3>
		<div class="select-date" style="float:left;width:250px;padding-left:50px;">
		
		</div>
	</div>
	<div id="test" class="seatCharts-container" tabindex="0" style="margin-top:50px;">
		  <div class="front-indicator">1F</div>

		  <% int count=1;
		  for(int i=1;i<11;i++){ %>
		<div class="seatCharts-row">
			<div class="seatCharts-cell seatCharts-space"><%= i %></div>
			<%for(int j=1;j<31;j++){ %>
			<div id="1F_<%=i %>행_<%=j %>열" role="checkbox" value="<%= count %>" aria-checked="false" focusable="true" tabindex="-1" 
				class="seatCharts-seat seatCharts-cell first-class available" onclick="select(this);"
				 <%int cnt1=0; %>
				 <%int cnt2=0; %>
				<c:set var="doneLoop" value="false"/>
				<c:forEach items="${ selectedList }" var="select">
				<c:if test="${not doneLoop}">
				<c:set var="count" value="<%=count %>"/>
					<c:if test="${ select.seatNo eq count}">
						<% cnt1=1; %>					
						<c:set var="doneLoop" value="true" />
					</c:if>
				</c:if>
				</c:forEach>
				 <%if(cnt1==1 && cnt2==0) {%>
				 	style="pointer-events: none;
						background-color:#F4F4F4;"
				 <%} else{%>
				 	style="<% if(i<6 && (j>5 && j<25)){ %>
						background-color:#BEA886;
					<%}else if((i<6 && (j<=5 || j>=25))|| (i>=6 && i<8) ){%>
						background-color:#9076FF;
					<%}else{%>
						background-color:#70D0EA;
					<%}%>"
				 <%} %>
				<% count++; %>
				>
				</div>
			<%} %>
		</div>
		<%
		}
			%>
	</div>
	
	
	<div class="position-fixed text-center" style="top:60px;left:750px;width:400px;height:1000px;background-color:white;line-height:30px; ">
	<div class="show-seat h-30">
		
	</div>
	<div class="text-center" style="padding-left:50px;">
		<div class="seat-grade mx-3 mb-3" style="margin-top:50px;">
			<table>
              <tr>
              	<td colspan="3">좌석별 가격 현황</td>
              </tr>
              <tr>
              	<td><div class="foo brown"></div></td>
              	<td>S석</td>
              	<td>50,000원</td>
              </tr>
              <tr>
              	<td><div class="foo purple"></div></td>
              	<td>A석</td>
              	<td>45,000원</td>
              </tr>
              <tr>
              	<td><div class="foo blue"></div></td>
              	<td>B석</td>
              	<td>40,000원</td>
              </tr>
              <!-- <tr>
              	<td><div class="foo green"></div></td>
              	<td>A석</td>
              	<td>45,000원</td>
              </tr>
              <tr>
              	<td><div class="foo pink"></div></td>
              	<td>B석</td>
              	<td>40,000원</td>
              </tr>			 -->	
          </table>
		</div>
		<form:form action="${pageContext.request.contextPath}/performance/salePerformance.do" method="POST">
		<input type="hidden" name="schNo" value="${ schNo }" />
		<input type="hidden" name="memberId" value="${ memberId }"/>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<div class="side-bar d-block text-left" style="padding-left:20px;">
		
		</div>
		<div class="button" style="padding-left:20px;padding-top:30px;">
			<button id="complete-select" type="submit" class="btn btn-secondary disabled d-block" style="float:left;">좌석 선택 완료</button>
		</div>
		</form:form>
	</div>
	<div class="loading position-absolute" style="top:0;left:0;opacity:0.7;width:1000px;height:1000px;background-color:white;display:none;">
		<img class="position-absolute" src="${pageContext.request.contextPath }/resources/images/etc/loading.png" style="top:380px;left:300px;"/>
	</div>
	</div>
	<script>
		function select(e){
				$('#complete-select').removeClass('btn-primary');
				$('#complete-select').addClass('btn-secondary');
				var memberId = JSON.stringify("${ memberId }");
			    	console.log("seatNo" + $(e).attr("value"));
			    	console.log("schNo" + ${ schNo });
			    	console.log("${ memberId }");
			if($(e).hasClass('selected')==true){
					var select = {
						seatNo : $(e).attr("value"),
						schNo : ${ schNo },
						memberId : memberId
			    	 };

					console.log("select : "+select);

					var jsonStr = JSON.stringify(select);
					console.log("jsonStr = "+jsonStr);

					$(document).ajaxSend(function(e, xhr, options) {
						xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
						});
					$.ajax({
						url : "${ pageContext.request.contextPath }/performance/removeSelect",
						data : jsonStr,
						method : "POST",
						contentType : "application/json; charset=utf-8",
						success : function(data){
							$(e).removeClass('selected');
							$("."+e.id).remove();
							console.log(data);
						},
						error : function(xhr, status, err){
							console.log("처리실패", xhr, status, err);
						},
						complete : function(){
							
						}
					});
				}else{
					$('#complete-select').removeClass('btn-secondary');
					$('#complete-select').addClass('btn-primary');

					var memberId = JSON.stringify('${ memberId }');
					var select = {
						seatNo : $(e).attr("value"),
						schNo : ${ schNo },
						memberId : memberId
			    	 };

					console.log("select : "+select.seatNo);

					var jsonStr = JSON.stringify(select);
					console.log("jsonStr = "+jsonStr);

					$(document).ajaxSend(function(e, xhr, options) {
						xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
						});
					$.ajax({
						url : "${ pageContext.request.contextPath }/performance/addSelect",
						data : jsonStr,
						method : "POST",
						contentType : "application/json; charset=utf-8",
						success : function(data){
							$(e).addClass('selected');
							$('.side-bar').append("<h4 class="+e.id+" style='display:block;line-height:30px;'>"+e.id+"</h4>");
							$('.side-bar').append("<input class="+e.id+" type='hidden' name='seatNo' value="+select.seatNo+" />");
							$('.side-bar').append("<input class="+e.id+" type='hidden' name='seatName' value="+e.id+" />");
							},
						error : function(xhr, status, err){
							console.log("처리실패", xhr, status, err);
						},
						complete : function(){
							
						}
					});
				
				}
			
		};
		$('.selected').click(function(){
			$(this).removeClass('selected');
		});
		
		/* window.onbeforeunload = function(e){
				$('.loading').css('display','');
			}; */

	</script>
	

</body>
</html>