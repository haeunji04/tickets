<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/jquery.seat-charts.css">
<style>
body {
	font-family: 'Roboto', sans-serif;
  background-color:#fafafa;
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
</style>
</head>
<body>
	<div class="fixed-top" style="height:50px;padding-left:50px;">
		<h3>좌석선택 : 캣츠<40주년> 내한공연</h3>
		<select class="custom-select">
	      <option selected="">2020.09.30 17:00</option>
	      <option value="1">2020.10.1 17:00</option>
	      <option value="2">2020.10.2 17:00</option>
	      <option value="3">2020.10.30 17:00</option>
	    </select>
	</div>
	<div id="test" class="seatCharts-container" tabindex="0">
		  <div class="front-indicator">1F</div>
		  <% int count=1;
		  for(int i=1;i<11;i++){ %>
		<div class="seatCharts-row">
			<div class="seatCharts-cell seatCharts-space"><%= i %></div>
			<%for(int j=1;j<31;j++){ %>
			<div id="1_<%=i %>_<%=j %>" role="checkbox" aria-checked="false" focusable="true" tabindex="-1" 
				class="seatCharts-seat seatCharts-cell first-class available" onclick="alert(this.id);"
				style="<% if(i<6 && (j>5 && j<25)){ %>
						background-color:#BEA886;
					<%}else if((i<6 && (j<=5 || j>=25))|| (i>=6 && i<8) ){%>
						background-color:#9076FF;
					<%}else{%>
						background-color:#70D0EA;
					<%}%>
				"></div>
			<%} %>
		</div>
		<%
		}
			%>
		
	</div>
	
	<div id="test" class="seatCharts-container" tabindex="0">
		  <div class="front-indicator">2F</div>
		  <% 
		  for(int i=1;i<11;i++){ %>
		<div class="seatCharts-row">
			<div class="seatCharts-cell seatCharts-space"><%= i %></div>
			<%for(int j=1;j<31;j++){ %>
			<div id="1_<%=i %>_<%=j %>" role="checkbox" aria-checked="false" focusable="true" tabindex="-1" 
				class="seatCharts-seat seatCharts-cell first-class available" onclick="alert(this.id);"
				style="<% if(i<6){ %>
						background-color:#70D0EA;
					<%}else{%>
						background-color:#AADE48;
					<%}%>
				"></div>
			<%} %>
		</div>
		<%
		}
			%>
		
	</div>
	<script>
		
	</script>
	

</body>
</html>