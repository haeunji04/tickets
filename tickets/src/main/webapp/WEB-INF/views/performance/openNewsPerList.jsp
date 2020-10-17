<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!-- 한글 인코딩 처리  -->
<fmt:requestEncoding value="utf-8"/>



<jsp:include page="/WEB-INF/views/common/header.jsp" />

<br />
<h3>- 티켓 오픈 소식 -</h3>
<!-- <h3 class="text-primary my-4">- 티켓 오픈 소식 -</h3> -->

	<ul class="list-group list-group-flush">
		<c:forEach items="${ list }" var="per" >
		<li class="list-group-item" style="text-align:left;">
			<a href="${pageContext.request.contextPath }/performance/performanceInfoView2.do?perNo=${ per.perNo}" class="inner inner_ico text-decoration-none">
				<c:if test="${ per.aloneSale eq 'Y' }">
				<span class="badge badge-primary" style="float:left;"><span class="ico1">단독판매</span></span> 
				</c:if>
				<br />
				<span>
					${ per.perTitle} 티켓 오픈 안내
					<br />
					<small class="text-muted">[오픈]${ dateformat.format(per.perStartDate) }</small>
				</span>
			</a>
		</li>
		</c:forEach>	
	</ul>

<div class="align-center">
    	<ul class="pagination justify-content-center">
	    
		            ${ pageBar }     

    	</ul>
</div>	

<div class="text-center">
	<c:if test="${ empty rList }"> 
		<p>최근 본 공연이 없습니다.</p>
	</c:if>
</div>

<script>

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>