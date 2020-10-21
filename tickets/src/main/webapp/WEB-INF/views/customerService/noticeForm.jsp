<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
#save-btn{color: #eb6864; border-color: #eb6864;}
textarea.form-control{height: 250px;}
#notice-kind{width: 150px; float: left; margin-bottom: 10px;}
</style>

<div id="notice-container">
	<form name="noticeFrm" 
		  action="${pageContext.request.contextPath}/customerService/noticeEnroll.do" 
		  method="post">
		<select class="form-control" name="notice-kind" id="notice-kind">
			<option selected> 서비스 소식 </option>
			<option> 서비스 오픈 </option>
			<option> 서비스 종료 </option>
			<option> 서비스 점검 </option>
			<option> 안내 </option>
		</select>
		<input type="text" class="form-control" placeholder="제목" name="notice-title" id="notice-title" required>
	    <textarea class="form-control" name="notice-content" id="notice-content" placeholder="내용" required></textarea>
		<br/>
		<input type="submit" class="btn btn-outline-success" id="save-btn" value="저장" >
	</form>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
