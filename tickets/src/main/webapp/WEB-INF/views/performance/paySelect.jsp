<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"  %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/jquery.seat-charts.css">
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		
	<!-- bootstrap js: jquery load 이후에 작성할것.-->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

	<!-- css 시작  -->
		<!-- journal 테마 -->
       <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css" />
	<!-- css 끝 -->

<style>
li{
	list-style:none;
	display:inline-block;
}
li span,h5{
	display:inline-block;
}
a{
	text-decoration:none
}
.table{
	width:800px;
}
::-webkit-scrollbar { 
    display: none !important; // 윈도우 크롬 등
}
</style>
</head>
<body>
	<div class="fixed-top" style="height:50px;padding:10px 50px 50px 50px;background-color:white;">
		<ul>
			<a href="#" style="color:gray;">
				<li>
					<span class="badge badge-secondary">STEP1</span>
					<h5 style="padding:5px 30px 5px 5px">좌석선택</h5>
					<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-caret-right" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
					  <path fill-rule="evenodd" d="M6 12.796L11.481 8 6 3.204v9.592zm.659.753l5.48-4.796a1 1 0 0 0 0-1.506L6.66 2.451C6.011 1.885 5 2.345 5 3.204v9.592a1 1 0 0 0 1.659.753z"/>
					</svg>
				</li>
			</a>
			<a href="#" style="color:gray;">
				<li style="padding-left:30px;">
					<span class="badge badge-secondary">STEP2</span>
					<h5 style="padding:5px 5px 5px 5px">가격/할인선택</h5>
					<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-caret-right" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
					  <path fill-rule="evenodd" d="M6 12.796L11.481 8 6 3.204v9.592zm.659.753l5.48-4.796a1 1 0 0 0 0-1.506L6.66 2.451C6.011 1.885 5 2.345 5 3.204v9.592a1 1 0 0 0 1.659.753z"/>
					</svg>
				</li>
			</a>
			<a href="#" style="color:gray;">
				<li style="padding-left:30px;">
					<span class="badge badge-primary">STEP3</span>
					<h5 style="padding:5px 30px 5px 5px">결제</h5>
				</li>
			</a>

		</ul>		
	</div>
	<div id="test" class="seatCharts-container" tabindex="0" style="margin-top:60px;margin-left:30px;">
		<h5>주문자 정보</h5>
		 <div class="table-responsive">
              <table class="table align-items-center table-flush">
                <thead class="thead-light">
                  <tr>
                    <th scope="col" class="sort" data-sort="name">이름 : ${ member.name }</th>
                    <th>연락처 :
                     <input type="text" name="tel" id="tel" class="inputType inp_txt inp_w52" maxlength="11" style="width:120px;padding:0 10px;" value="${ member.phone }">
                     </th>
                    <th>이메일:
                     <input type="text" name="email" id="email" class="inputType inp_txt inp_w150" value="${ member.email }">
                    </th>
                  </tr>
                </thead>
              </table>
            </div>
		
	</div>
    <form:form action="${pageContext.request.contextPath}/performance/payComplete.do" method="POST">
	<div id="test" class="seatCharts-container" tabindex="0" style="margin-top:60px;margin-left:30px;">
		<h5>결제수단을 선택하세요.</h5>
              <table class="table align-items-center table-flush">
                <tbody class="list">
                  <tr>
                    <th scope="row">
                      <div class="media align-items-center">
                          <div class="form-group">
						   <div class="custom-control custom-radio d-inline-block mx-3">
						     <input type="radio" id="customRadio1" name="customRadio" value="card" class="custom-control-input" checked="">
						     <label class="custom-control-label" for="customRadio1">신용카드</label>
						   </div>
						   <div class="custom-control custom-radio d-inline-block mx-3">
						     <input type="radio" id="customRadio2" name="customRadio" value="kakao" class="custom-control-input">
						     <label class="custom-control-label" for="customRadio2">카카오페이</label>
						   </div>
						   <div class="custom-control custom-radio d-inline-block mx-3">
						     <input type="radio" id="customRadio3" name="customRadio" value="naver" class="custom-control-input">
						     <label class="custom-control-label" for="customRadio3">네이버페이</label>
						   </div>
						   <div class="custom-control custom-radio d-inline-block mx-3">
						     <input type="radio" id="customRadio4" name="customRadio" value="pay" class="custom-control-input">
						     <label class="custom-control-label" for="customRadio4">무통장입금</label>
						   </div>
						  
						 </div>
                      </div>
                    </th>
                    
                  </tr>
                  
                </tbody>
              </table>
            </div>
            <div id="test" class="seatCharts-container" tabindex="0" style="margin-top:60px;margin-left:30px;">
            <h5></h5>
            	<div id="partCheckAgree" class="box_cont box_receipt">
            	<h5 class="text-left d-inline-block mb-3">예매자 동의</h5>	
					<div class="more">
						<input type="checkbox" name="allcheck" id="allcheck" onchange="checkAll();" />
						<label for="allcheck">전체선택</label>
					</div>
					<ul class="box_agree">
						
						<li class="list_agree d-block">
							<div class="tit_check">
								<input type="checkbox" id="chkAgree01" name="chkAgree" title="[필수] 예매 및 취소 수수료/ 취소기한을 확인하였으며 동의합니다.">
								<label for="chkAgree01"><span class="txt_lab">[필수] 예매 및 취소 수수료/ 취소기한을 확인하였으며 동의합니다.</span></label>
							</div>
							<div class="box_ar_info">
								<div class="tb_date">
									<table class="tbl ">
										<caption class="hide"></caption>
										<colgroup>
											<col style="width: 226px;">
											<col style="width: 326px;">
										</colgroup>
										<thead class="tb_date_th">
											<tr>
												<th class="txt_gray">취소일</th>
												<th class="txt_gray">취소수수료</th>
											</tr>
										</thead>
										<tbody id="partCancelFeeList2">
										<tr><td>2020.09.27</td><td>없음</td></tr><tr><td>2020.09.28 ~ 2020.09.29</td><td>티켓금액의 30%</td></tr></tbody>
									</table>
								</div>
							</div>
						</li>
						<li class="list_agree d-block text-left" id="agree05" style="display: none;">
					
							<div class="tit_check d-block">
								<input type="checkbox" id="chkAgree05" name="chkAgree" title="[필수] 결제대행 서비스 표준이용약관" notcontained="true">
								<label for="chkAgree05"><span class="txt_lab">[필수] 결제대행 서비스 표준이용약관</span></label>
								<a href="javascript: popupAgreementForPayMethod();" class="btn_flexible btn_flexible_ico2 btn_detail"><span>상세보기</span></a>
								<!-- 레이어 보기 임시 onclick 이벤트 개발시 삭제 -->
							</div>
							
						</li>
						<li class="list_agree d-block">
							
									<div class="tit_check d-block">
										<input type="checkbox" id="chkAgree_kakao" name="chkAgree" title="[필수] 카카오 전자금융 이용약관 동의">
										<label for="chkAgree_kakao"><span class="txt_lab">[필수] 카카오 전자금융 이용약관 동의</span></label>
										<a href="javascript: openKakaoAgree();" class="btn_flexible btn_flexible_ico2 btn_detail"><span>상세보기</span></a>
									</div>
							
						</li>
						<li class="list_agree d-block">
							
									<div class="tit_check d-block">
										<input type="checkbox" id="chkAgree04" name="chkAgree" title="[필수] 개인정보 제3자 제공 동의 및 주의사항">
										<label for="chkAgree04"><span class="txt_lab">[필수] 개인정보 제3자 제공 동의 및 주의사항</span></label>
										<a href="javascript: popupAgreement('03');" class="btn_flexible btn_flexible_ico2 btn_detail"><span>상세보기</span></a>
									</div>
							
						</li>
						<li class="list_agree agree_terms_approval d-block" style="">
							
									<div class="tit_check">
										<input type="checkbox" id="chkAgree03" name="chkAgree" title="[필수] 개인정보 수집/이용에 동의합니다.">
										<label><span class="txt_lab">[필수] 개인정보 수집/이용에 동의합니다.</span></label>
										<a href="javascript: popupAgreement('02');" class="btn_flexible btn_flexible_ico2 btn_detail"><span>상세보기</span></a>
										<!-- 레이어 보기 임시 onclick 이벤트 개발시 삭제 -->
									</div>
								
						</li>
						
						
						<li class="list_agree">
							
										<div class="tit_check">
											<input type="checkbox" id="chkAgreeChannel" name="chkAgreeChannel" title="[선택] 카카오톡 멜론티켓 채널 추가">
											<label for="chkAgreeChannel"><span class="txt_lab">[선택] 카카오톡 멜론티켓 채널 추가</span></label>
											<a href="javascript: popupAgreement('05');" class="btn_flexible btn_flexible_ico2 btn_detail"><span>상세보기</span></a>
										</div>
									
							</li>
						</ul>
				</div>
            
            </div>
		

	<div class="position-fixed text-center" style="top:60px;left:750px;width:400px;height:1000px;background-color:white;line-height:30px; ">
	<div class="show-seat h-30">
		
	</div>
	<div class="text-left" style="padding-left:50px;">
			<h5>${ performance.perTitle }</h5>
		<div class="seat-grade mx-3 mb-3 border text-left" style="margin-top:30px;">
			<ul style="padding-left:20px;">
				<li class="d-block" style="border-bottom:1px solid #eeeeee;line-height:40px;">2020.09.30</li>
				<li>
					총 ${ seatNoLength }석 선택
					<br />
					<c:forEach items="${ seatName }" var="seat">
						${ seat }<br/>
					</c:forEach>
				</li>
			</ul>
		</div>
		<div class="side-bar d-block text-left" style="padding-left:20px;">
			<h5>티켓 결제 금액</h5>
			<div class="seat-grade mb-3 border text-left" style="margin-top:30px;width:316px;">
			<table>
				<tr>
					<td style="width:120px;padding-left:20px;">티켓금액</td>
					<td style="width:180px;text-align:right;padding-right:20px;">${ originTotal }원</td>
				</tr>
				<tr>
					<td style="width:120px;padding-left:20px;">기본가</td>
					<td style="width:180px;text-align:right;padding-right:20px;">${ originTotal }원</td>
				</tr>
				<tr>
					<td style="width:120px;padding-left:20px;">가격할인</td>
					<td style="width:180px;text-align:right;padding-right:20px;">${ sale }원</td>
				</tr>
				<tr>
					<td style="width:150px;padding-left:20px;"><h5>총결제금액</h5></td>
					<td style="width:150px;text-align:right;padding-right:20px;"><h5>${ total }원</h5></td>
				</tr>
			</table>
		</div>
			
		</div>
		<div class="button" style="padding-left:20px;padding-top:30px;">
		<button type="button" class="btn btn-secondary" style="width:150px;" onclick="history.go(-1);">이전</button>
		<button type="button" class="btn btn-primary" style="width:150px;" onclick="submit();">결제하기</button>
		</div>
	</div>
	<div class="loading position-absolute" style="top:0;left:0;opacity:0.7;width:1000px;height:1000px;background-color:white;display:none;">
		<img class="position-absolute" src="${pageContext.request.contextPath }/resources/images/etc/loading.png" style="top:380px;left:300px;"/>
	</div>
	</div>
    </form:form>
	<script>
	function checkAll(){
	    var check = document.getElementsByName("chkAgree");
	    var all = document.getElementById("allcheck");
	    for(var i=0; i<check.length; i++){
	    	check[i].checked = all.checked;
	    }
	} 
	function submit(){
			$("[name=chkAgree]").each(function(){
	    	   if($("[name=chkAgree]").is(":checked") == false) {
	    	   //if($("input:checkbox[id='chkAgree03']").is(":checked") == false) {
	    		   alert("구매동의를 체크해주세요");
	    		   
	    		   return;
	    		 };
			});

		
	}
	</script>
	</script>
	

</body>
</html>