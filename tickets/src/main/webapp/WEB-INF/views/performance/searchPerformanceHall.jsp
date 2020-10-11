<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"  %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 한글 인코딩 처리  -->
<fmt:requestEncoding value="utf-8"/>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8" />
	<title>공연장 검색하기</title>
	
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		
		<!-- bootstrap js: jquery load 이후에 작성할것.-->
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

		<!-- css 시작  -->
			<!-- journal 테마 -->
        <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css" />
		<!-- css 끝 -->
	
<style>
@font-face {
     font-family: 'S-CoreDream-3Light';
     src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_six@1.2/S-CoreDream-3Light.woff') format('woff');
     font-weight: normal;
     font-style: normal;
}
            
*{
	font-family: 'S-CoreDream-3Light' !important;
	font-size: 17px;
}
</style>
	
</head>
<body>
	<div class="text-center">
		<h3 class="mt-3">공연장 검색</h3>
		<form:form id="searchHallFrm" class="form-group">
			<input type="text" class="form-control mx-auto my-2 d-inline" id="searchHallKeyword"
				   style="width:50%;" name="searchHallKeyword" placeholder="공연장 이름 검색"/>
			<input type="button" id="btn-searchHall"
				   class="btn btn-primary mt-0" value="검색" />
		</form:form>

	</div>
<div class="result mx-3" id="hall-result"></div>

</body>
<script>
	$("#btn-searchHall").click(function(){
		var $frm = $("#searchHallFrm");

		var keyword = $frm.find("[name=searchHallKeyword]").val();
		$(document).ajaxSend(function(e, xhr, options) {
			xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
			});
		
		$.ajax({
			url : "${ pageContext.request.contextPath }/searchHall/" + keyword,
			dataType: "json",
			method: "GET",
			success : function(data){
				console.log(data);
				displayResultTable("hall-result", data);
			},
			error : function(xhr, status, err){
				console.log("처리실패", xhr, status, err);
			}

		});

	});

	function displayResultTable(id, data){
		var $container = $("#" + id);
		var html = "<table class='table table-hover text-center'>";
		html += "<tr class='table-primary'><th colspan='3'>주소</th><th>이름</th><th>좌석</th><th></th></tr>"

		if(data.length > 0){
			for(var i in data){
				var hall = data[i];
				html += "<tr>";
				/* html += "<td>"+ hall.no +"</td>"; */
				html += "<td>"+ hall.theaterLocation +"</td>";
				html += "<td>"+ hall.theaterCity +"</td>";
				html += "<td>"+ hall.theaterAddress +"</td>";
				html += "<td>"+ hall.theaterName +"</td>";
				html += "<td>"+ hall.totalSeat +"</td>";
				html += "<td><input type='button' class='btn btn-outline-primary' value='선택' onclick='sendData("+hall.theaterNo+",\""+hall.theaterName+"\")'/></td>";
				//html += "<td><input type='button' class='btn btn-outline-primary' value='선택' onclick='sendData("+hall.no+")'/></td>";
				html += "</tr>";

			}
		}
		else {
			html+="<tr><td colspan='5'>검색된 결과가 없습니다.</td></tr>";
		}

		html += "</table>";

		$container.html(html);

	}

function sendData(hallNo,hallName){
	console.log(hallNo,hallName);

	opener.setValue(hallNo, hallName);
	
	window.close();
}

</script>

</html>
