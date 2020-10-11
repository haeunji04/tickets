<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8" />
	<title>로그인</title>
	
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<!-- bootstrap js: jquery load 이후에 작성할것.-->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
	<!-- bootstrap css -->
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css" />	

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
<script>
$(function(){
	$("#loginModal").modal()
					.on("hide.bs.modal", function(){
						location.href = "${ header.referer }";
					});
});

<%-- RedirectAttributes에 등록된 msg값 존재여부 확인 후 출력 --%>
<c:if test="${ not empty msg }">
	alert('${ msg }');
	console.log('${ msg }');
</c:if>

</script>

</head>
<body>
	
	<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
					    	
				<div class="modal-header">
					<h5 class="modal-title" id="loginModalLabel">로그인</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
					</button>
				</div>
							
				<!-- _csrf인증 토큰 발행 -->
				<!-- security 관련 -->	      
				<form:form 
					action="${pageContext.request.contextPath }/member/memberLogin.do" 
					method="POST">
				<div class="modal-body">
						<table class="mx-auto">
							<tr>
								<th>아이디</th>
								<td>
								<input type="text" class="form-control" 
								name="memberId" id="memberId" 
								placeholder="아이디를 입력하세요." required/>
								</td>
							</tr>
							<tr>
								<th>비밀번호</th>
								<td>
								<input type="password" class="form-control"
								name="password" id="password" 
								placeholder="비밀번호" required/>
								</td>
							</tr>		
							
							<tr height="50px;">
								<td valign="bottom" align="left">
									<input type="checkbox" name="saveId" id="saveId"/>
									<label for="saveId" class="mb-0"><small>아이디 저장</small></label>
								</td>				
								<td valign="bottom" align="right">
									<a href="${ pageContext.request.contextPath }/member/searchIdFrm" class="text-reset"><small>아이디 찾기</small></a>
									<span class="text-secondary">|</span>
									<a href="${ pageContext.request.contextPath }/member/searchPwdFrm" class="text-reset"><small>비밀번호 찾기</small></a> 
								</td>			
							</tr>							        			
										        		
						</table>
				</div>
								      
				<div class="modal-footer">
				<button type="submit" class="btn btn-primary">로그인</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal" aria-label="Close">취소</button>
				</div>
				</form:form>
			</div>
		</div>
	</div>

</body>
</html>   




