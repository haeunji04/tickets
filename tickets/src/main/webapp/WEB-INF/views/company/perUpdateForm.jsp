<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- 한글 인코딩 처리  -->
<fmt:requestEncoding value="utf-8"/>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="회원가입" name="pageTitle"/>
</jsp:include>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>


</script>

<style>
/*중복아이디체크관련*/
div#memberId-container{position:relative; padding:0px;}
div#memberId-container span.guide {display:none;font-size: 12px;position:absolute; top:12px; right:10px;}
div#memberId-container span.ok{color:green; font-weight:bold;}
div#memberId-container span.error{color:red; font-weight:bold;}
</style>

<div id="enroll-container" class="mx-auto py-3" style="width: 40%">


	<form id="perUpdateFrm" 
		  action="${pageContext.request.contextPath }/company/perUpdate.do" 
		  method="POST"
		  enctype="multipart/form-data">
		<div class="mx-auto">
		    <h2 class="mx-auto mt-3 text-center">공연 수정</h2>
		    <br /><br />
		    
		    <div class="form-group" id="memberId-container">
			  <input type="hidden" class="form-control" id="perNo" name="perNo" value="${ performance.perNo }" readonly required>
			</div>
				
			<div class="form-group" id="memberId-container">
			  <label class="col-form-label" for="memberId">기획사 아이디</label>
			  <input type="text" class="form-control" id="memberId" name="memberId" value="${ performance.memberId }" readonly required>
			</div>
						
			<div class="form-group">
			  <label class="col-form-label" for="perTitle">공연제목</label>
			  <input type="text" class="form-control" id="perTitle" name="perTitle" value="${ performance.perTitle }" required>
			</div>
			<div class="form-group">
			  <label class="col-form-label" for="perDirector">공연감독</label>
			  <input type="text" class="form-control" id="perDirector" name="perDirector" value="${ performance.perDirector }" required>
			</div>
			<div class="form-group">
			  <label class="col-form-label" for="perActor">출연배우</label>
			  <input type="text" class="form-control" id="perActor" name="perActor" value="${ performance.perActor }" required>
			</div>	
			 	
			
			<div class="form-group">
		      <label class="col-form-label" for="perContent">공연소개</label>
		      <textarea class="form-control" name="perContent" id="perContent" rows="3" value="">
		      		${ performance.perContent }
		      </textarea>
		    </div>
		    
		    <div class="form-group">
		      <label for="perImgFile">공연 이미지</label>
		      <input type="file" class="form-control-file" id="perImgFile" name="perImgFile">	
		      <span id="frame">${ performance.perImgOriginalFileName != null ? performance.perImgOriginalFileName : "" }</span>	 
		      <input type="hidden" name="oldPerImgOriginalFileName"
		      		 value="${ performance.perImgOriginalFileName != null ? performance.perImgOriginalFileName : '' }"/>    
		      <input type="hidden" name="oldPerImgRenamedFileName"
		      		 value="${ performance.perImgRenamedFileName != null ? performance.perImgRenamedFileName : '' }"/>    
		    </div>
			
			<div class="form-group">
		      <label for="detailImgFile">작품설명 이미지</label>
		      <input type="file" class="form-control-file" id="detailImgFile" name="detailImgFile">		      
		      <span id="frame">${ performance.detailImgOriginalFileName }</span>	 
		      <input type="hidden" name="oldDetailImgOriginalFileName"
		      		 value="${ performance.detailImgOriginalFileName != null ? performance.detailImgOriginalFileName : ''}"/>    
		      <input type="hidden" name="oldDetailImgRenamedFileName"
		      		 value="${ performance.detailImgRenamedFileName != null ? performance.detailImgOriginalFileName : ''}"/>    
		    </div>  
		    
		    <tr>
				<label for="perStartDate">공연시작일</label>
				<input type="date" class="form-control" name="perStartDate" id="perStartDate"
					   value="${ performance.perStartDate }"/>
			</tr> 
		    <tr>
				<label for="perEndDate">공연종료일</label>
				<input type="date" class="form-control" name="perEndDate" id="perEndDate"
					   value="${ performance.perEndDate }"/>
			</tr> 		
		    
		    <div class="form-group">
		      <label for="perRating">공연 관람 등급</label>
		      <select class="form-control" id="perRating" name="perRating"  >
		        <option value="0"${ performance.perRating == 0 ? 'selected':'' }>전체관람가</option>
		        <option value="8"${ performance.perRating == 8 ? 'selected':'' }>8세이상관람가</option>
		        <option value="15"${ performance.perRating == 15 ? 'selected':'' }>15세이상관람가</option>
		        <option value="18"${ performance.perRating == 18 ? 'selected':'' }>18세이상관람가</option>
		      </select>
		    </div>
		    
		    <div class="form-group">
		      <label for="perTime">공연 관람 시간</label>
		      <select class="form-control" id="perTime" name="perTime">
		        <option value="60"${ performance.perTime == 60 ? 'selected':'' }>60분</option>
		        <option value="70"${ performance.perTime == 70 ? 'selected':'' }>70분</option>
		        <option value="80"${ performance.perTime == 80 ? 'selected':'' }>80분</option>
		        <option value="90"${ performance.perTime == 90 ? 'selected':'' }>90분</option>
		        <option value="100"${ performance.perTime == 100 ? 'selected':'' }>100분</option>
		        <option value="110"${ performance.perTime == 110 ? 'selected':'' }>110분</option>
		        <option value="120"${ performance.perTime == 120 ? 'selected':'' }>120분</option>
		        <option value="130"${ performance.perTime == 130 ? 'selected':'' }>130분</option>
		        <option value="140"${ performance.perTime == 140 ? 'selected':'' }>140분</option>
		        <option value="150"${ performance.perTime == 150 ? 'selected':'' }>150분</option>
		        <option value="160"${ performance.perTime == 160 ? 'selected':'' }>160분</option>
		        <option value="170"${ performance.perTime == 170 ? 'selected':'' }>170분</option>
		        <option value="180"${ performance.perTime == 280 ? 'selected':'' }>180분</option>
		      </select>
		    </div>
		    
		    <div class="form-group">
		      <label for="categoryCode">카테고리 선택</label>
		      <select class="form-control" id="categoryCode" name="categoryCode" value="${ performance.categoryCode }" >
		        <option value="C1"${ performance.categoryCode == 'C1' ? 'selected':'' }>뮤지컬</option>
		        <option value="C2"${ performance.categoryCode == 'C2' ? 'selected':'' }>연극</option>
		        <option value="C3"${ performance.categoryCode == 'C3' ? 'selected':'' }>콘서트</option>
		        <option value="C4"${ performance.categoryCode == 'C4' ? 'selected':'' }>클래식</option>
		        <option value="C5"${ performance.categoryCode == 'C5' ? 'selected':'' }>전시</option>
		      </select>
		    </div>
		    
		    <div class="form-group">
		      <label for="locationCode">지역 선택</label>
		      <select class="form-control" id="locationCode" name="locationCode" value="${ performance.locationCode }">
		        <option value="L1"${ performance.locationCode == 'L1' ? 'selected':'' }>서울</option>
		        <option value="L2"${ performance.locationCode == 'L2' ? 'selected':'' }>경기/인천</option>
		        <option value="L3"${ performance.locationCode == 'L3' ? 'selected':'' }>대전/세종/충청/강원</option>
		        <option value="L4"${ performance.locationCode == 'L4' ? 'selected':'' }>부산/대구/경상/울산</option>
		        <option value="L5"${ performance.locationCode == 'L5' ? 'selected':'' }>광주/전라/제주</option>
		      </select>
		    </div>
			
			<div class="mx-auto" style="width:80px;">
				<input type="submit" class="btn btn-primary" value="완료"/>
			</div>
		</div>
	</form>
	
	
</div>

<script>
$(function(){
	   //사용자가 파일을 선택/해제한 경우
	   $("[name=perImgFile]").change(function(){
	      console.log($(this).val());
	      if($(this).val() != ""){
	         $("#frame").hide();
	      }else{
	         $("#frame").show();
	      }
	         
	   });
	});




</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
   
