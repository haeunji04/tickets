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
		top:19%; 
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
	<section id="demo">
	    <div class="vertical-align">
	        <div class="container">
	            <div class="row">
	                <div class="col-sm-6 col-sm-offset-3 col-xs-offset-0">
	                    <div class="card no-border">
	                        <div id="chat">
	                            <form action="" method="GET" class="hidden">
	                                <select data-conv-question="Hello! This is an example use of the plugin to dynamically generate questions (like using an API). This is the only question that was written on the initial HTML. To end the loop, select END." name="first-question">
	                                    <option value="understood">Understood</option>
	                                    <option value="okay">Okay, captain!</option>
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
		jQuery(function($){
			var count = 0;
			var convForm = $('#chat').convform({eventList:{onInputSubmit: function(convState, ready) {
				console.log('input is being submitted...');
				//here you send the response to your API, get the results and build the next question
				//when ready, call 'ready' callback (passed as the second parameter)
		        if(convState.current.answer.value==='end') {
		            convState.current.next = false;
					//emulating random response time (100-600ms)
					setTimeout(ready, Math.random()*500+100);
		        } else {
					if(Array.isArray(convState.current.answer)) var answer = convState.current.answer.join(', ');
					else var answer = convState.current.answer.text;
					convState.current.next = convState.newState({
						type: 'select',
						noAnswer: true,
						name: 'dynamic-question-'+count,
						questions: ['This question state was built on your previous answer (you answered: '+answer+') and doesnt expect an answer'],
					});
					convState.current.next.next = convState.newState({
						type: 'select',
						name: 'dynamic-question-'+count,
						questions: ['This question state was built on your previous answer (you answered: '+answer+')'],
						answers: [
							{text: 'Answer 1', value: '1'},
							{text: 'Answer 2', value: '2'},
							{text: 'END', value: 'end'}
						]
					});
					//emulating random response time (100-600ms)
					setTimeout(ready, Math.random()*500+100);
		        }
		        count++;
		    }}});
		});
	</script>
	
	<footer>
		<div class="text-center mt-auto bg-primary text-light clearfix d-block mx-auto">
			<p>&lt;Copyright 2020. <strong>티캣츠</strong>. All rights reserved.&gt;</p>
		</div>
	</footer>
	
</div>

</body>
</html>
