<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- 한글 인코딩 처리  -->
<fmt:requestEncoding value="utf-8"/>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle"/>
</jsp:include>
	<link type="text/css" href="${pageContext.request.contextPath }/resources/css/styles.css" rel="stylesheet" />
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/waltzerjs.min.js"></script>

<div id="category-container" class="mx-auto pb-5">

	<div id="category-header" class="my-4 text-center" >
		<h2 class="text-primary my-4"> ${ categoryName }</h2>	
			
		<!-- 추천 뮤지컬 반복문 블록 시작(4번 돌리기) -->
	<div id="carousel" class='outerWrapper'>
		<div style="width: 220px; height:400px;" class="item text-center d-inline-block m-3">
			<a href="" class="none">
				<img src="${pageContext.request.contextPath }/resources/images/poster/캣츠.jpg" 
					 alt="포스터" height="300px" class="mb-2"/>
			</a>
				<h5>뮤지컬 〈캣츠〉 40주년 오리지널 내한공연</h5>
				<small>기념비적인 40주년 내한 공연!</small>
		</div>
		<!-- 추천 뮤지컬 반복문 블록 끝 -->
		
		<div style="width: 220px; height:400px;" class="item text-center d-inline-block m-3 pt-0">
			<a href="">
				<img src="${pageContext.request.contextPath }/resources/images/poster/어쩌면해피엔딩.jpg" 
					 alt="포스터" height="300px" class="mb-2"/>
			</a>
				<h5>어쩌면 해피엔딩</h5>
				<small>우리가 어쩌면, <br /> 해피엔딩</small>
		</div>
		
		<div style="width: 220px; height:400px;" class="item text-center d-inline-block m-3">
			<a href="">
				<img src="${pageContext.request.contextPath }/resources/images/poster/소믈리에.jpg" 
					 alt="포스터" height="300px" class="mb-2"/>
			</a>
			<h5>뮤지컬 소믈리에</h5>
			<small>당신이 절대 후회하지 않을 공연!</small>
		</div>
		
		<div style="width: 220px; height:400px;" class="item text-center d-inline-block m-3">
			<a href="">
				<img src="${pageContext.request.contextPath }/resources/images/poster/무인도탈출기.jpg" 
					 alt="포스터" height="300px" class="mb-2"/>
			</a>
			<h5>뮤지컬 [무인도 탈출기]</h5>
			<small>청춘을 대변하는 우리들의 '극중극'</small>
		</div>
		</div>
	</div>
	
	<!-- 구분선 -->
	<div class="d-block dropdown-divider"></div>
	<br />
	
	<div id="category-body" class="my-3 text-center">
		<!-- 공연 반복문 블록 시작 (해당 카테고리 공연 수만큼 반복 돌리기) -->
		<c:if test="${ not empty list }">
		<c:forEach items="${ list }" var="per">
		<div style="width: 213px" class="text-center d-inline-block p-3">
			<a href="${pageContext.request.contextPath }/performance/performanceInfoView2.do?perNo=${ per.perNo }">					
						<img
						src="<c:url value='/resources/upload/performance/${ per.perImgRenamedFileName}' />"
						style="width: 200px" />
					</a>
			<h6>${ per.perTitle }</h6>
			<p style="font-size:13px;" class="mb-0">${ per.perStartDate }-${ per.perEndDate }<br />${ per.theaterName }</p>
		</div>
		</c:forEach>
		</c:if>
		
		<c:if test="${ empty list }">
			<div>공연이 존재하지 않습니다.</div>
		</c:if>
		<!-- 뮤지컬 반복문 블록 끝 -->
	
	</div>



</div>
<script>
$('#carousel').waltzer({scroll:1});
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
   
