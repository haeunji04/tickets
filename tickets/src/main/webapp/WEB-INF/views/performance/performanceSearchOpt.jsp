<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- 한글 인코딩 처리  -->
<fmt:requestEncoding value="utf-8"/>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="회원가입" name="pageTitle"/>
</jsp:include>

<style>
.tab_menu_container a {
	display: inline-block;
    width: 208.9px;
    height: 70px;
    line-height: 70px;
    box-sizing: border-box;
    border-right: 1px solid #ddd;
    font-size: 16px;
    color: #333;
    text-align: center;
}

.tab_menu_container {
	width: 100%;
	margin: 0 auto 60px auto;
    border: 1px solid #ddd;
    border-right:0px none;
    box-sizing: border-box;
    font-size: 0;
}

a {
  background:none;
  border:0;
  outline:0;
  cursor:pointer;
}
.tab_menu_container {
  display:flex;
}
.tab_menu_btn {
  width:80px;
  height:40px;
  transition:0.3s all;
}
.tab_menu_btn.on {
  border-bottom:2px solid #df0000;
  font-weight:700;
  color:#df0000;
}
.tab_menu_btn:hover {
  color:#df0000;
}
.tab_box {
  display:none;
  padding:20px;
}
.tab_box.on {
  display:block;
}

#category-opt {
	background-color: #F4F4F4;
	border-top:1px solid #ddd;
	border-bottom: 2px solid gray;
}
#opt {
	background-color: #fff;
}
</style>


<div id="search-opt-container" class="mx-auto py-3">
	<h1 class="text-center py-4">지역별 공연</h1>

	<div class="tab_wrap mx-auto text-center">
		  <div class="tab_menu_container">
			    <a class="tab_menu_btn on" id="L">전체</a>
			    <a class="tab_menu_btn" id="L1">서울</a>
			    <a class="tab_menu_btn" id="L2">경기/인천</a>
			    <a class="tab_menu_btn" id="L3">대전/세종/충청/강원</a>
			    <a class="tab_menu_btn" id="L4">부산/대구/경상/울산</a>
			    <a class="tab_menu_btn" id="L5">광주/전라/제주</a>
		  </div>
		  
		  <!-- 카테고리 검색 -->
		  <div class="p-3" id="category-opt">
		  	<div class="border p-3 align-middle" id="opt">
			  	<div class="form-group mb-0">
			  		
				  	<strong>장르</strong> &nbsp;&nbsp;|&nbsp;&nbsp;
			  		
				    <div class="custom-control custom-checkbox d-inline-block mx-3">
				      	<input type="checkbox" class="custom-control-input" id="musical" value="1">
				      	<label class="custom-control-label" for="musical">뮤지컬</label>
				    </div>
					<div class="custom-control custom-checkbox d-inline-block mx-3">
						<input type="checkbox" class="custom-control-input" id="play" value="2">
						<label class="custom-control-label" for="play">연극</label>
					</div>
					<div class="custom-control custom-checkbox d-inline-block mx-3">
					  	<input type="checkbox" class="custom-control-input" id="concert" value="3">
					    <label class="custom-control-label" for="concert">콘서트</label>
					</div>
					<div class="custom-control custom-checkbox d-inline-block mx-3">
					    <input type="checkbox" class="custom-control-input" id="classic" value="4">
					    <label class="custom-control-label" for="classic">클래식</label>
					</div>
				</div>
		  	</div>
		  	<div class="">
				<button type="button" class="btn btn-primary mt-3" id="opt-btn">조회</button>
		  	</div>
		  </div>
		  
		  <h5 class="my-3 pt-2 text-muted" id="listSize">
		  		<span>- 총 <span class="text-primary">${ listSize }</span>건의 공연이 조회되었습니다. - </span>
		  </h5>
		  <div class="tab_box_container">
			    <div class="tab_box on" id="tab_content">
			    	<c:if test="${ not empty list }">
						<c:forEach items="${ list }" var="per">
				
						<div style="width: 235px" class="text-center d-inline-block p-3 my-2">
							<a href="${pageContext.request.contextPath }/performance/performanceInfoView2.do?perNo=${ per.perNo }<c:if test="${not empty loginMember }">&memberId=${loginMember.memberId}</c:if>">					
										<img
										src="<c:url value='/resources/upload/performance/${ per.perImgRenamedFileName}' />"
										style="width: 200px" class=" mb-2"/>
									</a>
							<h6>${ per.perTitle }</h6>
							<p style="font-size:13px;" class="mb-0">${ dateformat.format(per.perStartDate) } - ${ dateformat.format(per.perEndDate) }<br />${ per.theaterName }</p>
						</div>
						</c:forEach>
					</c:if>
			    
			    </div>
			    
			    <div class="tab_box" id="">서울</div>
			    
			    <div class="tab_box">경기/인천</div>
			    
			    <div class="tab_box">대전/세종/충청/강원</div>
			    
			    <div class="tab_box">부산/대구/경상/울산</div>
			    
			    <div class="tab_box">광주/전라/제주</div>
		  </div> 
	</div> 
	
	
</div>

<script>
$('.tab_menu_btn').on('click',function(){
	  //버튼 색 제거,추가
	  $('.tab_menu_btn').removeClass('on');
	  $(this).addClass('on')
	  
	  //컨텐츠 제거 후 인덱스에 맞는 컨텐츠 노출
	  //var idx = $('.tab_menu_btn').index(this);
	  
	  //$('.tab_box').hide();
	  //$('.tab_box').eq(idx).show();

	  
});

$("#L").click(function(){
	var loc = {};
	selectPerTab(loc);
});
$("#L1").click(function(){
	var loc = { locationCode : "L1" };
	selectPerTab(loc);
});
$("#L2").click(function(){
	var loc = { locationCode : "L2" };
	selectPerTab(loc);
});
$("#L3").click(function(){
	var loc = { locationCode : "L3" };
	selectPerTab(loc);
});
$("#L4").click(function(){
	var loc = { locationCode : "L4" };
	selectPerTab(loc);
});
$("#L5").click(function(){
	var loc = { locationCode : "L5" };
	selectPerTab(loc);
});

function selectPerTab(loc){
	console.log("loc = " + loc);

	var jsonStr = JSON.stringify(loc);
	console.log("jsonStr = "+jsonStr);

 	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
	}); 
	
	$.ajax({
		url: "${ pageContext.request.contextPath }/performance/location",
		data: jsonStr,
		method: "POST",
		contentType : "application/json; charset=utf-8",
		success: function(data){
			displayPerTab(data);
		},
		error: function(xhr, status, err){
			console.log("처리실패", xhr, status, err);
		}
	});
	
}

function displayPerTab(data){
	//console.log("data = " +data);
	var $container = $("#tab_content");
	

	var html = ""; 
	if(data.list.length > 0){
		for(var i in data.list){
			var per = data.list[i];

			console.log(per);
			html += "<div style='width: 235px;' class='text-center d-inline-block p-3 my-2'>";
			html += "<a href='${pageContext.request.contextPath }/performance/performanceInfoView2.do?perNo="+per.perNo+"'>";
			html += "<img src='${ pageContext.request.contextPath }/resources/upload/performance/"+per.perImgRenamedFileName+"' style='width:200px;' class='mb-2'/>";
			html += "</a>";
			html += "<h6>"+per.perTitle+"</h6>";
			html += "<p style='font-size:13px;' class='mb-0'>"+per.perStartDate+"<br />"+per.theaterName+"</p>";
			html += "</div>";
		}
	}

	$container.html(html);
	$("#listSize").html("<span>- 총 <span class='text-primary'>"+data.listSize+"</span>건의 공연이 조회되었습니다. - </span>");
			
}

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
   
