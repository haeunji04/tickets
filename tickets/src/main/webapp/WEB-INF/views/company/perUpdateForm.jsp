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
/* 우편번호 API 시작 */
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
/* 우편번호 API 끝 */


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
			
			<%-- <div class="form-group">
				<label for="sample4_datailAddress">공연주소</label>
				<div class="align-middle">
					<input class="form-control d-inline-block" style="width:40%;" type="text" id="sample4_postcode" value="${performance.postCode }" readonly>
					<input type="button" class="d-inline-block mx-3 btn btn-outline-primary" style="width:30%;" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
				</div>
				<input class="form-control my-1" type="text" id="sample4_roadAddress" name="address" value="${performance.postCode }" readonly>
				<span id="guide" style="color:#999;display:none"></span>
				<input class="form-control" type="text" id="sample4_detailAddress" name="address_" placeholder="상세주소">
			</div>		 --%> 	
			
			<div class="form-group">
		      <label class="col-form-label" for="perContent">공연소개</label>
		      <textarea class="form-control" name="perContent" id="perContent" rows="3" value="">
		      		${ performance.perContent }
		      </textarea>
		    </div>
		    
		    <div class="form-group">
		      <label for="perImgFile">공연 이미지</label>
		      <input type="file" class="form-control-file" id="perImgFile" name="perImgFile" >	
		      <span type="frame">${ performance.perImgOriginalFileName }</span>	 
		      <input type="hidden" name="${ performance.perImgOriginalFileName }"
		      		 value="${ performance.perImgOriginalFileName }"/>    
		      <input type="hidden" name="${ performance.perImgRenamedFileName }"
		      		 value="${ performance.perImgRenamedFileName }"/>    
		    </div>
			
			<div class="form-group">
		      <label for="detailImgFile">작품설명 이미지</label>
		      <input type="file" class="form-control-file" id="detailImgFile" name="detailImgFile">		      
		      <span type="frame">${ performance.detailImgOriginalFileName }</span>	 
		      <input type="hidden" name="${ performance.detailImgOriginalFileName }"
		      		 value="${ performance.detailImgOriginalFileName }"/>    
		      <input type="hidden" name="${ performance.detailImgRenamedFileName }"
		      		 value="${ performance.detailImgRenamedFileName }"/>    
		    </div>  
		    
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
		        <option value="L3"${ performance.locationCode == 'L3' ? 'selected':'' }>대전/충청/강원</option>
		        <option value="L4"${ performance.locationCode == 'L4' ? 'selected':'' }>부산/대구/경상</option>
		        <option value="L5"${ performance.locationCode == 'L5' ? 'selected':'' }>광주/전라/제주</option>
		      </select>
		    </div>
			
			<div class="mx-auto" style="width:80px;">
				<input type="submit" class="btn btn-primary" value="수정 하기"/>
			</div>
		</div>
	</form>
	
	
</div>

<script>


$("#performanceRegisterFrm").submit(function(){
	

	var $address = $("#sample4_postcode");
	if($address.val().trim().length == 0){
		alert("주소를 입력해주세요.");
		return false;
	}

	return true;
});


</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
   
