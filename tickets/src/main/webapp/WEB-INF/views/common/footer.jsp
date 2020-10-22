<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
	</section>
	
	<style type="text/css"> 
		#floatdiv { 
		position:fixed; 
		text-align:center;
		width: 100px; 
		display:inline-block; 
		right:30px; 
		/* 창에서 오른쪽 길이 */ 
		top:10%; 
		/* 창에서 위에서 부터의 높이 */ 
		background-color: transparent; margin:0; 
		padding : 15px;
		} 
	</style>
	
	<sec:authorize access="isAuthenticated()">
	<c:if test="${ not empty rList }">
	<%-- <c:if test="${ not empty loginMember && not empty rList }">	 --%>
	<div id="floatdiv" class="border rounded">
		<p  >최근 본 공연</p>
		<hr />
		<%-- <a href="">
					<img src="${pageContext.request.contextPath }/resources/images/poster/어쩌면해피엔딩.jpg" 
						 alt="포스터" height="90px" class="mb-2"/>
				</a>
			<hr />
			<a href="" class="none">
					<img src="${pageContext.request.contextPath }/resources/images/poster/캣츠.jpg" 
						 alt="포스터" height="90px" class="mb-2"/>
			<!-- <p style="font-size: 15px">캣츠</p> -->
			</a> 
			<hr />
			<a href="" class="none">
					<img src="${pageContext.request.contextPath }/resources/images/poster/무인도탈출기.jpg" 
						 alt="포스터" height="90px" class="mb-2"/>
			<!-- <p style="font-size: 15px">캣츠</p> -->
			</a>  --%>
		<c:forEach items="${ rList }" var="recentPer" begin="0" end= "2" step="1" varStatus="status" >
			<a href="${pageContext.request.contextPath }/performance/performanceInfoView2.do?perNo=${ recentPer.perNo}">
						<img
						src="<c:url value='/resources/upload/performance/${ recentPer.perImgRenamedFileName}' />"
						alt="포스터" height="90px" class="mb-2" />
			</a>
			<%-- <a href="${pageContext.request.contextPath }/performance/performanceInfoView2.do?perNo=${ recentPer.perNo }&memberId=${loginMember.memberId}">					
			</a> --%>	 
			<hr />
				
			
		
		</c:forEach>	
		<p>
			<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-three-dots" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  				<path fill-rule="evenodd" d="M3 9.5a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zm5 0a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zm5 0a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3z"/>
			</svg>
		</p>
		<!-- <p>더보기</p> -->
		<a style="float:center;" href="${pageContext.request.contextPath}/performance/recentlyPerList.do">더보기</a>
	</div>
	</c:if>
	</sec:authorize>
	<%-- </c:if> --%>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/jquery.convform.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/demo.css">
	<section id="question">
	    <div class="vertical-align">
	        <div class="container">
	            <div class="row">
	                <div class="col-sm-6 col-sm-offset-3 col-xs-offset-0">
	                    <div class="card no-border">
	                        <div id="chat" class="conv-form-wrapper">
	                            <form action="" method="GET" class="hidden">
	                                <select data-conv-question="안녕하세요, 티켓츠 가상 도우미 Ticat ⚡️입니다
										짧고 직접적인 질문을받을 때 가장 잘 작동합니다" name="first-question">
	                                    <option value="yes">네</option>
	                                    <option value="sure">알겠습니다.!</option>
	                                </select>
	                                <input type="text" name="name" data-conv-question="만나서 반갑습니다. 제가 당신을 뭐라고 불러드리면 될까요?">
	                                <input type="text" data-conv-question="반가워요 {name}:0님 " data-no-answer="true">
	                                <!-- <input type="text" data-conv-question="This plugin supports multi-select too. Let's see an example." data-no-answer="true"> -->
	                                <select name="multi[]"  data-conv-question="무엇을 도와드릴까요?" multiple>
	                                    <option value="좌석 변경">좌석을 변경</option>
	                                    <option value="티켓 취소">티켓 취소</option>
	                                    <option value="회원 탈퇴">회원 탈퇴</option>
	                                    <option value="관람일시 변경">관람일시 변경</option>
	                                </select>
	                                <select name="programmer" data-callback="storeState" data-conv-question="예매 완료 후에는 좌석을 변경할 수 없습니다.
										변경을 원하시는 경우 [마이티켓 > 예매/취소] 메뉴에서 해당 예매 건을 취소하시고 재 예매하셔야 합니다.">
	                                    <option value="yes">잘모르겠어요</option>
	                                    <option value="no">알겠습니다</option>
	                                </select>
	                                <div data-conv-fork="programmer">
	                                    <div data-conv-case="yes">
	                                        <input type="text" data-conv-question="A fellow programmer! Cool." data-no-answer="true">
	                                    </div>
	                                    <div data-conv-case="no">
		                                    <select name="thought" data-conv-question="더 질문하실게 있으신가요?">
		                                    	<option value="yes">네</option>
		                                    	<option value="no">아니요</option>
		                                    </select>
	                                    </div>
	                                </div>
	                                <select name="callbackTest" data-conv-question="You can do some cool things with callback functions. Want to rollback to the 'programmer' question before?">
	                                    <option value="yes" data-callback="rollback">Yes</option>
	                                    <option value="no" data-callback="restore">No</option>
	                                </select>
	                                <select data-conv-question="This is it! If you like me, consider donating! If you need support, contact me. When the form gets to the end, the plugin submits it normally, like you had filled it." id="">
	                                    <option value="">Awesome!</option>
	                                </select>
	                            </form>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</section>
	<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-1.12.3.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/autosize.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery.convform.js"></script>

	<script>
		function google(stateWrapper, ready) {
			window.open("https://google.com");
			ready();
		}
		function bing(stateWrapper, ready) {
			window.open("https://bing.com");
			ready();
		}
		var rollbackTo = false;
		var originalState = false;
		function storeState(stateWrapper, ready) {
			rollbackTo = stateWrapper.current;
			console.log("storeState called: ",rollbackTo);
			ready();
		}
		function rollback(stateWrapper, ready) {
			console.log("rollback called: ", rollbackTo, originalState);
			console.log("answers at the time of user input: ", stateWrapper.answers);
			if(rollbackTo!=false) {
				if(originalState==false) {
					originalState = stateWrapper.current.next;
						console.log('stored original state');
				}
				stateWrapper.current.next = rollbackTo;
				console.log('changed current.next to rollbackTo');
			}
			ready();
		}
		function restore(stateWrapper, ready) {
			if(originalState != false) {
				stateWrapper.current.next = originalState;
				console.log('changed current.next to originalState');
			}
			ready();
		}
	</script>
	<script>
		jQuery(function($){
			convForm = $('#chat').convform({selectInputStyle: 'disable'});
			console.log(convForm);
		});
	</script>
	<button type="button" id="svg" style="border:0;position:fixed;bottom:10px;right:20px;background-color:white;">
	<svg width="3em" height="3em" viewBox="0 0 16 16" class="bi bi-chat-right-quote-fill" fill="#ff8080" xmlns="http://www.w3.org/2000/svg">
	  <path fill-rule="evenodd" d="M16 2a2 2 0 0 0-2-2H2a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h9.586a1 1 0 0 1 .707.293l2.853 2.853a.5.5 0 0 0 .854-.353V2zM7.194 4.766c.087.124.163.26.227.401.428.948.393 2.377-.942 3.706a.446.446 0 0 1-.612.01.405.405 0 0 1-.011-.59c.419-.416.672-.831.809-1.22-.269.165-.588.26-.93.26C4.775 7.333 4 6.587 4 5.667 4 4.747 4.776 4 5.734 4c.271 0 .528.06.756.166l.008.004c.169.07.327.182.469.324.085.083.161.174.227.272zM11 7.073c-.269.165-.588.26-.93.26-.958 0-1.735-.746-1.735-1.666 0-.92.777-1.667 1.734-1.667.271 0 .528.06.756.166l.008.004c.17.07.327.182.469.324.085.083.161.174.227.272.087.124.164.26.228.401.428.948.392 2.377-.942 3.706a.446.446 0 0 1-.613.01.405.405 0 0 1-.011-.59c.42-.416.672-.831.81-1.22z"/>
	</svg>
	</button>
<script>
$(function(){
	$("#svg").click(function(){

	if($("#question").css("display") == "none"){
	    $("#question").show();
	} else {
	    $("#question").hide();
	}
		});
});

</script>
	<footer>
		<div class="text-center mt-auto bg-primary text-light clearfix d-block mx-auto">
			<p>&lt;Copyright 2020. <strong>티캣츠</strong>. All rights reserved.&gt;</p>
		</div>
	</footer>
	

</body>
</html>
