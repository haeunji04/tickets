<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- 한글 인코딩 처리  -->
<fmt:requestEncoding value="utf-8"/>



<jsp:include page="/WEB-INF/views/common/header.jsp" />


<div class="text-center">
	<h3 class="my-4">회원조회</h3>
	
			<!-- 검색 -->
		<form:form action="${pageContext.request.contextPath }/member/adminMemberSearchList" method="get" class="mb-3">
			<select name="searchType" style="width:130px;" class="form-control d-inline-block">
				<option value="memberId" ${ "memberId" eq searchType ? "selected" : "" }>아이디</option>
				<option value="memberName" ${ "memberName" eq searchType ? "selected" : "" }>이름</option>
			</select>
			<input type="text" class="form-control d-inline-block" name="keyword" id="keyword" 
				   value="${ keyword != null ? keyword : '' }" style="width:200px;"/>
			<input type="submit" class="mb-1 btn btn-outline-primary d-inline-block align-middle" value="검색" />
		</form:form>
	
	<p>* 총 <span class="text-primary"> ${ totalContents }</span> 명의 회원이 있습니다. *</p>
	<table class="table table-hover">
	  <thead>
	  	<tr class="table-primary">
	      <th>아이디</th>
	      <th>이름</th>
	      <th>이메일</th>
	      <th>번호</th>
	      <th>주소</th> 
	      <th>회원구분</th>
	      <th>가입날짜</th>
	      <th>회원삭제</th>
	  </thead>
	  <tbody>   
	    <c:forEach items="${ list }" var="member">
		<tr>
			<td>${ member.memberId }</td>
			<td>${ member.name }</td>
			<td>${ member.email }</td>
			<td>${ member.phone }</td>
			<td>${ member.addr } ${ member.addrDetail }</td>
			<td>${ member.memberRole eq 'U' ? '일반회원' : (member.memberRole eq 'C' ? '공연판매자' : '관리자') }</td>
			<td>${ member.enrollDate }</td>		
			<td>			
				<button type="button" 
						class="btn btn-outline-primary"
						onclick="deleteMember('${ member.memberId }')">삭제</button>
			</td>
		</tr>
		</c:forEach>    
	  </tbody>
	</table>
	
	<div class="align-center">
    	<ul class="pagination justify-content-center">
	    
		            ${ pageBar }     

    	</ul>
	</div>	
</div>


<form:form action="${ pageContext.request.contextPath }/member/deleteMember.do" 
	  id="memberDeleteFrm" 
	  method="POST">
	<input type="hidden" name="memberId" />
</form:form>

<script>
/**
 * POST 요청 처리할 것
 **/
function deleteMember(memberId){
	if(confirm("정말 삭제하시겠습니까?") == false)
		return;
	var $frm = $("#memberDeleteFrm");
	$frm.find("[name=memberId]").val(memberId);
	$frm.submit();
	
}

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>