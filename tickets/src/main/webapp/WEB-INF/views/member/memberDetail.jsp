<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- 한글 인코딩 처리  -->
<fmt:requestEncoding value="utf-8"/>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="내 정보" name="pageTitle"/>
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


	<form:form id="memberEnrollFrm" action="${pageContext.request.contextPath }/member/memberUpdate.do" method="POST">
		<div class="mx-auto">
		    <h2 class="mx-auto mt-3 text-center">내 정보</h2>		    
		    <br /><br />
			<%-- <div class="form-group d-flex mx-auto">
				 <div class="custom-control custom-radio form-check form-check-inline" style="width:30%;">
				    <input type="radio" id="memberRole1" name="memberRole" class="custom-control-input"
				    	   value="U" ${loginMember.memberRole=='U'? 'checked':'' } readonly>
				    <label class="custom-control-label" for="memberRole1">일반 회원</label>
				 </div>
				 <div class="custom-control custom-radio form-check form-check-inline" style="width:30%;">
				    <input type="radio" id="memberRole2" name="memberRole" class="custom-control-input" 
				    	   value="C" ${loginMember.memberRole=='C'? 'checked':'' } readonly>
				    <label class="custom-control-label" for="memberRole2">기획사</label>
				 </div>
			</div> --%>
	
			<div class="form-group" id="memberId-container">
			  <label class="col-form-label" for="memberId">아이디</label>
			  <input type="text" class="form-control" id="memberId" name="memberId" 
			  		 value="${loginMember.memberId }" readonly>
			</div>
			<div class="form-group">
			  <p>비밀번호</p>
			  <button type="button" class="btn btn-primary"
			  		  onclick="location.href='${pageContext.request.contextPath }/member/updatePasswordForm.do?memberId=${loginMember.memberId}'">
			    비밀번호 변경하기		  
			  </button>
			</div>
			
			<div class="form-group">
			  <label class="col-form-label" for="name">이름</label>
			  <input type="text" class="form-control" id="name" name="name" 
			  		 value="${loginMember.name }" required>
			</div>
			<div class="form-group">
			  <label class="col-form-label" for="email">이메일</label>
			  <input type="email" class="form-control" id="email" name="email" 
			  		 value="${loginMember.email }" required>
			</div>
			<div class="form-group">
			  <label class="col-form-label" for="phone">전화번호</label>
			  <input type="tel" class="form-control" id="phone" name="phone" 
			  		 value="${loginMember.phone }" required>
			</div>
			<div class="form-group">
				<label for="sample4_datailAddress">주소</label>
				<div class="align-middle">
					<input class="form-control d-inline-block" style="width:40%;" type="text" id="sample4_postcode" name="postCode"
						   value="${loginMember.postCode }" readonly>
					<input type="button" class="d-inline-block mx-3 btn btn-outline-primary" style="width:30%;" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
				</div>
				<input class="form-control my-1" type="text" id="sample4_roadAddress" name="addr" 
					   value="${loginMember.addr }" readonly>
				<span id="guide" style="color:#999;display:none"></span>
				<input class="form-control" type="text" id="sample4_detailAddress" name="addrDetail"
					   placeholder="${loginMember.addrDetail==null? '상세주소':''}"
					   value="${ loginMember.addrDetail }">
			</div>
			<div class="mx-auto" style="width:80px;">
				<input type="submit" class="btn btn-primary" value="수정"/>
			</div>
				<hr />				
			<button type="button" 
						class="btn btn-outline-primary"
						onclick="memberWithdraw('${ loginMember.memberId }')">회원 탈퇴</button>
			<div style="float: right;">
				
			</div>
		</div>
	</form:form>
	
	
</div>

<form:form action="${ pageContext.request.contextPath }/member/memberWithdraw.do" 
	  id="memberWithdrawFrm" 
	  method="POST">
	<input type="hidden" name="memberId" />
</form:form>

<script>
/**
 * POST 요청 처리할 것
 **/
function memberWithdraw(memberId){
	if(confirm("정말 탈퇴하시겠습니까?") == false)
		return;
	var $frm = $("#memberWithdrawFrm");
	$frm.find("[name=memberId]").val(memberId);
	$frm.submit();
	
}

</script>

<script>
/* 선택 안 한 라디오 버튼 비활성화 */
$(':radio:not(:checked)').attr('disabled', true);
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
   
