<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- param 한글 encoding 처리 -->
<fmt:requestEncoding value="utf-8"/>
	<!-- header -->
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<link href="${pageContext.request.contextPath }/resources/css/jsRapCalendar.css" rel="stylesheet" type="text/css">

	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath }/resources/js/jsRapCalendar.js"></script>
	
<script>
$(document).ready(function(){
$('#demo').jsRapCalendar({
  week:6,
	onClick:function(y,m,d){
		alert(y + '-' + m + '-' + d);
	}
});

});
$(function(){
	$('li').click(function(){
		$('li').removeClass();
		$(this).addClass('on');	
	});
});
</script>
<style>
.table td{
	border:0;
}
li.on button{
	color: #fff;
    background-color: #eb6864;
    border-color: #eb6864;
}

.customoverlay {position:relative;bottom:85px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;}
.customoverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
.customoverlay a {display:block;text-decoration:none;color:#000;text-align:center;border-radius:6px;font-size:14px;font-weight:bold;overflow:hidden;background: #d95050;background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
.customoverlay .title {display:block;text-align:center;background:#fff;margin-right:35px;padding:10px 15px;font-size:14px;font-weight:bold;}
.customoverlay:after {content:'';position:absolute;margin-left:-12px;left:50%;bottom:-12px;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
</style>

		<div class="border">
			<div class="table" style="padding:30px 30px 20px;">
			<div align="right">	
				<!-- 찜하기 -->
				<form id="wishListInsertFrm" 
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
						<input type="submit" class="btn btn-primary" value="찜하기"/>	
					  <%} %>
				</form>
				
				<!-- 찜 해제하기 -->
				<form id="wishListInsertFrm" 
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
						<input type="submit" class="btn btn-primary" value="찜 해제하기"/>	
					  <%} %>			
				</form>		
				
			</div>
			<table id="perform-info-tbl" >
			
			<tr>
				<td rowspan=5 colspan=3>
					<img
						src="<c:url value='/resources/upload/performance/${ performance.perImgRenamedFileName}' />"
						style="width: 200px" />				
				</td>
				<td colspan=3><h3>${ performance.perTitle } </h3></td>
				
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
		<div class="wrap_ticketing_process border"><!-- wrap_ticketing_process 상세 예매프로세스 -->
                <div class="box_ticketing_process text-center">
                    <dl class="date_choice" style="display:inline-grid;margin:30px;">
                        <dt class="tit_process tit_date_choice text-center"><span class="img">날짜 선택</span></dt>
                        <dd class="cont_process">
               				<div id="demo" class="d-inline"></div>
        				</dd>
        			</dl>
                    <dl class="time_choice" style="display:inline-grid;margin:30px;">
                        <dt class="tit_process tit_time_choice text-center"><span class="img">시간 선택</span></dt>
                        <dd class="cont_process" id="section_time">
                            <div class="box_type_comment"><!-- 날짜 선택전 show  -->
                                <ul class="list-unstyled">
                                	<li><button type="button" class="btn btn-outline-primary mt-3" style="width:240px;">오후 1시 00분</button></li>
                                	<li><button type="button" class="btn btn-outline-primary mt-3" style="width:240px;">오후 4시 30분</button></li>
                                	<li><button type="button" class="btn btn-outline-primary mt-3" style="width:240px;">오후 8시 00분</button></li>
                                </ul>				
                            </div>
                        </dd>
                    </dl>
                    <dl class="seat_price" style="display:inline-grid;margin:30px;">
                        <dt class="tit_process tit_seat_price text-center"><span class="img">좌석등급</span></dt>
                        <dd class="cont_process" id="section_seat">
                            <div class="box_type_comment">
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
               <div class="box_type_comment">
               <button type="button" class="btn btn-primary btn-lg btn-block">예매하기</button>
               </div>
              </div>
              <div class="d-block mx-auto mt-5">
	<ul class="nav nav-tabs justify-content-center">
	  <li class="nav-item">
	    <a class="nav-link active" data-toggle="tab" href="#info"><h5 class="m-10 px-4">상세정보</h5></a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link" data-toggle="tab" href="#before"><h5 class="m-10 px-4">기대평<span class="badge badge-primary badge-pill">${ commntListSize  }</span></h5></a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link link" data-toggle="tab" href="#after"><h5 class="m-10 px-4">관람후기<span class="badge badge-primary badge-pill">1</span></h5></a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link link" data-toggle="tab" href="#theater"><h5 class="m-10 px-4">공연장정보</h5></a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link link" data-toggle="tab" href="#reserv"><h5 class="m-10 px-4">예매안내</h5></a>
	  </li>
	</ul>
	</div>
	<div id="myTabContent" class="tab-content d-block mx-auto mt-5 mb-5 ">
	  <div class="tab-pane fade active show text-left" id="info">
		  <h5>공연시간</h5>
		  <pre>
		  	2020년 9월 9일(수) ~ 11월 8일(일)
			평일 오후 8시 / 주말 및 공휴일 오후 2시, 7시 / 월 공연 없음
			* 추석연휴 : 9/30(수), 10/2(금), 10/3(토) 2시,7시 2회 공연 / 10/4(일) 3시 1회 공연 
			*10/1(목) 공연 없음
			* 마티네 : 10/7(수), 10/14(수), 10/21(수) 3시 1회 공연 
			*10/9(금) 한글날 2시/7시 2회 공연
		  </pre>
		  
		 <img src="<c:url value='/resources/upload/performance/${ performance.detailImgRenamedFileName}' />"/>
		  
	  </div>
	  <div class="tab-pane fade" id="before">
		  <div class="comment-editor" style="margin-left:30px;padding-left:30px;">
					<div class="form-group bmd-form-group">
					<div>
			       <!-- 기대평 -->
					<form action="${pageContext.request.contextPath }/boardComment/boardCommentInsert.do"
			    		  method="post"
			    		  name="boardCommentFrm">
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
										  placeholder="기대평을 적어주세요."></textarea>
								
							</td>
							<td>
							<!-- <button type="submit" style="height:50px; margin:12px 10px 12px 30px" class="comment-btn btn btn-primary btn-lg">등록</button> -->
							<input type="submit" style="height:50px; margin:12px 10px 12px 30px" class="btn btn-primary" value="등록"/>
							</td>
						</tr>
					</table>
					</form>	
					</div>
					<div class="mt-3">
					<table id="comment-tbl" class="text-center">
						<c:if test="${ commentList ne null && not empty commentList }">
						<c:forEach items="${ commentList }" var="comment">
						<c:choose>
						
						<c:when test="${ comment.boardCommentLevel eq '1'}">						
						<tr id="comment-tr">
							<td id="img" class="px-3">
							<img src="${pageContext.request.contextPath }/resources/images/etc/free-icon-user-1.png" style="width:55px;display:inline-block;" />
							</td>
							<td id="user-id" class="px-3">
								<%-- <sub class="text-secondary" style="font-size:10px">
									(${ comment.boardCommentDate })
								</sub> --%>
								<p class="text-secondary">${ comment.boardCommentWriter }</p>
							</td>	
							<td>
							</td>			
							<td id="user-comment" class="px-3">
								<p class="text-secondary">${ comment.boardCommentContent } 
									<span class="text-secondary" style="font-size:10px">(${ comment.boardCommentDate })</span>
								</p>
							</td>
							<td>
								<c:if test="${ loginMember ne null &&
											  (loginMember.memberId eq performance.memberId ||
											   loginMember.memberRole eq 'A')  }">
											   
								<!-- 답글시도중 -->
								   <button id="btn-reply" class="btn btn-outline-primary btn-sm"
										   value="${ comment.boardCommentNo }">답글</button>
										   
									<%-- <button type="button" class="btn btn-outline-primary btn-sm"
											onclick="boardCommentReply('${ comment.boardCommentNo }')">답글</button>	 --%>
									<%-- <button type="button" class="btn btn-outline-primary btn-sm" id="btn-reply"
											value="${ comment.boardCommentNo }">답글</button> --%>
									<!-- <input type="button" 
										   class="btn btn-outline-primary btn-sm"
										   id="btn-reply" 
										   value="추가"/> -->
								   
								
								</c:if>							
								<c:if test="${ loginMember ne null &&
											  (loginMember.memberId eq comment.boardCommentWriter ||
											   loginMember.memberRole eq 'A')  }">	
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
											onclick="boardCommentDelete('${ comment.boardCommentNo }')">삭제</button>								
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
	     <div class="comment-editor" style="margin-left:30px;padding-left:30px;">
					<div class="form-group bmd-form-group">
					<table>
						<tr>
							<td>
							<img src="${pageContext.request.contextPath }/resources/images/etc/girl.png" style="width:64px;height:70px;display:inline-block;" />
							</td>
							<td>
				 			<textarea class="form-control ml-3" name="afterComment" id="afterComment"
							 	  cols="80" rows="3"
							 	  placeholder="감상평을 적어주세요." onclick="alert('구매자만 입력할 수 있습니다.');"></textarea>
							
							</td>
							<td>
							<button type="submit" style="height:50px; margin:12px 10px 12px 30px" class="comment-btn btn btn-primary btn-lg">등록</button>
							</td>
						</tr>
					</table>
					<div class="mt-3">
					<table id="comment-tbl" class="text-center">
						<tr id="comment-tr">
							<td id="img" class="px-3">
							<img src="${pageContext.request.contextPath }/resources/images/etc/boy.png" style="width:64px;height:70px;display:inline-block;" />
							</td>
							<td id="user-id" class="px-3">
								<p class="text-secondary">honggd</p>
							</td>	
							<td>
							</td>			
							<td id="user-comment" class="px-3">
								<p class="text-secondary">완전 재밌습니다.</p>
							</td>
							
							<!-- <td id="hidden-btn">
								<button class="btn btn-info btn-update"
										value="">수정</button>
								<button class="btn btn-info btn-delete"
										value="">삭제</button>				
							</td> -->
							<!-- 버튼 보여주기 -->
							
						</tr>
					</table>
					</div>
					</div>
					
			</div>
			<form name="deleteCommentFrm">
			<input type="hidden" name="boardCommentNo" value=""/>
			<input type="hidden" name="perNo" value="${ performance.perNo }"/>
		</form>
	  </div>
	  <div class="tab-pane fade" id="theater">
	     <div id="map" style="width:100%;height:500px;">
	     
	     </div>
	  </div>
	  <div class="tab-pane fade" id="reserv">
	     <pre>
	   		 <h5>티켓 수령 방법 안내</h5>

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

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f6d8fdaa58f0a1c4fb7cfa958eddc3fe"></script>
<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	  mapOption = { 
	        center: new kakao.maps.LatLng(37.58753968425043, 126.99147438862954), // 지도의 중심좌표
	        level: 4 // 지도의 확대 레벨
	    };
	
	var map = new kakao.maps.Map(mapContainer, mapOption);
	
	var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png', // 마커이미지의 주소입니다    
	    imageSize = new kakao.maps.Size(64, 69), // 마커이미지의 크기입니다
	    imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
	
	// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
	    markerPosition = new kakao.maps.LatLng(37.582742149145645, 127.00359456560295); // 마커가 표시될 위치입니다
	
	// 마커를 생성합니다
	var marker = new kakao.maps.Marker({
	  position: markerPosition,
	  image: markerImage // 마커이미지 설정 
	});
	
	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map);  
	
	// 커스텀 오버레이에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
	var content = '<div class="customoverlay">' +
	    '  <a href="https://map.kakao.com/link/map/17358384" target="_blank">' +
	    '    <span class="title">대학로자유극장</span>' +
	    '  </a>' +
	    '</div>';
	
	// 커스텀 오버레이가 표시될 위치입니다 
	var position = new kakao.maps.LatLng(37.582742149145645, 127.00359456560295);  
	
	// 커스텀 오버레이를 생성합니다
	var customOverlay = new kakao.maps.CustomOverlay({
	    map: map,
	    position: position,
	    content: content,
	    yAnchor: 1 
	});
</script>

<form action="${ pageContext.request.contextPath }/boardComment/boardCommentDelete.do?perNo=${ performance.perNo}" 
	  id="boardCommentDeleteFrm" 
	  method="POST">
	<input type="hidden" name="boardCommentNo" />
</form>

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

<%-- <script>
function boardCommentReply(boardCommentNo){
	if(confirm("답글을 다시겠습니까?") == false)
		return;
	if(${loginMember} == null)
		loginAlert();
	else {
		let $tr = $("<tr></tr>");
		let $td = $("<td style='display:none; text-align:left;' colspan=2></td>");
		let $frm = $("<form action='${pageContext.request.contextPath }/boardComment/boardCommentInsert.do' method='POST'></form>");
		$frm.append("<input type='hidden' name='perNo' value='${performance.perNo}' />");
		$frm.append("<input type='hidden' name='boardCommentWriter' value='<%= memberLoggedIn != null ? memberLoggedIn.getMemberId() : "" %>' />");
		$frm.append("<input type='hidden' name='boardCommentWriter' value='${ loginMember ne null ? loginMember.memberId : "" }' />");
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
		   }
	}
	
	//1회만 작동하도록 함.
	$(this).off("click");
</script> --%>

<!-- 답글시도중 -->
<script>
$(function(){
	
	
	//댓글달라고 빈 댓글란 클릭하는순간 로그인 여부 확인용. 
	$("#boardCommentContent").click(function(){
		if(${loginMember} == null)
			loginAlert();
	});
	
	$("[name=boardCommentFrm]").submit(function(){
		
		//로그인 여부 검사
		if(${loginMember} == null){
			loginAlert();
			return false;			
		}
		
		//댓글 검사
		let $boardContent = $("#boardCommentContent");
		if(!/^.{1,}$/.test($boardContent.val())){
			alert("댓글 내용을 작성해 주세요.");
			return false;
		}
		
		
	});
	
	$("#btn-reply").click(function(){
		if(${loginMember} == null)
			loginAlert();
		else {
			let $tr = $("<tr></tr>");
			let $td = $("<td style='display:none; text-align:left;' colspan=2></td>");
			let $frm = $("<form action='${pageContext.request.contextPath }/boardComment/boardCommentInsert.do' method='POST'></form>");
			$frm.append("<input type='hidden' name='perNo' value='${performance.perNo}' />");			
			$frm.append("<input type='hidden' name='boardCommentWriter' value='${ loginMember ne null ? loginMember.memberId : "" }' />");
			$frm.append("<input type='hidden' name='boardCommentLevel' value='2' />");
			$frm.append("<input type='hidden' name='boardCommentRef' value='"+$(this).val()+"' />");
			$frm.append("<textarea name='boardCommentContent' cols=60 rows=1></textarea>");
			$frm.append("<input type='submit' style='height:50px; margin:12px 10px 12px 30px' class='btn btn-primary' value='등록'/>");
			
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
		}
		
		//1회만 작동하도록 함.
		$(this).off("click");
	});
	
});

function loginAlert(){
	alert("로그인 후 이용하실 수 있습니다.");
	return;
}
</script>
	 
	 
	<!-- footer -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
