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
<h3 class="text-primary my-4">내가 기대평 남긴 공연</h3>
<br />
<br />

<table class="table table-hover">
  <thead>
  	<tr class="table-primary">
      <th>공연이미지</th>
     <!--  <th>작성자(확인용)</th> -->
      <th>공연제목</th>
      <th>공연기간</th> 
      <th>관람등급</th>
      <th>관람시간</th>
  </thead>
  <tbody>   
    
    <c:forEach items="${ cList }" var="commentPer"  >
   
	<tr>		
		<td>
		<!-- 상세페이지에서 memberId불러올떄 -->
			<a href="${pageContext.request.contextPath }/performance/performanceInfoView2.do?perNo=${ commentPer.perNo }">					
						<img
						src="<c:url value='/resources/upload/performance/${ commentPer.perImgRenamedFileName}' />"
						style="width: 100px" />
			</a>	
		</td>
		<%-- ${fn:length(list)} --%>
		<%-- <td>${ commentPer.memberId } </td> --%>
		<td>${ commentPer.perTitle }</td>
		<td>${ dateformat.format(commentPer.perStartDate) } - ${ dateformat.format(commentPer.perEndDate) }
		</td> 
		<td>${ commentPer.perRating == 0 ? '전체관람가' : 
			   commentPer.perRating == 8 ? '8세이상 관람가':
			   commentPer.perRating == 15 ? '15세이상관람가': '18세이상관람가' }				
		</td>
		<td>${ commentPer.perTime }분</td>
							
	</tr>
	
	<tr>
		<td></td>
		<td colspan=4>
			<c:forEach items="${ list }" var="comment"  >
			<c:if test="${ commentPer.perNo ==  comment.perNo}">
				<p class="text-secondary">${ comment.boardCommentWriter }: ${ comment.boardCommentContent } (${ comment.boardCommentDate })</p>				
			</c:if>
			</c:forEach>
		</td>
	</tr>
	
	</c:forEach>    
  </tbody>
</table>

<div class="text-center">
	<c:if test="${ empty cList }"> 
		<p>기대평을 작성한 공연이 없습니다.</p>
	</c:if>
</div>

<script>

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>