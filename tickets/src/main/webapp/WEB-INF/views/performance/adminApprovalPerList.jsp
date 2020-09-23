<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!-- 한글 인코딩 처리  -->
<fmt:requestEncoding value="utf-8"/>



<jsp:include page="/WEB-INF/views/common/header.jsp" />

<br />
<h3>공연등록 신청 후 관리자가 승인하는 페이지</h3>
<br />
<br />

<table class="table table-hover">
  <thead>
  	<tr class="table-primary">
      <th>공연이미지</th>
      <th>공연제목</th>
      <th>공연감독</th>
      <th>공연배우</th>
      <th>공연주소</th>
      <th>등록 신청날짜</th>
      <th>등록 승인여부</th>
  </thead>
  <tbody>   
  	
    <c:forEach items="${ list }" var="per">
	<tr>		
		<td>
			<img src="<c:url value='/resources/upload/performance/${ per.perImgRenamedFileName}' />" 
				 style="width: 100px" />	
		</td>	
		<td>${ per.perTitle }</td>
		<td>${ per.perDirector }</td>
		<td>${ per.perActor }</td>
		<td>${ per.theaterNo }</td>
		<td>${ per.perRegisterDate }</td>		
		<td>			
			<button type="button" 
					class="btn btn-outline-primary"
					onclick="approvePerRegister('${ per.perNo }')">승인</button>
		</td>
		<%-- <td>
			<img src="<c:url value='/resources/upload/performance/${ per.detailImgRenamedFileName}' />" 
				 style="width: 100px" />	
		</td>	 --%>
							
	</tr>
	</c:forEach>    
  </tbody>
</table>
<div class="text-center">
	<c:if test="${ empty list }"> 
		<p> 승인 대기중인 공연이 없습니다.</p>
	</c:if>
</div>


<form action="${ pageContext.request.contextPath }/performance/approvePerRegister.do" 
	  id="approvePerRegisterFrm" 
	  method="POST">
	<input type="hidden" name="perNo" />
</form>

<script>
/**
 * POST 요청 처리할 것
 **/
function approvePerRegister(perNo){
	if(confirm("정말 승인하시겠습니까?") == false)
		return;
	var $frm = $("#approvePerRegisterFrm");
	$frm.find("[name=perNo]").val(perNo);
	$frm.submit();
	
}

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>