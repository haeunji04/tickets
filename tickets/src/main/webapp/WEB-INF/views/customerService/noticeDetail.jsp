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
div#notice-container{width:90%; margin:0 auto; text-align:center;}
#notice-content{background-color: white; height: 350px;}
</style>
	<div id="notice-container">
		<table id="tbl-board" class="table" style="width:90%; margin: auto">
			<tr>
				<td>${ notice.noticeNo } </td>
				<td>${ notice.noticeTitle }</td>
				<td><fmt:formatDate value="${ notice.noticeRegDate }" type="date"/></td>
			</tr>
			<tr>
				<td colspan="3">
					<textarea class="form-control" name="notice-content"  id="notice-content"
	    		  			  placeholder="내용" readonly required>${ notice.noticeContent }</textarea>
	    		</td>
			</tr>
		</table>
	</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
