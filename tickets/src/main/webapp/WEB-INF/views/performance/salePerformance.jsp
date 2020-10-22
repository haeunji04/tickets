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
		<c:if test="${ categoryCode ne 'C5'}">
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
					<span class="badge badge-primary">STEP2</span>
					<h5 style="padding:5px 30px 5px 5px">가격/할인선택</h5>
					<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-caret-right" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
					  <path fill-rule="evenodd" d="M6 12.796L11.481 8 6 3.204v9.592zm.659.753l5.48-4.796a1 1 0 0 0 0-1.506L6.66 2.451C6.011 1.885 5 2.345 5 3.204v9.592a1 1 0 0 0 1.659.753z"/>
					</svg>
				</li>
			</a>
			<a href="#" style="color:gray;">
				<li style="padding-left:30px;">
					<span class="badge badge-secondary">STEP3</span>
					<h5 style="padding:5px 5px 5px 5px">결제</h5>
				</li>
			</a>

		</ul>
		</c:if>		
		<c:if test="${ categoryCode eq 'C5'}">
		<ul>
			<a href="#" style="color:gray;">
				<li style="padding-left:30px;">
					<span class="badge badge-primary">STEP1</span>
					<h5 style="padding:5px 30px 5px 5px">가격/할인선택</h5>
					<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-caret-right" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
					  <path fill-rule="evenodd" d="M6 12.796L11.481 8 6 3.204v9.592zm.659.753l5.48-4.796a1 1 0 0 0 0-1.506L6.66 2.451C6.011 1.885 5 2.345 5 3.204v9.592a1 1 0 0 0 1.659.753z"/>
					</svg>
				</li>
			</a>
			<a href="#" style="color:gray;">
				<li style="padding-left:30px;">
					<span class="badge badge-secondary">STEP2</span>
					<h5 style="padding:5px 5px 5px 5px">결제</h5>
				</li>
			</a>

		</ul>
		</c:if>		
	</div>
	<div id="test" class="seatCharts-container" tabindex="0" style="margin-top:60px;margin-left:30px;">
		<h5>가격을 선택하세요.</h5>
		<c:if test="${ categoryCode ne 'C5'}">
		 <div class="table-responsive">
              <table class="table align-items-center table-flush">
                <thead class="thead-light">
                  <tr>
                    <th scope="col" class="sort" data-sort="name">좌석</th>
                    <th></th>
                    <th></th>
                  </tr>
                </thead>
                <tbody class="list">
                  <tr>
                    <th scope="row">
                      <div class="media align-items-center">
                       
                        <div class="media-body">
                          <span class="name mb-0 text-sm">기본가</span>
                        </div>
                      </div>
                    </th>
                    <td class="budget">
                    </td>
                    <td>
                      <div class="form-group" style="width:100px;height:20px;">
					    <select class="custom-select">
					      <option selected="">0</option>
					    <c:forEach begin="1" end="${seatNoLength }" step="1" var="i">
					      <option value="0">${i}</option>
					      </c:forEach>
					    </select>
					  </div>
                    </td>
                   
                   
                  </tr>
                  <tr>
                    <th scope="row">
                      <div class="media align-items-center">
                        <div class="media-body">
                          <span class="name mb-0 text-sm">국가유공자(본인만)</span>
                        </div>
                      </div>
                    </th>
                    <td class="budget">
                      	할인 10000원
                    </td>
                     <td>
                      <div class="form-group" style="width:100px;height:20px;">
					    <select class="custom-select">
					      <option selected="">0</option>
					    <c:forEach begin="1" end="${seatNoLength }" step="1" var="i">
					      <option value="10000">${i}</option>
					      </c:forEach>
					    </select>
					  </div>
                    </td>
                   
                  
                  </tr>
                  <tr>
                    <th scope="row">
                      <div class="media align-items-center">
                        <div class="media-body">
                          <span class="name mb-0 text-sm">재관람할인</span>
                        </div>
                      </div>
                    </th>
                    <td class="budget">
                      	할인 3000원
                    </td>
                     <td>
                      <div class="form-group" style="width:100px;height:20px;">
					    <select class="custom-select">
					      <option selected="">0</option>
					    <c:forEach begin="1" end="${seatNoLength }" step="1" var="i">
					      <option value="3000">${i}</option>
					      </c:forEach>
					    </select>
					  </div>
                    </td>
                   
                  </tr>
                  <tr>
                    <th scope="row">
                      <div class="media align-items-center">
                        <div class="media-body">
                          <span class="name mb-0 text-sm">50플러스할인(1971년이전출생자)</span>
                        </div>
                      </div>
                    </th>
                    <td class="budget">
                      	할인 5000원
                    </td>
                     <td>
                      <div class="form-group" style="width:100px;height:20px;">
					    <select class="custom-select">
					      <option selected="">0</option>
					    <c:forEach begin="1" end="${seatNoLength }" step="1" var="i">
					      <option value="5000">${i}</option>
					      </c:forEach>
					    </select>
					  </div>
                    </td>
                    
                  </tr>
                  <tr>
                    <th scope="row">
                      <div class="media align-items-center">
                        <div class="media-body">
                          <span class="name mb-0 text-sm">장애인할인</span>
                        </div>
                      </div>
                    </th>
                    <td class="budget">
                      	할인 5000원
                    </td>
                     <td>
                      <div class="form-group" style="width:100px;height:20px;">
					    <select class="custom-select">
					      <option selected="0">0</option>
					    <c:forEach begin="1" end="${seatNoLength }" step="1" var="i">
					      <option value="5000">${i}</option>
					      </c:forEach>
					    </select>
					  </div>
                    </td>
                   
                  </tr>
                </tbody>
              </table>
            </div>
            </c:if>
		<c:if test="${ categoryCode eq 'C5'}">
		 <div class="table-responsive">
              <table class="table align-items-center table-flush">
                
                <tbody class="list">
                  <tr>
                    <th scope="row">
                      <div class="media align-items-center">
                       
                        <div class="media-body">
                          <span class="name mb-0 text-sm">성인(20세이상)</span>
                        </div>
                      </div>
                    </th>
                    <td></td>
                    <td></td>
                   </tr>
                   <tr>
                   <th scope="row">
                      <div class="media align-items-center">
                       
                        <div class="media-body">
                          <span class="name mb-0 text-sm">기본가</span>
                        </div>
                      </div>
                    </th>
                    <td class="budget">
                    ${ performance.price }
                    </td>
                    <td>
                      <div class="form-group" style="width:100px;height:20px;">
					    <select class="custom-select">
					      <option selected="">0</option>
					    <c:forEach begin="1" end="10" step="1" var="i">
					      <option value="0">${i}</option>
					      </c:forEach>
					    </select>
					  </div>
                    </td>
                   
                   
                  </tr>
                  <tr>
                    <th scope="row">
                      <div class="media align-items-center">
                       
                        <div class="media-body">
                          <span class="name mb-0 text-sm">청소년(14세~19세)</span>
                        </div>
                      </div>
                    </th>
                    <td></td>
                    <td></td>
                   </tr>
                   <tr>
                   <th scope="row">
                      <div class="media align-items-center">
                       
                        <div class="media-body">
                          <span class="name mb-0 text-sm">기본가</span>
                        </div>
                      </div>
                    </th>
                    <td class="budget">
                      	 ${ performance.price - 2000 }
                    </td>
                     <td>
                      <div class="form-group" style="width:100px;height:20px;">
					    <select class="custom-select">
					      <option selected="">0</option>
					    <c:forEach begin="1" end="10" step="1" var="i">
					      <option value="2000">${i}</option>
					      </c:forEach>
					    </select>
					  </div>
                    </td>
                  </tr>
                  <tr>
                    <th scope="row">
                      <div class="media align-items-center">
                       
                        <div class="media-body">
                          <span class="name mb-0 text-sm">어린이(4세~13세)</span>
                        </div>
                      </div>
                    </th>
                    <td></td>
                    <td></td>
                   </tr>
                   <tr>
                   <th scope="row">
                      <div class="media align-items-center">
                       
                        <div class="media-body">
                          <span class="name mb-0 text-sm">기본가</span>
                        </div>
                      </div>
                    </th>
                    <td class="budget">
                      	${ performance.price - 4000 }
                    </td>
                     <td>
                      <div class="form-group" style="width:100px;height:20px;">
					    <select class="custom-select">
					      <option selected="">0</option>
					    <c:forEach begin="1" end="10" step="1" var="i">
					      <option value="4000">${i}</option>
					      </c:forEach>
					    </select>
					  </div>
                    </td>
                   
                  </tr>
                </tbody>
              </table>
            </div>
            </c:if>
		
	</div>
		

	<div class="position-fixed text-center" style="top:60px;left:750px;width:400px;height:1000px;background-color:white;line-height:30px; ">
	<div class="show-seat h-30">
		
	</div>
	<div class="text-left" style="padding-left:50px;">
			<h5>${ performance.perTitle }</h5>
		<div class="seat-grade mx-3 mb-3 border text-left" style="margin-top:30px;">
			<ul style="padding-left:20px;">
				<li class="d-block" style="border-bottom:1px solid #eeeeee;line-height:40px;">2020.10.24</li>
				<c:if test="${ categoryCode ne 'C5'}">
				<li>
					총 ${seatNoLength }석 선택
					<br />
					<c:forEach items="${ seatName }" var="seat">
						${ seat }<br/>
					</c:forEach>
				</li>
				</c:if>
				<c:if test="${ categoryCode eq 'C5'}">
				<li>
					비지정석
					<br/>
				</li>
				</c:if>
			</ul>
		</div>
		<div class="side-bar d-block text-left" style="padding-left:20px;">
			<h5>티켓 결제 금액</h5>
			<div class="seat-grade mb-3 border text-left" style="margin-top:30px;width:316px;">
			<table>
			<c:if test="${ categoryCode ne 'C5'}">
				<tr>
					<td style="width:120px;padding-left:20px;">티켓금액</td>
					<td style="width:180px;text-align:right;padding-right:20px;">${ total }원</td>
				</tr>
				<tr>
					<td style="width:120px;padding-left:20px;">가격할인</td>
					<td style="width:180px;text-align:right;padding-right:20px;"><span id="sale">0</span>원</td>
				</tr>
				<tr>
					<td style="width:150px;padding-left:20px;"><h5>총결제금액</h5></td>
					<td style="width:150px;text-align:right;padding-right:20px;">
						<h5 id="order">${ total }</h5><h5>원</h5>
					</td>
				</tr>
				</c:if>
				<c:if test="${ categoryCode eq 'C5'}">
				<tr>
					<td style="width:120px;padding-left:20px;">티켓금액</td>
					<td style="width:180px;text-align:right;padding-right:20px;"><span id="total">0</span>원</td>
				</tr>
				<tr>
					<td style="width:150px;padding-left:20px;"><h5>총결제금액</h5></td>
					<td style="width:150px;text-align:right;padding-right:20px;">
						<h5 id="order"></h5><h5>원</h5>
					</td>
				</tr>
				</c:if>
			</table>
		</div>
			
		</div>
		<div class="button" style="padding-left:20px;padding-top:30px;">
		<c:if test="${ categoryCode ne 'C5'}">
		<form:form action="${pageContext.request.contextPath}/performance/paySelect.do" method="POST">
		<input type="hidden" name="memberId" value="${ memberId }" />
		<input type="hidden" name="originTotal" value="${ total }"/>
		<input type="hidden" name="schNo" value="${ schNo }" />
		<input type="hidden" name="sale" value=""/>
		<input type="hidden" name="total" value="" />
		<c:forEach items="${ seatName }" var="seatName">
		<input type="hidden" name="seatName" value="${ seatName }" />
		</c:forEach>
		<c:forEach items="${ seatNo }" var="seatNo">
		<input type="hidden" name="seatNo" value="${ seatNo }" />
		</c:forEach>
		<button type="button" class="btn btn-secondary" style="width:150px;" onclick="history.go(-1);">이전</button>
		<button type="submit" class="btn btn-primary" style="width:150px;">다음</button>
		</form:form>
		</c:if>
		<c:if test="${ categoryCode eq 'C5'}">
		<form:form action="${pageContext.request.contextPath}/performance/paySelect.do" method="GET">
		<input type="hidden" name="memberId" value="${ memberId }" />
		<input type="hidden" name="total" value="" />
		<input type="hidden" name="perNo" value="${ perNo }" />
		<input type="hidden" name="categoryCode" value="${ categoryCode }" />
		<input type="hidden" name="count" value="" />
		<button type="button" class="btn btn-secondary" style="width:150px;" onclick="history.go(-1);">이전</button>
		<button type="submit" class="btn btn-primary" style="width:150px;">다음</button>
		</form:form>
		</c:if>
		</div>
	</div>
	<div class="loading position-absolute" style="top:0;left:0;opacity:0.7;width:1000px;height:1000px;background-color:white;display:none;">
		<img class="position-absolute" src="${pageContext.request.contextPath }/resources/images/etc/loading.png" style="top:380px;left:300px;"/>
	</div>
	</div>
	<script>
	$(function(){
	var number = 0;
	var sale = 0;
	var total = 0;
	var count = 0;
	$(".custom-select").change(function() {
		<c:if test="${ categoryCode ne 'C5' }">
			sale += Number($(this).val())* Number($(this).children("option:selected").text());
			number += Number($(this).children("option:selected").text());
			if(number > ${seatNoLength }){
					number -=Number($(this).children("option:selected").text());
					sale -= Number($(this).val())*Number($(this).children("option:selected").text());
					alert('매수를 초과하였습니다.');
					$(this).children("option:selected").text(0);
				}
			$('#sale').text(sale);
			$('#order').text(${ total }-sale);
			$('[name=total]').val(${ total }-sale);
			$('[name=sale]').val(sale);
		</c:if>
		<c:if test="${ categoryCode eq 'C5' }">
			total += Number($(this).parent().parent().parent().find(".budget").text())* Number($(this).children("option:selected").text());
			count += Number($(this).children("option:selected").text());
			$('#total').text(total);
			$('#order').text(total);
			$('[name=total]').val(total);
			$('[name=count]').val(count);
		</c:if>
		});
	});
	</script>
	

</body>
</html>