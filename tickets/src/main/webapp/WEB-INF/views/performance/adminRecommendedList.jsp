<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!-- 한글 인코딩 처리  -->
<fmt:requestEncoding value="utf-8"/>



<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div id="addRecommenedPerList">
	<br />
	<h3 class="text-success my-4">추천 공연 목록</h3>
	
	<table class="table table-hover">
	  <thead>
	  	<tr class="table-success">
	      <th>공연이미지</th>
	      <th>아이디(판매자)</th>
	      <th>공연제목</th>
	      <th>공연기간</th> 
	      <th>관람등급</th>
	      <th>관람시간</th>
	      <th>추천 여부</th>
	      <th>추천 해제</th>
	  </thead>
	  <tbody>   

	    <c:if test="${ per.perDisplay eq 'Y' }">  
	    <c:forEach items="${ recommendedList }" var="per">
		<tr>		
			<td>
				<a href="${pageContext.request.contextPath }/performance/performanceInfoView2.do?perNo=${ per.perNo }">					
							<img
							src="<c:url value='/resources/upload/performance/${ per.perImgRenamedFileName}' />"
							style="width: 100px" />
				</a>	
			</td>
			<td>${ per.memberId }</td>
			<td>${ per.perTitle }</td>
			<td>${ dateformat.format(per.perStartDate) } <br />
			  - ${ dateformat.format(per.perEndDate) }
			</td> 
			<td>${ per.perRating == 0 ? '전체관람가' : 
				   per.perRating == 8 ? '8세이상 관람가':
				   per.perRating == 15 ? '15세이상관람가': '18세이상관람가' }				
			</td>
			<td>${ per.perTime }분</td>
			<td>${ per.perDisplay eq 'Y' ? 'ON' : 'OFF'}</td>
			<td>			
				<button type="button" 
						class="btn btn-outline-primary"
						onclick="turnOffRecommendedPer('${ per.perNo }')">OFF</button>
			</td>							
		</tr> 	
		</c:forEach>    
	    </c:if>
	  </tbody>
	 
	</table>
	
	<div class="text-center">
		<c:if test="${recommendedCnt eq 0}">
			<p>현재 추천목록에 추가된 공연이 없습니다</p>
		</c:if>  
	</div>
</div>

<br />

<div id="nonRecommenedPerList">
	<h3 class="text-primary my-2">공연 목록</h3>
	<br />
	
	<div class="text-center align-middle">
		<!-- 검색 -->
		<form action="${pageContext.request.contextPath }/performance/adminSearchList" method="get" class="mb-3">
			<select name="searchType" style="width:130px;" class="form-control d-inline-block">
				<option value="companyId" ${ "companyId" eq searchType ? "selected" : "" }>판매자</option>
				<option value="perTitle" ${ "perTitle" eq searchType ? "selected" : "" }>공연제목</option>
			</select>
			<input type="text" class="form-control d-inline-block" name="keyword" id="keyword" 
				   value="${ keyword != null ? keyword : '' }" style="width:200px;"/>
			<input type="submit" class="mb-1 btn btn-outline-primary d-inline-block align-middle" value="검색" />
		</form>
	</div>
	
	
	<table class="table table-hover">
	  <thead>
	  	<tr class="table-primary">
	      <th>공연이미지</th>
	      <th>아이디(판매자)</th>
	      <th>공연제목</th>
	      <th>공연기간</th> 
	      <th>관람등급</th>
	      <th>관람시간</th>
	      <th>추천 여부</th>
	      <th>추천 추가</th>
	  </thead>
	  <tbody>   
	    <c:forEach items="${ list }" var="per">  
	    <c:if test="${ per.perDisplay eq 'N' }">  
		<tr>		
			<td>
				<a href="${pageContext.request.contextPath }/performance/performanceInfoView2.do?perNo=${ per.perNo }">					
							<img
							src="<c:url value='/resources/upload/performance/${ per.perImgRenamedFileName}' />"
							style="width: 100px" />
				</a>	
			</td>
			<td>${ per.memberId }</td>
			<td>${ per.perTitle }</td>
			<td>${ dateformat.format(per.perStartDate) } <br />
			  - ${ dateformat.format(per.perEndDate) }
			</td> 
			<td>${ per.perRating == 0 ? '전체관람가' : 
				   per.perRating == 8 ? '8세이상 관람가':
				   per.perRating == 15 ? '15세이상관람가': '18세이상관람가' }				
			</td>
			<td>${ per.perTime }분</td>
			<td>${ per.perDisplay eq 'Y' ? 'ON' : 'OFF'}</td>
			<td>			
				<button type="button" 
						class="btn btn-outline-success"
						onclick="addRecommendedPer('${ per.perNo }')">ON</button>
			</td>
								
		</tr> 
		
		</c:if>		
		</c:forEach>    
	  </tbody>
	</table>	
	
<%-- 	<div class="text-center">
		<c:if test="${recommendedCnt ne 0}">
			<p>현재 등록된 공연이 없습니다.</p>
		</c:if>  
	</div> --%>
	
	<div class="align-center">
    	<ul class="pagination justify-content-center">
	    
		            ${ pageBar }     

    	</ul>
	</div>
	
	
</div>

<%-- <div class="text-center">
	<c:if test="${ empty list }"> 
		<p>현재 등록된 공연이 없습니다.</p>
	</c:if>
</div> --%>

<form action="${ pageContext.request.contextPath }/performance/addRecommendedPer.do" 
	  id="addRecommendedPerFrm" 
	  method="POST">
	<input type="hidden" name="perNo" />
</form>
<form action="${ pageContext.request.contextPath }/performance/turnOffRecommendedPer.do" 
	  id="turnOffRecommendedPerFrm" 
	  method="POST">
	<input type="hidden" name="perNo" />
</form>

<script>
/**
 * POST 요청 처리할 것
 **/
function addRecommendedPer(perNo){
	if(confirm("정말 추천목록에 추가하시겠습니까?") == false)
		return;
	var $frm = $("#addRecommendedPerFrm");
	$frm.find("[name=perNo]").val(perNo);
	$frm.submit();
	
}

function turnOffRecommendedPer(perNo){
	if(confirm("정말 추천목록에서 해제하시겠습니까?") == false)
		return;
	var $frm = $("#turnOffRecommendedPerFrm");
	$frm.find("[name=perNo]").val(perNo);
	$frm.submit();
	
}

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>