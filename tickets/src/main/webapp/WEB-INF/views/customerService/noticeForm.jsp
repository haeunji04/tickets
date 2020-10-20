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
div#notice-container{width:400px; margin:0 auto; text-align:center;}
div#notice-container input{margin-bottom:15px;}
/* 부트스트랩 : 파일라벨명 정렬*/
div#notice-container label.custom-file-label{text-align:left;}
#save-btn{color: #eb6864; border-color: #eb6864;}
</style>
<script>
/* textarea에도 required속성을 적용가능하지만, 공백이 입력된 경우 대비 유효성검사를 실시함. */
function noticeValidate(){
	var $content = $("[name=content]");
	if(/^(.|\n)+$/.test($content.val()) == false){
		alert("내용을 입력하세요");
		return false;
	}
	return true;
}
</script>

<div id="notice-container">
	<form name="noticeFrm" 
		  action="${pageContext.request.contextPath}/customerService/noticeEnroll.do" 
		  method="post" 
		  onsubmit="return noticeValidate();"
		  enctype="multipart/form-data">
		<input type="text" class="form-control" placeholder="제목" name="title" id="title" required>
		
		<select name="notice-kind">
		<option selected> 서비스 소식 </option>
		<option> 서비스 오픈 </option>
		<option> 서비스 종료 </option>
		<option> 서비스 점검 </option>
		<option> 안내 </option>
		</select>
		
		<div class="dropdown-menu">
		  <h6 class="dropdown-header">Dropdown header</h6>
		  <a class="dropdown-item" href="#">Action</a>
		  <a class="dropdown-item" href="#">Another action</a>
		</div>
		
	    <textarea class="form-control" name="notice-content" placeholder="내용" required></textarea>
		<br/>
		<input type="submit" class="btn btn-outline-success" id="save-btn" value="저장" >
	</form>
	
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
