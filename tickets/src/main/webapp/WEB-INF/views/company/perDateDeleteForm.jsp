<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- 한글 인코딩 처리  -->
<fmt:requestEncoding value="utf-8"/>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>

	<link href="${pageContext.request.contextPath }/resources/css/jsRapCalendar.css" rel="stylesheet" type="text/css">

	<script src="${pageContext.request.contextPath }/resources/js/jsRapCalendar.js"></script>
<script>
$(document).ready(function(){
	$('#demo').jsRapCalendar({
	  week:6

	});

});

</script>
<div class="mx-auto align-middle my-5" style="width:50%;">
<div class="text-left d-inline">
	<div class="d-inline">
		<div class="date_choice text-center d-inline align-middle" >
			<div class="tit_process tit_date_choice">
			<h2 class="mx-auto mt-3 text-center">공연일정 삭제</h2>

		    <br /><br />

				<div class="cont_process d-inline-block align-middle mx-3">
					<div id="demo" class="d-inline-block"></div>
				</div>
				

			</div>
		</div>
	</div>
	
	<div>
		<table class='table table-hover text-center' id="result-table">
			<tr>
				<th>날짜</th>
				<th>시</th>
				<th>분</th>
				<th></th>
			</tr>
			<c:if test="${ not empty schList }">
				<c:forEach items="${ schList }" var="sch">
					<tr id="${ sch.schNo }">
						<td>${ sch.date }</td>
						<td>${ sch.hour }시</td>
						<td>${ sch.min }분</td>
						<td>
							<button type="button" class="btn btn-outline-primary"
								    onclick="deleteSch('${sch.schNo}')">삭제</button>
						</td>
					</tr>
				</c:forEach>
			</c:if>
<%-- 			<c:if test="${ empty schList }">
				일정이 존재하지 않습니다.
			</c:if> --%>
		</table>
	</div>
	
	<div class="mx-auto text-center">
		<button type="button" class="btn btn-outline-primary px-2" onclick="perDateUpdate('${ perNo }')">공연 일정 추가</button>
		<input type="button" class="btn btn-primary" value="완료" onclick="location.href='${pageContext.request.contextPath }/company/companyPerList.do'"/>
	</div>

</div>
</div>

<!-- 공연일정수정 -->
<form action="${ pageContext.request.contextPath }/company/perDateUpdate.do"
	  method="post" id="perDateUpdate" >
	  <input type="hidden" name="perNo"/>
</form>

<script>
function deleteSch(schNo){
	

  	if (!confirm("일정을 삭제하시겠습니까?")) {
        return;
    } 

	$(document).ajaxSend(function(e, xhr, options) {
		xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
		});

 	$.ajax({
		url : "${pageContext.request.contextPath}/company/deleteDate.do",
		data : {"schNo":schNo },
		method : "POST",
		success : function(data){
				$("#"+schNo).remove();
		},
		error : function(xhr, status, err){
				console.log("처리실패", xhr, status, err);
		}

	});  
}

function perDateUpdate(perNo){
	var $frm = $("#perDateUpdate");
	$frm.find("[name=perNo]").val(perNo);
	$frm.submit();
}




</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
   
