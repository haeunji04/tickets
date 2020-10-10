<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
	width: 120px;
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

<c:if test="${ not empty msg }">
alert('${ msg }');
console.log('${ msg }');
</c:if>

function validate(){
	let $name = $("#memberName");
	let $email = $("#memberEmail");
	let $id = $("#memberId");

	if($name.val().trim().length==0 || $email.val().trim().length==0 || $id.val().trim().length==0){

	 	if($name.val().trim().length==0){
 			$("#checkName").text("이름을 입력해주세요.");
 			$("#checkName").show();
		} else {
			$("#checkName").hide();
		}
		
		if($email.val().trim().length==0){
			$("#checkEmail").text("이메일을 입력해주세요.");
 			$("#checkEmail").show();
		} else {
			$("#checkEmail").hide();
		}

		if($id.val().trim().length==0){
			$("#checkId").text("아이디를 입력해주세요.");
 			$("#checkId").show();
		} else {
			$("#checkid").hide();
		}

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
				<p>회원정보에 등록된 이메일과 입력하신 이메일이 같아야 <br />임시 비밀번호를 발급 받으실 수 있습니다.</p>
			<form action="${ pageContext.request.contextPath }/member/findPwd.do" method="POST" id="findPwdFrm">
				<table class="mt-5 mx-auto" id="form-table">
				<tr>
					<th>아이디</th>
					<td>
						<input type="text" id="memberId" name="memberId" class="form-control"/>
						<span id="checkId" class="check text-primary"></span>
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>
						<input type="text" id="memberName" name="memberName" class="form-control"/>
						<span id="checkName" class="check text-primary"></span>
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>
						<input type="email" id="memberEmail" name="memberEmail" class="form-control"/>
						<span id="checkEmail" class="check text-primary"></span>
					</td>
				</tr>
				</table>
				<br /><br />
						<input type="submit" class="btn btn-primary" onclick="return validate();" value="인증번호 발송"/>
			</form>
		</section>
		
		
	</div>
	

	
</body>


</html>