<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- 한글 인코딩 처리  -->
<fmt:requestEncoding value="utf-8"/>



<jsp:include page="/WEB-INF/views/common/header.jsp" />




<script>
function passwordValidate(){
	var $newPwd = $("#newPassword");
	var $newPwdChk = $("#newPasswordCheck");
	
	if(!/^[A-Za-z0-9+]{4,12}$/.test($newPwd.val())){
		alert("4~12자 영문 대 소문자, 숫자를 사용하세요.");
		$newPwd.focus();
		return false;
	}
	
	if($newPwd.val()!=$newPwdChk.val()){
		alert("입력한 비밀번호가 일치하지 않습니다.");
		$newPwd.select();
		return false;
	}
	
	return true;	
}
</script>
<div class="#">
    <div>
         <div class="" >
         		<!-- <h1>비밀번호 변경</h1> -->
         		<hr /><br /><br />
                    <table class="table table-hover">
                     
                        <tbody>
                            <form:form name="updatePasswordFrm" action="${pageContext.request.contextPath }/member/updatePassword.do" method="post" encType="multiplart/form-data ">
                                <input type="hidden" name="memberId" value="${ memberId  }" /> 
                                <tr class="text_pwd">
                                    <td class="#" rowspan="4" style="vertical-align: middle;">
                                        	<h4>비밀번호 변경</h4>
                                    </td>
                                </tr>
                                <tr>
                                    <td><input type="password" 
                                    		   placeholder="현재 비밀번호" 
                                    		   name="password" 
                                    		   id="password" 
                                    		   class="form-control text-dark" 
                                    		   required/></td>
                                </tr>
                                <tr>
                                    <td><input type="password" 
                                    		   placeholder="변경할 비밀번호" 
                                    		   name="newPassword" 
                                    		   id="newPassword" 
                                    		   class="form-control" 
                                    		   required/></td>
                                </tr>
                                <tr>
                                    <td><input type="password" 
                                    		   placeholder="비밀번호 확인" 
                                    		   id="newPasswordCheck" 
                                    		   class="form-control" 
                                    		   required/></td>
                                </tr>
                                
                                
                                <tr>
                                    <td colspan="2" style="width:250px;">
                                    <div>
                                        <input type="submit" 
                                        	   value="비밀번호 변경" 
                                        	   onclick="return passwordValidate();" 
                                        	   class="btn btn-primary"/>                                    
                                    </div>
                                    </td>
                                </tr>
                            </form:form>
                        </tbody>
                    </table>
                    </div>
    </div>
</div>



<jsp:include page="/WEB-INF/views/common/footer.jsp"/>