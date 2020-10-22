<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"  %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- 한글인코딩 처리 --%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle"/>
</jsp:include>
<style>
div#notice-container{width:90%; margin:0 auto; text-align:center;}
/* #notice-content{background-color: white; height: 350px;} */
</style>
	<div id="notice-container">
	<h4 class="my-4">공지사항</h4>
		<table id="tbl-board" class="table" style="width:80%; margin: 0 auto">
			<tr>
				<th>${ notice.noticeNo } </th>
				<th>제목</th>
				<td colspan="2" style="width:280px;" align="left">${ notice.noticeTitle }</td>
				<th style="width:100px;">게시일</th>
				<td style="width:140px;"><fmt:formatDate value="${ notice.noticeRegDate }" type="date"/></td>
			</tr>
			<tr>
				<td colspan="7">
					<pre class="border p-4 text-left">${ notice.noticeContent }</pre>
	    		</td>
			</tr>
		</table>
		<div class="mb-3">
			<form:form action="${ pageContext.request.contextPath }/customerService/deleteNotice.do" method="POST">
				<input type="hidden" name="noticeNo" value=${ notice.noticeNo } />
				<input type="button" class="btn btn-primary" value="목록" onclick="javascript:history.back();"/>
				<input type="submit" value="삭제" class="btn btn-outline-primary"/>
			</form:form>
		</div>
	</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
