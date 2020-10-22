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
	<title>팝업</title>
	
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
<script type="text/javascript">
function setCookie( name, value, expiredays ){
	var todayDate = new Date();
	todayDate.setDate( todayDate.getDate() + expiredays );
	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
}

function closeWin(){
	if ( document.form1.popup.checked )
		setCookie( "popup", "done" , 1);
	self.close();
}

</script>
<body>
<div>
	<div id="close" class="text-center"> 
	<img src="${pageContext.request.contextPath }/resources/images/etc/팝업.png" style=" width:450px;"/>
	</div>	
	<div class="text-center">
	    <form name="form1">
	        <input type="checkbox" name="popup" value="">
	        <span>오늘하루 그만보기</span>
	        <a href="javascript:onclick=closeWin()">[닫기]</a> 
	    </form>
	</div>
</div>

</body>


</html>
