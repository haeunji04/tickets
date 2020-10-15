<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!-- 한글 인코딩 처리  -->
<fmt:requestEncoding value="utf-8"/>



<jsp:include page="/WEB-INF/views/common/header.jsp" />

<br />
<h3 class="text-primary my-4">내가 최근 본 공연</h3>
<br />
<br />

<table class="table table-hover">
  <thead>
  	<tr class="table-primary">
      <th>공연이미지</th>
      <th>아이디(확인용)</th>
      <th>공연제목</th>
      <th>공연기간</th> 
      <th>관람등급</th>
      <th>관람시간</th>
      <th>최근 본 날짜</th>
  </thead>
  <tbody>   
    <%-- <c:forEach items="${ list }" var="recentPer" begin="0" end= "2" step="1" varStatus="status" > --%>
    <c:forEach items="${ rList }" var="recentPer"  >
   
	<tr>		
		<td>
		<!-- 상세페이지에서 memberId불러올떄 -->
			<a href="${pageContext.request.contextPath }/performance/performanceInfoView2.do?perNo=${ recentPer.perNo }">					
						<img
						src="<c:url value='/resources/upload/performance/${ recentPer.perImgRenamedFileName}' />"
						style="width: 100px" />
			</a>	
		</td>
		<%-- ${fn:length(list)} --%>
		<td>${ recentPer.memberId } </td>
		<td>${ recentPer.perTitle }</td>
		<td>${ dateformat.format(recentPer.perStartDate) } <br />
		  - ${ dateformat.format(recentPer.perEndDate) }
		</td> 
		<td>${ recentPer.perRating == 0 ? '전체관람가' : 
			   recentPer.perRating == 8 ? '8세이상 관람가':
			   recentPer.perRating == 15 ? '15세이상관람가': '18세이상관람가' }				
		</td>
		<td>${ recentPer.perTime }분</td>
		<td>${ recentPer.recentlyDate }</td>
							
	</tr>
	</c:forEach>    
  </tbody>
</table>

<div class="text-center">
	<c:if test="${ empty rList }"> 
		<p>최근 본 공연이 없습니다.</p>
	</c:if>
</div>

<script>

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>