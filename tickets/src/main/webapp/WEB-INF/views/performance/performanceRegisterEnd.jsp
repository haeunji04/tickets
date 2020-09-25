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
<div class="mx-auto align-middle my-5" style="width:50%;">
<div class="text-left d-inline">
	<div class="d-inline">
		<div class="date_choice text-center d-inline align-middle" >
			<div class="text-center">
			<h2 class="mx-auto mt-3 text-center">공연등록이 완료되었습니다.</h2>
			<br /><br />
				<div class="progress mx-auto" style="width:80%;">
				  	<div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100" style="width: 100%"></div>
				</div>
		    <br /><br />
		    <input type="button" class="btn btn-primary" value="공연목록 보기" onclick="location.href='${pageContext.request.contextPath }/performance/performanceList.do'"/>
		    </div>
		</div>
	</div>
</div>
</div>
		    
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
   
