<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"  %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 한글 인코딩 처리  -->
<fmt:requestEncoding value="utf-8"/>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle"/>
</jsp:include>


<div id="category-container" class="mx-auto pb-5">

	<div id="category-header" class="my-4 text-center" >
		<h2 class="text-primary my-4"> 내가 찜한 공연</h2>		
	
	<div id="category-header" class="my-4 text-center" >		
	
	<div id="category-body" class="my-3 text-center">
		<!-- 공연 반복문 블록 시작 (해당 카테고리 공연 수만큼 반복 돌리기) -->
		<c:if test="${ not empty list }">
		<c:forEach items="${ list }" var="wish">
		<div style="width: 213px" class="text-center d-inline-block p-3">
			<a href="${pageContext.request.contextPath }/performance/performanceInfoView2.do?perNo=${ wish.perNo }">
						<%-- <c:if test="${not empty loginMember }">&memberId=${loginMember.memberId}</c:if>"> --%>	
										
						<%-- <sec:authorize access="isAuthenticated()">&memberId=<sec:authentication property="principal.userName"/></sec:authorize>"> --%>
						<img
						src="<c:url value='/resources/upload/performance/${ wish.perImgRenamedFileName}' />"
						style="width: 200px" />
					</a>
			<h6>${ wish.perTitle }</h6>
			<p style="font-size:13px;" class="mb-0">${ dateformat.format(wish.perStartDate) }-${ dateformat.format(wish.perEndDate) }</p>
		</div>
		</c:forEach>
		</c:if>
		
		<c:if test="${ empty list }">
			<div>찜한 공연이 존재하지 않습니다.</div>
		</c:if>
		<!-- 뮤지컬 반복문 블록 끝 -->
	
	</div>
	
	<!-- 구분선 -->
	<div class="d-block dropdown-divider"></div>
	<br />
	
	<h4 class="text-primary my-4"> 추천 공연</h4>
	<div class="my-3 text-center">
		<c:if test="${ not empty recommendedList }">
		<c:forEach items="${ recommendedList }" var="recom" begin="0" end= "3" step="1" varStatus="status">
		<div style="width: 213px" class="text-center d-inline-block p-3">
			<a href="${pageContext.request.contextPath }/performance/performanceInfoView2.do?perNo=${ recom.perNo }">
						<%-- <c:if test="${not empty loginMember }">&memberId=${loginMember.memberId}</c:if>"> --%>	
										
						<%-- <sec:authorize access="isAuthenticated()">&memberId=<sec:authentication property="principal.userName"/></sec:authorize>"> --%>
						<img
						src="<c:url value='/resources/upload/performance/${ recom.perImgRenamedFileName}' />"
						style="width: 200px" />
					</a>
			<h6>${ recom.perTitle }</h6>
			<p style="font-size:13px;" class="mb-0">${ dateformat.format(recom.perStartDate) }-${ dateformat.format(recom.perEndDate) }</p>
		</div>
		</c:forEach>
		</c:if>
		
		<c:if test="${ empty recommendedList }">
			<div>추천 공연이 존재하지 않습니다.</div>
		</c:if>
	
	
			<%-- <a href="">
				<img src="${pageContext.request.contextPath }/resources/images/poster/어쩌면해피엔딩.jpg" 
					 alt="포스터" height="300px" class="mb-2"/>
			</a>
			<div style="height: 250px">
				<h5>어쩌면 해피엔딩</h5>
				<p>우리가 어쩌면, <br /> 해피엔딩</p>
			</div>
		</div>
		
		<div style="width: 220px; height:400px;" class="text-center d-inline-block m-3">
			<a href="">
				<img src="${pageContext.request.contextPath }/resources/images/poster/소믈리에.jpg" 
					 alt="포스터" height="300px" class="mb-2"/>
			</a>
			<h5>뮤지컬 소믈리에</h5>
			<p>당신이 절대 후회하지 않을 공연!</p>
		</div>
		
		<div style="width: 220px; height:400px;" class="text-center d-inline-block m-3">
			<a href="">
				<img src="${pageContext.request.contextPath }/resources/images/poster/무인도탈출기.jpg" 
					 alt="포스터" height="300px" class="mb-2"/>
			</a>
			<h5>뮤지컬 [무인도 탈출기]</h5>
			<p>청춘을 대변하는 우리들의 '극중극'</p>
		</div> --%>
	</div>



</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
   
