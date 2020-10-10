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
					<li class="border-primary p-3 ml-3" 
						style="background-color:#f2f2f2; border-bottom:5px solid;" >
						<a href="">
							<h3>아이디 찾기</h3>
						</a>
					</li>
					&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
					<li class="border-primary p-3" style="background-color:#f2f2f2;">
						<a href="" class="text-muted">
							<h3>비밀번호 찾기</h3>
						</a>
					</li>
				</ul>
			</div>			
		</header>
		
		<section id="content" class="mx-auto border p-5 text-center" style="width:45%; background-color:white;" >
				<h4>회원님의 아이디는 다음과 같습니다.</h4>
				<div id="idResult" class="p-3">
					<h5 class="text-primary">${ encryptedId }</h5>
				</div>
				<span>개인정보 보호를 위해,<br />전체 아이디는 저장된 이메일 주소로 보내드립니다.</span>
				<br /><br />
				<hr />
				<br />
				<input type="button" class="btn btn-primary m-1" onClick="location.href='${pageContext.request.contextPath}/member/memberLoginForm.do'" value="로그인"/>
				<input type="button" class="btn btn-outline-primary m-1" onClick="location.href='${pageContext.request.contextPath}/member/searchPwdFrm'" value="비밀번호 찾기"/>

		</section>
		
		
	</div>
	

	
</body>


</html>