<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"  %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<!-- 한글 인코딩 처리  -->
<fmt:requestEncoding value="utf-8"/>



<jsp:include page="/WEB-INF/views/common/header.jsp" />



<br />
<h3 class="text-primary my-4">오늘 티켓 공연(마감일 50% 할인)</h3>
<br />
<br />

<table class="table table-hover">
  <thead>
  	<tr class="table-primary">
      <th>공연이미지</th>
      <!-- <th>아이디(확인용)</th> -->
      <th>공연제목</th>
      <th>공연기간</th> 
      <th>관람등급</th>
      <th>관람시간</th>
      <!-- <th>마지막날 할인</th> -->
  </thead>
  <tbody>   
    <c:forEach items="${ list }" var="per"  >
	<jsp:useBean id="now" class="java.util.Date" />
	<fmt:formatDate value="${ now }" pattern="yyyyMMdd" var="nowDate" />               <%-- 오늘날짜 --%>
	<fmt:formatDate value="${ per.perEndDate }" pattern="yyyyMMdd" var="endDate"/>     <%-- 시작날짜 --%>
    <c:if test="${endDate == nowDate }">    
   
	<tr>		
		<td>
		<!-- 상세페이지에서 memberId불러올떄 -->
			<a href="${pageContext.request.contextPath }/performance/performanceInfoView2.do?perNo=${ per.perNo }">					
						<img
						src="<c:url value='/resources/upload/performance/${ per.perImgRenamedFileName}' />"
						style="width: 100px" />
			</a>	
		</td>
		<%-- ${fn:length(list)} --%>
		<%-- <td>${ per.memberId } </td> --%>
		<td>${ per.perTitle }</td>
		<td>${ dateformat.format(per.perStartDate) } <br />
		  - ${ dateformat.format(per.perEndDate) }
		</td> 
		<td>${ per.perRating == 0 ? '전체관람가' : 
			   per.perRating == 8 ? '8세이상 관람가':
			   per.perRating == 15 ? '15세이상관람가': '18세이상관람가' }				
		</td>
		<td>${ per.perTime }분</td>
		<!-- <td>50%</td> -->							
	</tr>
	
    </c:if>
	</c:forEach>    
  </tbody>
</table>

<div class="text-center">
	<c:if test="${ empty list }"> 
		<p>오늘의 공연이 없습니다.</p>
	</c:if>
</div>

<script>

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>