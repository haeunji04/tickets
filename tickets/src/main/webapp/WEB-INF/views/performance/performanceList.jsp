<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!-- 한글 인코딩 처리  -->
<fmt:requestEncoding value="utf-8"/>



<jsp:include page="/WEB-INF/views/common/header.jsp" />

<br />
<h2>공연등록 후 조회 테스트 페이지</h2>
<br />
<br />

<table class="table table-hover">
  <thead>
  	<tr class="table-primary">
      <th>공연이미지</th>
      <th>판매자아이디</th>
      <th>공연제목</th>
      <th>공연감독</th>
      <th>공연배우</th>
      <th>공연주소</th>
      <th>공연등록날짜</th>
      <th>관리자 승인상태</th>
      <th>작품설명이미지</th>
  </thead>
  <tbody>   
    <c:forEach items="${ list }" var="per">
	<tr>		
		<td>
			<img src="<c:url value='/resources/upload/performance/${ per.perImgRenamedFileName}' />" 
				 style="width: 100px" />	
		</td>	
		<td>${ per.memberId }</td>
		<td>${ per.perTitle }</td>
		<td>${ per.perDirector }</td>
		<td>${ per.perActor }</td>
		<td>${ per.theaterNo }</td>
		<td>${ per.perRegisterDate }</td>
		<%-- <td>${ per.adminApproval }</td> --%>
		<td>${ per.adminApproval eq 'Y' ? '승인' : '미승인'}</td>
		<td>
			<img src="<c:url value='/resources/upload/performance/${ per.detailImgRenamedFileName}' />" 
				 style="width: 100px" />	
		</td>	
							
	</tr>
	</c:forEach>    
  </tbody>
</table>

<div class="text-center">
	<c:if test="${ empty list }"> 
		<p>등록신청 및 승인이 완료된 공연이 없습니다.</p>
	</c:if>
</div>

<script>

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>