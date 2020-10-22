<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"  %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%-- 한글인코딩 처리 --%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle"/>
</jsp:include>
<style>
div#notice-container{width: 60%; margin:0 auto; text-align:center;}
div#notice-container input{margin-bottom:15px;}
/* 부트스트랩 : 파일라벨명 정렬*/
div#notice-container label.custom-file-label{text-align:left;}
textarea.form-control{height: 250px;}
#notice-kind{width: 150px; float: left; margin-bottom: 10px;}
</style>

<div id="notice-container">
	<form:form name="noticeFrm" 
		  action="${pageContext.request.contextPath}/customerService/noticeEnroll.do" 
		  method="post">
		<select class="form-control" name="noticeKind" id="notice-kind">
			<option selected> 서비스 소식 </option>
			<option> 서비스 오픈 </option>
			<option> 서비스 종료 </option>
			<option> 서비스 점검 </option>
			<option> 안내 </option>
		</select>
		<input type="text" class="form-control" placeholder="제목" name="noticeTitle" id="notice-title" required>
	    <textarea class="form-control" name="noticeContent" id="noticeContent" placeholder="내용" required></textarea>
		<br/>
		<input type="submit" class="btn btn-outline-primary" id="save-btn" value="저장" >
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	</form:form>
	
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
