<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"  %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 한글 인코딩 처리  -->
<fmt:requestEncoding value="utf-8"/>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="회원가입" name="pageTitle"/>
</jsp:include>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>



<style>
/*중복아이디체크관련*/
div#memberId-container{position:relative; padding:0px;}
div#memberId-container span.guide {display:none;font-size: 12px;position:absolute; top:12px; right:10px;}
div#memberId-container span.ok{color:green; font-weight:bold;}
div#memberId-container span.error{color:red; font-weight:bold;}
</style>

<div id="enroll-container" class="mx-auto py-3" style="width: 40%">


	<form:form id="performanceRegisterFrm" 
		  action="${pageContext.request.contextPath }/performance/performanceRegister.do?${_csrf.parameterName}=${_csrf.token}" 
		  method="POST"
		  enctype="multipart/form-data">
		<div class="mx-auto">
		    <h2 class="mx-auto mt-3 text-center">공연 등록 <small class="text-muted">&gt; 공연일정</small></h2>
		    <br /><br />
			<div class="progress">
			  	<div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100" style="width: 30%"></div>
			</div>
		    <br /><br />
				
			<div class="form-group" id="memberId-container">
			  <label class="col-form-label" for="memberId">기획사 아이디</label>
			  <input type="text" class="form-control" id="memberId" name="memberId" value="<sec:authorize access="isAuthenticated()"><sec:authentication property="principal.username"/></sec:authorize>" readonly required>
			</div>
						
			<div class="form-group">
			  <label class="col-form-label" for="perTitle">공연제목</label>
			  <input type="text" class="form-control" id="perTitle" name="perTitle" required>
			</div>
			<div class="form-group">
			  <label class="col-form-label" for="perDirector">공연감독</label>
			  <input type="text" class="form-control" id="perDirector" name="perDirector" required>
			</div>
			<div class="form-group">
			  <label class="col-form-label" for="perActor">출연배우</label>
			  <input type="text" class="form-control" id="perActor" name="perActor" required>
			</div>
			
			<div class="form-group">
				<input type="button" class="btn btn-outline-primary" value="공연장 검색" onclick="searchHall()"/>
				<input type="text" class="form-control my-2" id="searchHallNo" name="searchHallNo" placeholder="공연장번호" readonly/>
				<input type="text" class="form-control" id="searchHallName" name="searchHallName" placeholder="공연장명" readonly/>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			</div>		
			
			<div class="form-group">
		      <label class="col-form-label" for="perContent">공연소개</label>
		      <textarea class="form-control" name="perContent" id="perContent" rows="5"></textarea>
		    </div>
		    
		    <div class="form-group">
		      <label for="perImgFile">공연 이미지</label>
		      <input type="file" class="form-control-file" id="perImgFile" name="perImgFile">		     
		    </div>
			
			<div class="form-group">
		      <label for="detailImgFile">작품설명 이미지</label>
		      <input type="file" class="form-control-file" id="detailImgFile" name="detailImgFile">	
		      <br />	      
		    </div>
		    <tr>
		    	<label for="reservationStartDate">예매시작일</label>
		    	<input type="datetime-local" class="form-control" name="reservationStart" id="reservationStart" />
		    	<br />
		    </tr>
		    <tr>
				<label for="perStartDate">공연시작일</label>
				<input type="date" class="form-control" name="perStartDate" id="perStartDate"/>
		    	<br />
			</tr> 
		    <tr>
				<label for="perEndDate">공연종료일</label>
				<input type="date" class="form-control" name="perEndDate" id="perEndDate"/>
		    	<br />
			</tr> 		
		    
		    <div class="form-group">
		      <label for="perRating">공연 관람 등급</label>
		      <select class="form-control" id="perRating" name="perRating">
		        <option value="0">전체관람가</option>
		        <option value="8">8세이상관람가</option>
		        <option value="15">15세이상관람가</option>
		        <option value="18">18세이상관람가</option>
		      </select>
		    </div>
		    
		    <div class="form-group">
		      <label for="perTime">공연 관람 시간</label>
		      <select class="form-control" id="perTime" name="perTime">
		        <option value="60">60분</option>
		        <option value="70">70분</option>
		        <option value="80">80분</option>
		        <option value="90">90분</option>
		        <option value="100">100분</option>
		        <option value="110">110분</option>
		        <option value="120">120분</option>
		        <option value="130">130분</option>
		        <option value="140">140분</option>
		        <option value="150">150분</option>
		        <option value="160">160분</option>
		        <option value="170">170분</option>
		        <option value="180">180분</option>
		      </select>
		    </div>
		    
		    <div class="form-group">
		      <label for="categoryCode">카테고리 선택</label>
		      <select class="form-control" id="categoryCode" name="categoryCode">
		        <option value="C1">뮤지컬</option>
		        <option value="C2">연극</option>
		        <option value="C3">콘서트</option>
		        <option value="C4">클래식</option>
		        <option value="C5">전시</option>
		      </select>
		    </div>
		    
		    <div class="form-group">
		      <label for="locationCode">지역 선택</label>
		      <select class="form-control" id="locationCode" name="locationCode">
		        <option value="L1">서울</option>
		        <option value="L2">경기/인천</option>
		        <option value="L3">대전/세종/충청/강원</option>
		        <option value="L4">부산/대구/경상/울산</option>
		        <option value="L5">광주/전라/제주</option>
		      </select>
		    </div>
		    
		    <div class="form-group">
		      <label><strong>※ 티켓츠 단독판매 유무: </strong><input type="checkbox" name="aloneSale" id="aloneSale" value="Y"></label>
		    </div>
		    
		    
			
			<div class="mx-auto" style="width:80px;">
				<input type="submit" class="btn btn-primary d-inline" value="다음"/>
			</div>
		</div>
	</form:form>
	
	
</div>

<script>

function searchHall(){

	window.open('${pageContext.request.contextPath}/searchPerformanceHall.do', '', 'width=800, height=600, left=200, top=200, resizable = yes');
}
function setValue(hallNo,hallName){
	document.getElementById("searchHallNo").value= hallNo;
	document.getElementById("searchHallName").value=hallName;
}

</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
   
