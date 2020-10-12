<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!-- 한글 인코딩 처리  -->
<fmt:requestEncoding value="utf-8"/>

<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8" />
	
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		
		<!-- bootstrap js: jquery load 이후에 작성할것.-->
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

		<!-- css 시작  -->
			<!-- journal 테마 -->
        <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css" />
		<!-- css 끝 -->
		
	<title>티캣츠</title>

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
body{
	background-color: #f2f2f2;
}

th{
	width: 140px;
	text-align: left;
}

table{
	border-collapse: separate;
	border-spacing: 0 10px;
}

input[type=text], input[type=email] {
	width:300px;
	height:50px;
}
.check {
	display:none;
}
</style>

<script>



function validate(){
	let $inputKey = $("#inputKey").val();
	let $password = $("#password").val();
	let $password_ = $("#password_").val();

	 if($inputKey.trim().length==0){
 		$("#keyChk").text("인증번호를 입력해주세요.");
 		$("#keyChk").show();

 		return false;
	} else {
		$("#keyChk").hide();
	}
		
	if($password.trim().length==0){
		$("#passwordChk").text("새 비밀번호를 입력해주세요.");
 		$("#passwordChk").show();

 		return false;
	} else {
		$("#passwordChk").hide();
	} 

	if($password_.trim().length==0){
		$("#password_Chk").text("비밀번호를 한 번 더 입력해주세요.");
 		$("#password_Chk").show();

 		return false;
	} else {
		$("#password_Chk").hide();
	}

	let $key = $("#key").val();
		
	if( $inputKey.length != 0 && $inputKey != $key ){
		$("#keyChk").text("인증번호를 정확하게 입력해주세요.")
		$("#keyChk").show();

		return false;
	}
		
	if($password != $password_){
		$("#passwordChk").hide();
		$("#password_Chk").text("비밀번호가 일치하지 않습니다.");
		$("#password_Chk").show();

		return false;
	}


} 


</script>
</head>
<body class="border-primary" style="border-top-style:solid; border-width:5px;">
	<div id="container" class="mx-auto" style="width:75%;">
		<header>
			<div class="text-center my-4">
				<a href="${pageContext.request.contextPath }/">
					<img src="${pageContext.request.contextPath }/resources/images/도안6-4.png" style="height:130px;"/>
				</a>
			</div>
			<div class="text-center">
				<ul class="list-group list-group-horizontal justify-content-center" style="list-style:none;">
					<li class="border-primary p-3 ml-3" style="background-color:#f2f2f2;">
						<a href="${pageContext.request.contextPath }/member/searchIdFrm" class="text-muted">
							<h3>아이디 찾기</h3>
						</a>
					</li>
					&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
					<li class="border-primary p-3" 
						style="background-color:#f2f2f2; border-bottom:5px solid;" >
						<a href="${pageContext.request.contextPath }/member/searchPwdFrm">
							<h3>비밀번호 찾기</h3>
						</a>
					</li>
				</ul>
			</div>			
		</header>
		
		<section id="content" class="mx-auto border p-5 text-center" style="width:45%; background-color:white;" >
				<p>인증번호 입력 후, 비밀번호를 변경해주세요.</p>
			<form:form action="${ pageContext.request.contextPath }/member/updatePwd.do" method="POST">
				<input type="hidden" name="key" id="key" value="${ key }"/>
				<table class="mt-5 mx-auto" id="form-table">
				<tr>
					<th>인증번호</th>
					<td>
						<input type="text" id="inputKey" name="inputKey" class="form-control"/>
						<span id="keyChk" class="check text-primary"></span>
						<%-- <span>${ key }</span> --%>
					</td>
				</tr>
				<tr>
					<th>아이디</th>
					<td>
						 <input type="text" class="form-control-plaintext" id="memberId" name="memberId" value="${ member.memberId }" readonly>
					</td>
				</tr>
				<tr>
					<th>새 비밀번호</th>
					<td>
						<input type="password" id="password" name="password" class="form-control"/>
						<span id="passwordChk" class="check text-primary"></span>
					</td>
				</tr>
				<tr>
					<th>새 비밀번호 확인</th>
					<td>
						<input type="password" id="password_" name="password_" class="form-control"/>
						<span id="password_Chk" class="check text-primary"></span>
					</td>
				</tr>
				</table>
				<br /><br />
						<input type="submit" class="btn btn-primary" onclick="return validate();" value="비밀번호 변경"/>
			</form:form>
		</section>
		
		
	</div>
	

	
</body>


</html>