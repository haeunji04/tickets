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

<style>
th, td{
  border-collapse: separate;
  border-spacing: 0 10px;
}
</style>

<div id="search-result-container" class="mx-auto pb-5" style="width: 85%">


	<div id="search-result-header" class="my-4 text-center" >
	
		<div style="padding:80px; margin-bottom:20px; background-color:#F4F4F4;">
		  <div class="container align-middle" style="font-size:30px;">
		    <span style="font-size:30px;" class="text-primary font-weight-bold">' ${keyword} ' </span>
		    에 대한 검색 결과입니다.
		  </div>
		</div>
	
		<!-- 검색 결과 여러 항목으로 나눠서 볼 거 아니면 탭형식 필요없어짐! 기능 구현하면서 고민해볼 것  -->
		<ul class="nav nav-tabs mb-5 mx-auto">
			<li class="nav-item">
				<a class="nav-link active" data-toggle="tab" href="#all">통합검색</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" data-toggle="tab" href="#performance-name">공연 검색</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" data-toggle="tab" href="#performance-hall">공연장 검색</a>
			</li>
		</ul>

		<div id="myTabContent" class="tab-content mx-5">
		
			<!-- 통합검색탭 내용 -->
			<div class="tab-pane fade active show" id="all">

				<table class="table table-hover">
				<h4 class="text-left">공연</h4>
				<!-- 반복될 블록(존재하는 만큼 반복) 시작 -->
				<c:if test="${ not empty perList }">
				<c:forEach items="${ perList }" var="per">
					<tr>
						<th>
						<a href="${pageContext.request.contextPath }/performance/performanceInfoView2.do?perNo=${ per.perNo }">
							<img src="${ pageContext.request.contextPath }/resources/upload/performance/${ per.perImgRenamedFileName }" alt="포스터"
								 width="150px;" class="img-thumbnail" />
						</a>
						</th>
						<td class="align-middle"><h6>${ per.perTitle }</h6></td>
						<td class="align-middle">${ per.perStartDate } <br /> - ${ per.perEndDate }</td>
						<td class="align-middle">${ per.theaterName }</td>
					</tr>
				</c:forEach>
				</c:if>
				<c:if test="${ empty perList }">
				<tr>
					<td>검색된 공연이 존재하지 않습니다.</td>
				</tr>
				</c:if>
				<!-- 반복문 블록 끝 -->
				</table>
				
				<br />
				<br />
				<br />
				
				<table class="table table-hover">
				<h4 class="text-left">공연장</h4>
				<!-- 반복문 블록 시작 -->
				<c:if test="${ not empty hallList }">
				<c:forEach items="${ hallList }" var="hall">
					<tr class="my-3 align-middle">
						<td class="align-middle"><strong>${ hall.theaterName }</strong></td>
						<td colspan="3" class="align-middle">${ hall.theaterLocation }&nbsp;${ hall.theaterCity }&nbsp;${ hall.theaterAddress }</td>
					</tr>
				</c:forEach>
				</c:if>
				<c:if test="${ empty hallList }">
				<tr>
					<td>검색된 공연장이 존재하지 않습니다.</td>
				</tr>
				</c:if>
				<!-- 반복문 블록 끝 -->
	
				
				</table>
				
			</div>
			<!-- 공연탭 내용 -->
			<div class="tab-pane fade" id="performance-name">

				<table class="table table-hover">
				<!-- 반복될 블록(존재하는 만큼 반복) 시작 -->
				<c:if test="${ not empty perList }">
				<h4 class="text-left">공연</h4>
				<c:forEach items="${ perList }" var="per">
					<tr>
						<th>
							<a href="${pageContext.request.contextPath }/performance/performanceInfoView2.do?perNo=${ per.perNo }">
								<img src="${ pageContext.request.contextPath }/resources/upload/performance/${ per.perImgRenamedFileName }" alt="포스터"
									 width="150px;" class="img-thumbnail" />
							</a>
						</th>
						<td class="align-middle"><h6>${ per.perTitle }</h6></td>
						<td class="align-middle">${ per.perStartDate } <br /> - ${ per.perEndDate }</td>
						<td class="align-middle">${ per.theaterName }</td>
					</tr>
				</c:forEach>
				</c:if>
				<c:if test="${ empty perList }">
				<tr>
					<td>검색된 공연이 존재하지 않습니다.</td>
				</tr>
				</c:if>
				<!-- 반복문 블록 끝 -->
				</table>

			</div>
			
			<!-- 공연장탭 내용 -->
			<div class="tab-pane fade" id="performance-hall">

				<table class="table table-hover">
				
				<c:if test="${ not empty hallList }">
				<h4 class="text-left">공연장</h4>
				<c:forEach items="${ hallList }" var="hall">
					<tr>
						<td class="align-middle"><h6>${ hall.theaterName }</h6></td>
						<td colspan="3" class="align-middle">${ hall.theaterLocation }&nbsp;${ hall.theaterCity }&nbsp;${ hall.theaterAddress }</td>
					</tr>
				</c:forEach>
				</c:if>
				<c:if test="${ empty hallList }">
				<tr>
					<td>검색된 공연장이 존재하지 않습니다.</td>
				</tr>
				</c:if>

				</table>

			</div>
		</div>
	
	</div>

</div>

<script>
<c:if test="${ not empty keyword }">
	$("#keyword").val('${ keyword }');
</c:if>
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
   
