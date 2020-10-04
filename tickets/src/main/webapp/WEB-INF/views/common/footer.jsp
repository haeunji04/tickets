<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	</section>
	
	<style type="text/css"> 
		#floatdiv { 
		position:fixed; 
		text-align:center;
		width:70px; 
		display:inline-block; 
		right:50px; 
		/* 창에서 오른쪽 길이 */ 
		top:19%; 
		/* 창에서 위에서 부터의 높이 */ 
		background-color: transparent; margin:0; 
		
		} 
	</style>
	
	<c:if test="${ not empty loginMember }">	
	<div id="floatdiv">
		<p  >최근 본 공연</p>
		<hr />
		<c:forEach items="${ loginRecentList }" var="recentPer" begin="0" end= "2" step="1" varStatus="status" >
			<a href="${pageContext.request.contextPath }/performance/performanceInfoView2.do?perNo=${ recentPer.perNo }">					
						<img
						src="<c:url value='/resources/upload/performance/${ recentPer.perImgRenamedFileName}' />"
						style="width: 100px" />
			</a>	 
			
				
			<a href="">
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
			</a> 
		
		</c:forEach>	
		<p>. . .</p>
		<!-- <p>더보기</p> -->
		<a class="dropdown-item" style="text-align:center;" href="${pageContext.request.contextPath}/performance/recentlyPerList.do">더보기</a>
	</div>
	</c:if>
	
	<footer>
		<div class="text-center mt-auto bg-primary text-light clearfix d-block mx-auto">
			<p>&lt;Copyright 2020. <strong>티캣츠</strong>. All rights reserved.&gt;</p>
		</div>
	</footer>
	
</div>

</body>
</html>
