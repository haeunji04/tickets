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
	  week:6,
		onClick:function(y,m,d){
			var date = y+"-"+(m+1)+"-"+d;

			document.getElementById("inputDate").value = date;
		}
	});

});

</script>

<div class="mx-auto align-middle my-5" style="width:50%;">
<div class="text-left d-inline">
	<div class="d-inline">
		<div class="date_choice text-center d-inline align-middle" >
			<div class="tit_process tit_date_choice">
			<h2 class="mx-auto mt-3 text-center"><small class="text-muted">공연 등록 &gt;</small> 공연일정</h2>
			<br /><br />
			<div class="progress mx-auto" style="width:80%;">
			  	<div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100" style="width: 70%"></div>
			</div>
		    <br /><br />

				<div class="cont_process d-inline align-middle mx-3">
					<div id="demo" class="d-inline"></div>
				</div>
				<div class="d-inline-block align-middle" >
					<form action="${ pageContext.request.contextPath }/performance/performanceDate.do" 
						  method="post" class="form-group"
						  id="scheduleFrm">
						<input type="hidden" name="perNo" id="perNo" value="${ perNo }" />
						<div class="input-group my-3">
							<div class="input-group-prepend" style="height:40px;">
								<label for="inputDate" class="input-group-text"> 날짜 </label>
							</div>
							<input type="text" id="inputDate" name="inputDate" class="form-control"
									aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"/>
						</div>
						<div class="input-group my-3">
							<div class="input-group-prepend" style="height:40px;">
								<label for="timeHour" class="input-group-text"> 시 </label>
							</div>
							<select name="timeHour" id="timeHour" class="custom-select">
								<option value="0">0시</option>
								<option value="1">1시</option>
								<option value="2">2시</option>
								<option value="3">3시</option>
								<option value="4">4시</option>
								<option value="5">5시</option>
								<option value="6">6시</option>
								<option value="7">7시</option>
								<option value="8">8시</option>
								<option value="9">9시</option>
								<option value="10">10시</option>
								<option value="11">11시</option>
								<option value="12">12시</option>
								<option value="13">13시</option>
								<option value="14">14시</option>
								<option value="15">15시</option>
								<option value="16">16시</option>
								<option value="17">17시</option>
								<option value="18">18시</option>
								<option value="19">19시</option>
								<option value="20">20시</option>
								<option value="21">21시</option>
								<option value="22">22시</option>
								<option value="23">23시</option>			
							</select>
						</div>
						<div class="input-group my-3">
							<div class="input-group-prepend" style="height:40px;">
								<label for="timeMin" class="input-group-text"> 분 </label>
							</div>
							<select name="timeMin" id="timeMin" class="custom-select" >
								<option value="00">0분</option>
								<option value="05">5분</option>
								<option value="10">10분</option>
								<option value="15">15분</option>
								<option value="20">20분</option>
								<option value="25">25분</option>
								<option value="30">30분</option>
								<option value="35">35분</option>
								<option value="40">40분</option>
								<option value="45">45분</option>
								<option value="50">50분</option>
								<option value="55">55분</option>
							</select>
						</div>
						<div>
							<input type="button" 
								   class="btn btn-primary d-inline"
								   id="btn-addSchedule" 
								   value="추가"/>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<br />
	<br />
	<br />
	
	<div>
		<table class='table table-hover text-center' id="result-table">
			<tr>
				<th>날짜</th>
				<th>시</th>
				<th>분</th>
			</tr>
		</table>
	</div>
	
	<div class="mx-auto text-center">
		<input type="button" class="btn btn-primary" value="공연 등록 완료" onclick="location.href='${pageContext.request.contextPath}/performance/performanceRegisterEnd'"/>
	</div>

</div>
</div>

<script>

$("#btn-addSchedule").click(function(){
	var $frm = $("#scheduleFrm");

	var schedule = {
		date : $frm.find("[name=inputDate]").val(),
		hour : $frm.find("[name=timeHour]").val(),
		min : $frm.find("[name=timeMin]").val(),
		perNo : $frm.find("[name=perNo]").val()
	};

	console.log("schedule="+schedule);

	var jsonStr = JSON.stringify(schedule);
	console.log("jsonStr="+jsonStr);
	
	$.ajax({
		url : "${ pageContext.request.contextPath }/performance/scheduleRegister",
		data : jsonStr,
		method : "POST",
		contentType : "application/json; charset=utf-8",
		success : function(){
				console.log();
				displayResultTable();
		},
		error : function(xhr, status, err){
				console.log("처리실패", xhr, status, err);
		},
		complete : function(){
				$frm[0].reset();
		}

	});


	
});

function displayResultTable(){

	var $container = $("#result-table");
	
	var $frm = $("#scheduleFrm");

	var date = $frm.find("[name=inputDate]").val();
	var hour = $frm.find("[name=timeHour]").val();
	var min= $frm.find("[name=timeMin]").val();

	var html =  "<tr>";
		html += "<td>"+date+"</td>";
		html += "<td>"+hour+"시</td>";
		html += "<td>"+min+"분</td>";
		html +=	"</tr>";

		$container.append(html);
}

		


</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
   
