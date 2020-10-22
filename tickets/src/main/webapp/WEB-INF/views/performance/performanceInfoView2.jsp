<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"  %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- param 한글 encoding 처리 -->
<fmt:requestEncoding value="utf-8"/>
	<!-- header -->
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/calendar.css">
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/calendar.js"></script>


<style>

	.customoverlay {position:relative;bottom:85px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;}
	.customoverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
	.customoverlay a {display:block;text-decoration:none;color:#000;text-align:center;border-radius:6px;font-size:14px;font-weight:bold;overflow:hidden;background: #d95050;background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
	.customoverlay .title {display:block;text-align:center;background:#fff;margin-right:35px;padding:10px 15px;font-size:14px;font-weight:bold;}
	.customoverlay:after {content:'';position:absolute;margin-left:-12px;left:50%;bottom:-12px;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}

	.table td{
		border:0;
	}
	
	li.on button{
		color: #fff;
	    background-color: #eb6864;
	    border-color: #eb6864;
	}
</style>
<!-- 공연 시작(오픈) 날짜비교 -->
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${ now }" pattern="yyyy.MM.dd(E) HH:mm" var="nowDate" />             <%-- 오늘날짜 --%>
<fmt:formatDate value="${ performance.perStartDate }" pattern="yyyyMMdd" var="openDate"/>     <%-- 시작날짜 --%>
<fmt:formatDate value="${ performance.perEndDate }" pattern="yyyyMMdd" var="endDate"/>     <%-- 마감날짜 --%>
<fmt:formatDate value="${ performance.reservationStartDate }" pattern="yyyy.MM.dd(E) HH:mm" var="reservationStartDate" />

		<div class="border">
			<div class="table" style="padding:30px 30px 20px;">
			<div align="right">	
				<!-- 찜하기 -->
				<form:form id="wishListInsertFrm" 
					  action="${pageContext.request.contextPath }/performance/wishListInsert.do?perNo=${ performance.perNo }" 
					  method="POST">
					  
					  <%int cnt1=0; %>
					  <%int cnt2=0; %>
					  <c:set var="doneLoop" value="false" />
					  <c:forEach items="${ list }" var="wlist" varStatus="status">					  	
					  <if test="${ not doneLoop }">	
					  	<c:choose>
					  		<c:when test="${ performance.perNo ne wlist.perNo }">
					  			<%cnt1=0; %>
					  		</c:when>
					  		<c:otherwise>
					  			<% cnt2=1;%>
					  			<c:set var="doneLoop" value="true" />
					  		</c:otherwise> 	
					  	</c:choose>
					  </if>
					  </c:forEach>
					  
					  <%if(cnt1==0 && cnt2==0) {%>
					<button type="submit" class="border-0 text-primary" style="background-color:white; ">
						<svg width="3em" height="3em" viewBox="0 0 16 16" class="bi bi-bookmark-heart" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
						  <path fill-rule="evenodd" d="M2 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.777.416L8 13.101l-5.223 2.815A.5.5 0 0 1 2 15.5V2zm2-1a1 1 0 0 0-1 1v12.566l4.723-2.482a.5.5 0 0 1 .554 0L13 14.566V2a1 1 0 0 0-1-1H4z"/>
						  <path fill-rule="evenodd" d="M8 4.41c1.387-1.425 4.854 1.07 0 4.277C3.146 5.48 6.613 2.986 8 4.412z"/>
						</svg>
					</button>	
						
						
					  <%} %>
				</form:form>
				
				
				<!-- 찜 해제하기 -->
				<form:form id="wishListDeleteFrm" 
					  action="${pageContext.request.contextPath }/performance/wishListDelete.do?perNo=${ performance.perNo }" 
					  method="POST">
					  <%int cnt3=0; %>
					  <%int cnt4=0; %>
					  <c:set var="doneLoop" value="false" />
					  <c:forEach items="${ list }" var="wlist" varStatus="status">	
					  <if test="${ not doneLoop }">
					  	<c:choose>
					  		<c:when test="${ performance.perNo ne wlist.perNo }">
					  			<%cnt3=0; %>
					  		</c:when>
					  		<c:otherwise>
					  			<% cnt4=1;%>
					  			<c:set var="doneLoop" value="true" />
					  		</c:otherwise> 	
					  	</c:choose>
					  </if>
					  </c:forEach>
					  
					  <%if(cnt3==0 && cnt4==1) {%>
						<button type="submit" class="border-0 text-primary" style="background-color:white; ">
						<svg width="3em" height="3em" viewBox="0 0 16 16" class="bi bi-bookmark-heart-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
						  <path fill-rule="evenodd" d="M4 0a2 2 0 0 0-2 2v13.5a.5.5 0 0 0 .74.439L8 13.069l5.26 2.87A.5.5 0 0 0 14 15.5V2a2 2 0 0 0-2-2H4zm4 4.41c1.387-1.425 4.854 1.07 0 4.277C3.146 5.48 6.613 2.986 8 4.412z"/>
						</svg>
						</button>	
					  <%} %>			
				</form:form>		
				
			</div>

			<table id="perform-info-tbl" >
			
			<tr>
				<td rowspan=5 colspan=3>
					<img
						src="<c:url value='/resources/upload/performance/${ performance.perImgRenamedFileName}' />"
						style="width: 200px" />				
				</td>
				<td colspan=3>
					<h3>
						${ performance.perTitle }
						<c:if test="${endDate eq nowDate }">
							<span class="text-primary" style="font-size:25px">(마감일 오늘티켓 50%할인)</span>
						</c:if> 
				
					</h3>
				</td>				
				<td>
				
				</td>
			</tr>
			<tr>
				<td>공연기간</td>
				<td>${ dateformat.format(performance.perStartDate) } - ${ dateformat.format(performance.perEndDate) }</td>
				<td></td>
			</tr>
			<tr>
				<td>관람시간</td>
				<td>${ performance.perTime}분</td>
				<td></td>
			</tr>
			<tr>
				<td>관람등급</td>
				<td>${ performance.perRating == 0 ? '전체관람가' : 
					   performance.perRating == 8 ? '8세이상 관람가':
					   performance.perRating == 15 ? '15세이상관람가': '18세이상관람가' }				
				</td>
			</tr>
			<tr>
				<td>장르</td>				
				<td>${ performance.categoryCode eq 'C1' ? '뮤지컬' : 
				       performance.categoryCode eq 'C2' ? '연극' : 
				       performance.categoryCode eq 'C3' ? '콘서트' : 
					   performance.categoryCode eq 'C4' ? '클래식': '전시' }				
				</td>				
				<td></td>				
			</tr>
			</table>
			</div>	
		</div>
		
		<%-- <c:if test="${ (reservationStartDate <= nowDate) }">	 --%>	
		<c:choose>
		<c:when test="${ reservationStartDate <= nowDate && performance.categoryCode ne 'C5'}">
		
		<div class="wrap_ticketing_process border"><!-- wrap_ticketing_process 상세 예매프로세스 -->
                <div class="box_ticketing_process text-center">
                    <dl class="date_choice" style="display:inline-grid;margin:30px;">
                        <dt class="tit_process tit_date_choice text-center mx-2"><span class="img">날짜 선택</span></dt>
               				<div id="demo" class="mx-auto">
        						<div id="one"></div>
        					</div>
        			</dl>
                    <dl class="time_choice" style="display:inline-grid;margin:30px;">
                        <dt class="tit_process tit_time_choice text-center"><span class="img">시간 선택</span></dt>
                        <dd class="cont_process" id="section_time">
                            <div class="box_type_comment" style="width:240px;"><!-- 날짜 선택전 show  -->
                                <ul class="list-unstyled" id="result-list">
<!--                                 	<li id="list"><button type="button" class="btn btn-outline-primary mt-3" style="width:240px;">오후 1시 00분</button></li>
                                	<li id="list"><button type="button" class="btn btn-outline-primary mt-3" style="width:240px;">오후 4시 30분</button></li>
                                	<li id="list"><button type="button" class="btn btn-outline-primary mt-3" style="width:240px;">오후 8시 00분</button></li> -->
                                </ul>				
                            </div>
                        </dd>
                    </dl>
                    <dl class="seat_price" style="display:inline-grid;margin:30px;">
                        <dt class="tit_process tit_seat_price text-center"><span class="img">좌석등급</span></dt>
                        <dd class="cont_process" id="section_seat">
                            <div class="box_type_comment my-3 p-4 rounded" style="background-color:#F4F4F4;">
                            <table class="text-left">
                                <tr>
                                	<td></td>
                                	<td>좌석별 가격 현황</td>
                                	<td></td>
                                </tr>
                                <tr>
                                	<td></td>
                                	<td>VIP석</td>
                                	<td>160,000원</td>
                                </tr>
                                <tr>
                                	<td></td>
                                	<td>R석</td>
                                	<td>130,000원</td>
                                </tr>
                                <tr>
                                	<td></td>
                                	<td>S석</td>
                                	<td>110,000원</td>
                                </tr>
                                <tr>
                                	<td></td>
                                	<td>A석</td>
                                	<td>90,000원</td>
                                </tr>
                                <tr>
                                	<td></td>
                                	<td>B석</td>
                                	<td>60,000원</td>
                                </tr>				
                            </table>
                            </div>
                        </dd>
                    </dl>
                    
                </div>
                </c:when>
                </c:choose>
                
                <c:choose>
					<c:when test="${ reservationStartDate <= nowDate && performance.categoryCode ne 'C5'}">
						<div class="box_type_comment">
							<input type="hidden" name="categoryCode" id="categoryCode" value="${performance.categoryCode }" />
				            <button type="button" id="submit-btn" class="btn btn-primary btn-lg btn-block" onclick='nwindow();'>예매하기</button>
				        </div>
					</c:when>
			  		<c:when test="${performance.categoryCode ne 'C5' }">
			  			<h3 class="text-primary my-4" style="text-align:center;"> -${ reservationStartDate }부터 티켓 오픈!-</h3>
					</c:when> 	
				</c:choose>
                <%-- </c:if> --%>
                <c:if test="${performance.categoryCode eq 'C5'}">
                <c:choose>
					<c:when test="${ reservationStartDate <= nowDate }">
						<div class="box_type_comment">
						<form:form action="${pageContext.request.contextPath }/performance/salePerformance.do" method="GET">
							<input type='hidden' name='perNo' value='${performance.perNo}'/>
							<input type='hidden' name='memberId' value='${loginMember.memberId}'/>
							<input type="hidden" name="categoryCode" id="categoryCode" value="${performance.categoryCode }" />
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				            <button type="submit" id="submit-btn" class="btn btn-primary btn-lg btn-block">예매하기</button>
						</form:form>
				        </div>
					</c:when>
			  		<c:otherwise>
			  		<div>
					  	<h3 class="text-primary my-4" style="text-align:center;"> -${ reservationStartDate }부터 티켓 오픈!-</h3>
			  		</div>
					</c:otherwise> 	
				</c:choose>	
                
                </c:if>
               <!-- <div class="box_type_comment">
               <button type="button" class="btn btn-primary btn-lg btn-block" onclick='nwindow();'>예매하기</button>
               </div> -->
              
              
    <div class="d-block mx-auto mt-5">
	<ul class="nav nav-tabs justify-content-center" id="tabMenu">
	  <li class="nav-item">
	    <a class="nav-link active" data-toggle="tab" href="#info"><h5 class="m-10 px-4">상세정보</h5></a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link" data-toggle="tab" href="#before"><h5 class="m-10 px-4">기대평&nbsp;<span class="badge badge-primary badge-pill text-center align-top">${ commntListSize  }</span></h5></a>
	  </li>
	  <c:if test="${ reservationStartDate <= nowDate }">
	  <li class="nav-item">
		  <a class="nav-link link" data-toggle="tab" href="#after"><h5 class="m-10 px-4">관람후기&nbsp;<span class="badge badge-primary badge-pill text-center align-top">${ reviewList.size() }</span></h5></a>
	  </li>
	  </c:if>
	  <li class="nav-item">
	    <a class="nav-link link" data-toggle="tab" href="#theater" id="theater-tab"><h5 class="m-10 px-4">공연장정보</h5></a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link link" data-toggle="tab" href="#reserv"><h5 class="m-10 px-4">예매안내</h5></a>
	  </li>
	</ul>
	</div>
	<div id="myTabContent" class="tab-content d-block mx-auto mt-5 mb-5">
	  <div class="tab-pane fade active show text-left pl-5 my-5 pt-4" id="info">
		  <h4 class="my-3 pt-4">공연시간</h4>
		  <pre>${ performance.perContent }</pre>
		  
		 <img src="<c:url value='/resources/upload/performance/${ performance.detailImgRenamedFileName}' />"
		 	  class="mt-3" />
		  
	  </div>
	  <div class="tab-pane fade" id="before">
		  <div class="comment-editor" style="margin-left:170px;padding-left:30px;">
					<div class="form-group bmd-form-group">
					<div>
			       <!-- 기대평 -->
					<form:form action="${pageContext.request.contextPath }/boardComment/boardCommentInsert.do"
			    		  method="post"
			    		  name="boardCommentFrm">
			    		  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<table>
						<tr>
							<td>
							<img src="${pageContext.request.contextPath }/resources/images/etc/free-icon-user-edit.png" style="width:64px;display:inline-block;" />
							</td>
							<td>
			     				<input type="hidden" name="perNo" 
							   	       value="${ performance.perNo} " /> <!--댓글란: performance의  per_no  -->
						  	    <input type="hidden" name="boardCommentWriter" 
							   		   value="${ loginMember.memberId ne null ? loginMember.memberId : " " }" />
							    <input type="hidden" name="boardCommentLevel" value="1" /> <!--댓글란: 댓글이니까 1  -->
								  <!-- 대댓글인 경우, 참조하는 댓글번호 -->			      		 
								<input type="hidden" name="boardCommentRef" value="0" />		<!--댓글란: 대댓글없으니까 0  -->	
							 	<textarea class="form-control ml-3" name="boardCommentContent" id="boardCommentContent"
										  cols="80" rows="3"
										  placeholder="기대평을 적어주세요." onclick="test();"></textarea>
								
							</td>
							<td>
							<!-- <button type="submit" style="height:50px; margin:12px 10px 12px 30px" class="comment-btn btn btn-primary btn-lg">등록</button> -->
							<input type="submit" style="height:40px;" id="submit-btn" class="comment-btn btn btn-primary mx-4 rounded-pill" value="등록"/>
							
							</td>
						</tr>
					</table>
					</form:form>	
					</div>
					<div class="mt-3" >
					<table id="comment-tbl" class="text-center">
						<c:if test="${ commentList ne null && not empty commentList }">
						<c:forEach items="${ commentList }" var="comment">
						<c:choose>
						<c:when test="${ comment.boardCommentLevel eq '1'}">						
						<tr id="comment-tr">
							<td id="img" class="px-3" valign="bottom">
								<img src="${pageContext.request.contextPath }/resources/images/etc/free-icon-user-1.png" style="width:54px;display:inline-block;" />
							</td>
							<td id="user-id" class="pr-5" valign="bottom">
								<p class="text-secondary">${ comment.boardCommentWriter }</p>
							</td>	
							<td>
							</td>			
							<td id="user-comment" class="pr-3 text-left" valign="bottom">
								<p class="text-secondary">${ comment.boardCommentContent } (${ comment.boardCommentDate })</p>
							</td>
							<td valign="middle">
								<%-- <c:if test="${ loginMember ne null &&
											  (loginMember.memberId eq performance.memberId ||
											   loginMember.memberRole eq 'A')  }">
										
									<button type="button" class="btn btn-outline-primary btn-sm" id="btn-reply"
											value="${ comment.boardCommentNo }">답글</button>								
								</c:if>	 --%>						
								<c:if test="${ loginMember ne null &&
											  (loginMember.memberId eq comment.boardCommentWriter ||
											   loginMember.memberRole eq 'A')  }">	
									<%-- <button  class="btn btn-outline-primary btn-sm" id ="btn-delete"
											value="${ comment.boardCommentNo }">삭제</button>	 --%>							
									<button type="button" class="btn btn-outline-primary btn-sm"
											onclick="boardCommentDelete('${ comment.boardCommentNo }')">삭제</button> 								
								</c:if>	
								<!-- padding-left:100px;	 -->					
							</td>		
						</tr>						
						</c:when>
						
						<c:otherwise>
							<td id="user-id" class="px-3">
								<p class="text-secondary">${ comment.boardCommentWriter }</p>
							</td>	
							<td>
							</td>			
							<td id="user-comment" class="px-3">
								<p class="text-secondary">${ comment.boardCommentContent } (${ comment.boardCommentDate })</p>
							</td>
							<td>											
								<c:if test="${ loginMember ne null &&
											  (loginMember.memberId eq comment.boardCommentWriter ||
											   loginMember.memberRole eq 'A')  }">	
									<button type="button" class="btn btn-outline-primary btn-sm"
											onclick="perUpdate('${ per.perNo }')">삭제</button>								
								</c:if>	
								<!-- padding-left:100px;	 -->					
							</td>	
						</c:otherwise>
						
						</c:choose>
						</c:forEach>
						</c:if>						
					</table>
					</div>
					</div>
					
			</div>
	  </div>
	  <div class="tab-pane fade" id="after">
	     <div class="comment-editor"  style="margin-left:170px;padding-left:30px;">
					<div class="form-group bmd-form-group mx-auto">
					<table>
						<form:form action="${pageContext.request.contextPath }/review/insertReview.do"
								   method="POST">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<input type="hidden" name="perNo" id="perNo" value="${ performance.perNo }" />
							<input type="hidden" name="memberId" id="memberId" value="${ loginMember.memberId }" />
							<tr>
								<td>
									<img src="${pageContext.request.contextPath }/resources/images/etc/free-icon-user-edit.png" style="width:64px;display:inline-block;" />
								</td>
								<td>
								 	<textarea class="form-control ml-3" name="reviewCommentContent" id="reviewCommentContent"
											  cols="80" rows="3"
											  placeholder="관람 후기를 적어주세요." onclick="validate();"></textarea>
								</td>
								<td>
								<button type="submit" style="height:40px;" id="submit-btn"
										class="comment-btn btn btn-primary mx-4 rounded-pill">등록</button>
								</td>
							</tr>
					</form:form>
					</table>
					<div class="mt-3">
					<table id="comment-tbl" class="text-center">
						<c:forEach items="${ reviewList }" var="review">
							<tr id="comment-tr">
								<td id="img" class="px-3" valign="bottom">
									<img src="${pageContext.request.contextPath }/resources/images/etc/free-icon-user-1.png" style="width:54px;display:inline-block;" />
								</td>
								<td id="user-id" class="pr-5" valign="bottom">
									<p class="text-secondary">${ review.memberId }</p>
								</td>	
								<td>
								</td>				
								<td id="user-comment" class="pr-3 text-left" valign="bottom">
									<div>
										<p class="text-secondary">${ review.reviewCommentContent } (${ review.reviewCommentDate })</p>
									</div>
									<div>
									</div>
								</td>
								
								<c:if test="${ review.memberId eq loginMember.memberId }">
								<td id="hidden-btn" align="right">
									 <form:form action="${ pageContext.request.contextPath }/review/deleteReview.do"
									 			method="POST">
									 	<input type="hidden" name="perNo" value=${ review.perNo } />
									 	<input type="hidden" name="reviewCommentNo" value=${ review.reviewCommentNo } />
										<button class="btn btn-sm btn-outline-primary btn-delete"
												type="submit">삭제</button>
									 </form:form>
								</td> 
								</c:if>
								<!-- 버튼 보여주기 -->
								
							</tr>
						</c:forEach>
					</table>
					</div>
					</div>
					
			</div>
			<form:form name="deleteCommentFrm">
				<input type="hidden" name="boardCommentNo" value=""/>
				<input type="hidden" name="perNo" value="${ performance.perNo }"/>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			</form:form>
	  </div>
	  
	  <div class="tab-pane fade" id="theater">
		  <h3 class="text-center">
			  <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-geo-alt mb-1" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
				  <path fill-rule="evenodd" d="M12.166 8.94C12.696 7.867 13 6.862 13 6A5 5 0 0 0 3 6c0 .862.305 1.867.834 2.94.524 1.062 1.234 2.12 1.96 3.07A31.481 31.481 0 0 0 8 14.58l.208-.22a31.493 31.493 0 0 0 1.998-2.35c.726-.95 1.436-2.008 1.96-3.07zM8 16s6-5.686 6-10A6 6 0 0 0 2 6c0 4.314 6 10 6 10z"/>
				  <path fill-rule="evenodd" d="M8 8a2 2 0 1 0 0-4 2 2 0 0 0 0 4zm0 1a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
			  </svg>
		  	  ${ performance.theaterName }
		  </h3>
	  	 <div class="mb-5">
		  	 <p class="text-center">
		  	 	${ performance.theaterLocation }
		  	 	${ performance.theaterCity }
		  	 	${ performance.theaterAddress }
		  	 	${ performance.theaterName }
		  	 </p>
	  	 </div>
		 <hr />
	     <div id="map" style="width:100%;height:500px;">
	     
	     </div>
	  </div>
	  <div class="tab-pane fade" id="reserv">
	     <pre>
	   		 <h5 class="ml-5 pl-5">티켓 수령 방법 안내</h5>

			현장수령
			- 예매번호가 포함되어 있는 예매확인서와 예매자의 실물 신분증(복사본 및 사진 불가) 을 매표소에 제출하시면 편리하게 티켓을 수령하실 수 있습니다.
			※ 공연별 정책이 상이하니 자세한 내용은 예매페이지 내 상세정보 확인 부탁드립니다.
			배송
			- 배송을 선택하신 경우 예매완료(결제익일) 기준 4~5일 이내에 예매 시 입력하신 주소로 배송됩니다. (주말/공휴일 제외한 영업일 기준)
			- 일괄배송의 경우 공연 별로 배송일자가 상이하며 지정된 배송일자 기준으로 배송이 시작됩니다. (지정된 배송일자는 상세정보 및 예매공지사항에서 확인할 수 있습니다.)
			- 지역 및 배송서비스 사정에 따라 배송사가 변경될 수 있으며, 배송일이 추가적으로 소요될 수 있습니다. (CJ대한통운, 우체국 외 1개 업체)
			취소/환불 안내
			
			- 취소마감시간 이후 또는 관람일 당일 예매하신 건에 대해서는 취소/변경/환불이 불가합니다.
			- 예매수수료는 예매 당일 밤 12시 이전까지 취소 시 환불 가능합니다.
			- 배송이 시작된 경우 취소마감시간 이전까지 멜론티켓 고객센터로 티켓을 반환해주셔야 환불이 가능하며, 도착한 일자 기준으로 취소수수료가 부과됩니다.
			(* 단, 반환된 티켓의 배송료는 환불되지 않으며 일괄배송 상품의 경우 취소에 대한 자세한 문의는 고객센터로 문의해 주시기 바랍니다.)
			- 예매취소 시점과 결제 시 사용하신 신용카드사의 환불 처리기준에 따라 취소금액의 환급방법과 환급일은 다소 차이가 있을 수 있습니다.
			- 티켓 부분 취소 시 신용카드 할부 결제는 티켓 예매 시점으로 적용됩니다. (무이자할부 행사기간이 지날 경우 혜택 받지 못하실 수 있으니 유의하시기 바랍니다. )
			- 취소일자에 따라 아래와 같이 취소수수료가 부과됩니다.
			(예매 후 7일 이내라도 취소시점이 관람일로부터 10일 이내라면 관람일 기준의 취소수수료가 부과됩니다.)
	     </pre>
	  </div>
	</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f6d8fdaa58f0a1c4fb7cfa958eddc3fe&libraries=services"></script>
<script>

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	  mapOption = { 
	        //center: new kakao.maps.LatLng(37.582742149145645, 127.00359456560295), // 지도의 중심좌표
	        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 4 // 지도의 확대 레벨
	    };
	
	var map = new kakao.maps.Map(mapContainer, mapOption); //지도생성
	
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();

	var coords = null;
	// 주소로 좌표를 검색합니다
	geocoder.addressSearch('${ performance.theaterAddress }', function(result, status) {

	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {

	        coords = new kakao.maps.LatLng(result[0].y, result[0].x);

	    	var imageSrc = '${pageContext.request.contextPath}/resources/images/marker_red.png', // 마커이미지의 주소입니다    
		    imageSize = new kakao.maps.Size(64, 69), // 마커이미지의 크기입니다
		    imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

			var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
		    
	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new kakao.maps.Marker({
	            map: map,
	            position: coords,
	            image: markerImage
	        });

	        // 인포윈도우로 장소에 대한 설명을 표시합니다
/* 	        var infowindow = new kakao.maps.InfoWindow({
	            content: '<div style="width:150px;text-align:center;padding:6px 0;">우리회사</div>'
	        });
	        infowindow.open(map, marker); */

	    	// 마커가 지도 위에 표시되도록 설정합니다
	    	marker.setMap(map);
	        
	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
			map.setCenter(coords);
			
	    	// 커스텀 오버레이에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
	    	var content = '<div class="customoverlay">' +
	    	    '  <a href="https://map.kakao.com/link/search/'+ "${ performance.theaterName }" +'" target="_blank">' +
	    	    '    <span class="title">${ performance.theaterName }</span>' +
	    	    '  </a>' +
	    	    '</div>';
	    	
	    	// 커스텀 오버레이가 표시될 위치입니다 
	    	//var position = new kakao.maps.LatLng(37.582742149145645, 127.00359456560295);  
	    	
	    	// 커스텀 오버레이를 생성합니다
	    	var customOverlay = new kakao.maps.CustomOverlay({
	    	    map: map,
	    	    position: coords,
	    	    content: content,
	    	    yAnchor: 1

	    	});

	        map.setCenter(coords);

	     } 
	});    

$("#theater-tab").click(function(){
	setTimeout(function(){

	map.relayout();
	map.setCenter(coords);

	}, 0);

});


			

</script>


<form:form action="${ pageContext.request.contextPath }/boardComment/boardCommentDelete.do?perNo=${ performance.perNo}" 
	  id="boardCommentDeleteFrm" 
	  method="POST">
	<input type="hidden" name="boardCommentNo" />
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form:form>

<script>
/**
 * POST 요청 처리할 것
 **/
function boardCommentDelete(boardCommentNo){
	if(confirm("정말 삭제하시겠습니까?") == false)
		return;
	var $frm = $("#boardCommentDeleteFrm");
	$frm.find("[name=boardCommentNo]").val(boardCommentNo);
	$frm.submit();
	
}

</script>

<script>

$(function(){
	
	/* $("#btn-delete").click(function(){
		if(!confirm('댓글을 정말 삭제하시겠습니까?')) return;
		
		//삭제:post 방식 요청
		//삭제할 번호 가져오기
		let boardCommentNo = $(this).val();
		//alert(boardCommentNo);
		
		let $frm = $("[name=deleteCommentFrm]");
		$frm.children("[name=boardCommentNo]").val(boardCommentNo);
		$frm.attr('action', '${pageContext.request.contextPath }/boardComment/boardCommentDelete.do')
			.attr('method','POST')
			.submit();		
		
	}); */
	
	//댓글달라고 빈 댓글란 클릭하는순간 로그인 여부 확인용. 딜리버리에서는 loginAlert()이거를 로그인창으로 이동하는거로 바꿔야 할듯
	
		
		//댓글 검사
		let $boardContent = $("#boardCommentContent");
		if(!/^.{1,}$/.test($boardContent.val())){
			alert("댓글 내용을 작성해 주세요.");
			return false;
		}
		
		
	});
	
	$("#btn-reply").click(function(){
			let $tr = $("<tr></tr>");
			let $td = $("<td style='display:none; text-align:left;' colspan=2></td>");
			let $frm = $("<form:form action='${pageContext.request.contextPath }/boardComment/boardCommentInsert.do' method='POST'></form:form>");
			$frm.append("<input type='hidden' name='perNo' value='${performance.perNo}' />");
			<%-- $frm.append("<input type='hidden' name='boardCommentWriter' value='<%= memberLoggedIn != null ? memberLoggedIn.getMemberId() : "" %>' />"); --%>
			$frm.append("<input type='hidden' name='boardCommentWriter' value='${ loginMember ne null ? loginMember.memberId : "" }' />");
			$frm.append("<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}' />");
			$frm.append("<input type='hidden' name='boardCommentLevel' value='2' />");
			$frm.append("<input type='hidden' name='boardCommentRef' value='"+$(this).val()+"' />");
			$frm.append("<textarea name='boardCommentContent' cols=60 rows=1></textarea>");
			$frm.append("<button type='submit' class='btn-insert2'>등록</button>");
			
			$td.append($frm);
			$tr.append($td);
			let $boardCommentTr = $(this).parent().parent();
			$tr.insertAfter($boardCommentTr)
			   .children("td").slideDown(800)
			   .children("form").submit(function(){
				   let $textarea = $(this).find("textarea");
				   if($textarea.val().length == 0)
					   return false;
			   })
			   .children("textarea").focus();
		/* if(${loginMember} == null)
			loginAlert();
		else {
		} */
		
		//1회만 작동하도록 함.
		$(this).off("click");
	});
	
});

</script>

<script>
function test(){
	<c:if test="${ empty memberId }">
		loginAlert();
	</c:if>
}
function loginAlert(){
	alert("로그인 후 이용하실 수 있습니다.");
	$("#boardCommentContent").attr("readonly","true");
	return;
}

$(function(){
$("#submit-btn").click(function(){
	//로그인 여부 검사
	<c:if test="${ empty memberId }">
		loginAlert();
		return false;	
	</c:if>		
	});
});


function validate(){
	
	let perNo = $("#perNo").val();
	let memberId = $("#memberId").val();
	console.log("perNo="+perNo+", memberId="+memberId);

	let searchInfo = {
				perNo : perNo,
				memberId : memberId
			};

	let jsonStr = JSON.stringify(searchInfo);
	
	$(document).ajaxSend(function(e, xhr, options) {
		xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
		});
	
 	$.ajax({
		url: "${ pageContext.request.contextPath }/review/searchReservationMember.do",
		data: jsonStr,
		method: "POST",
		contentType: "application/json; charset=utf-8",
		success: function(data){
			//console.log(data);
			if(data == ""){
				alert("공연을 관람하신 분만 작성하실 수 있습니다.");
				$("#reviewCommentContent").attr("readonly", "true");
			}
		},
		error: function(xhr, status, err){
			console.log("처리실패", xhr, status, err);
			alert("공연을 관람하신 분만 작성하실 수 있습니다.");
			$("#reviewCommentContent").attr("readonly", "true");
			
		}
	}); 
	
}

</script>

<form:form action="" method="post" id="selectDateFrm">
<input type="hidden" name="perNo" value="${ performance.perNo }"/>
<input type="hidden" name="inputDate" id="inputDate"/>
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form:form>

<script>
        var now = new Date();
        var year = now.getFullYear();
        var month = now.getMonth() + 1;
        var date = now.getDate();

        var data = [{
            date: year + '/' + month + '/' + date,
            value: 'today'
        }];
        // inline
        var $ca = $('#one').calendar({
            // view: 'month',
            width: 320,
            height: 320, 
            // startWeek: 0,
            // selectedRang: [new Date(), null],
            data: data,
            //monthArray: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
            date: new Date(),
            onSelected: function (view, date, data) {
                console.log('view:' + view);
                //alert('date:' + date);
                document.getElementById("inputDate").value = date;
                console.log(date);
                //console.log('data:' + (data));

				selectDate();
            },
            
            viewChange: function (view, y, m) {
                console.log(view, y, m);

            }
        });


        function selectDate(){

    		var $frm = $("#selectDateFrm");

			var perNo = $frm.find("[name=perNo]").val();
    		
    		var select = {
				date : $frm.find("[name=inputDate]").val(),
				perNo : perNo
    	    };

			console.log("select : "+select);

			var jsonStr = JSON.stringify(select);
			console.log("jsonStr = "+jsonStr);

			$(document).ajaxSend(function(e, xhr, options) {
				xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
				});
			
				$.ajax({
					url : "${ pageContext.request.contextPath }/performance/selectDate",
					data : jsonStr,
					method : "POST",
					contentType : "application/json; charset=utf-8",
					success : function(data){
						displayResultTable(data);
					},
					error : function(xhr, status, err){
						console.log("처리실패", xhr, status, err);
					},
					complete : function(){
						
					}
				});


			function displayResultTable(data){
				var $container = $("#result-list");
				var html = "";
	
				if(data.length > 0){
					for(var i in data){
						var sch = data[i];
						html += "<li name='list'><button type='button' id='schedule-btn' class='btn btn-outline-primary mt-3' style='width:240px;'>";
						html += sch.hour + "시 ";
						html += sch.min + "분";
						html += "</button>"
						html += "<form action='${pageContext.request.contextPath}/performance/selectSeat.do' method='GET' name='selectSeat' target='selectSeat'>"
						html +="<input type='hidden' name='schNo' value="+sch.schNo+" />";
						html +="<input type='hidden' name='perNo' value='${performance.perNo}'/>";
						html +="<input type='hidden' name='memberId' value='${loginMember.memberId}'/>";
						html += "</form></li>";
					}
				}
				else{
					html += "";
				}
	
				$container.html(html);
				$('[name=list]').click(function(){
					$('[name=list]').removeClass();
					$(this).addClass('on');	
				});
			
					
			}

			
        }

        </script>
      <script>
		 function nwindow(){
			 
			var $li = $('.on');
			var $frm = $li.find('form');
			var name = $frm[0].getAttribute('name');
			var caCode = $("#categoryCode").val();
			console.log(caCode);

			 var url="${pageContext.request.contextPath}/performance/selectSeat.do";

		    window.open(url,name,"width=1200,height=600,left=50,top=50");
		    $frm.submit();
		}

	 </script>
	 
	<!-- footer -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
