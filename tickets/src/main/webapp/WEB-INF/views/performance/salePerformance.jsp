<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	</div>
	<div id="test" class="seatCharts-container" tabindex="0" style="margin-top:60px;margin-left:30px;">
		<h5>가격을 선택하세요.</h5>
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
                      160,000원
                    </td>
                    <td>
                      <div class="form-group" style="width:100px;height:20px;">
					    <select class="custom-select">
					      <option selected="">0</option>
					      <option value="1">1</option>
					      <option value="2">2</option>
					      <option value="3">3</option>
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
                      150,000원
                    </td>
                     <td>
                      <div class="form-group" style="width:100px;height:20px;">
					    <select class="custom-select">
					      <option selected="">0</option>
					      <option value="1">1</option>
					      <option value="2">2</option>
					      <option value="3">3</option>
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
                      140,000원
                    </td>
                     <td>
                      <div class="form-group" style="width:100px;height:20px;">
					    <select class="custom-select">
					      <option selected="">0</option>
					      <option value="1">1</option>
					      <option value="2">2</option>
					      <option value="3">3</option>
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
                      130,000원
                    </td>
                     <td>
                      <div class="form-group" style="width:100px;height:20px;">
					    <select class="custom-select">
					      <option selected="">0</option>
					      <option value="1">1</option>
					      <option value="2">2</option>
					      <option value="3">3</option>
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
                      120,000원
                    </td>
                     <td>
                      <div class="form-group" style="width:100px;height:20px;">
					    <select class="custom-select">
					      <option selected="">0</option>
					      <option value="1">1</option>
					      <option value="2">2</option>
					      <option value="3">3</option>
					    </select>
					  </div>
                    </td>
                   
                  </tr>
                </tbody>
              </table>
            </div>
		
	</div>
		

	<div class="position-fixed text-center" style="top:60px;left:750px;width:400px;height:1000px;background-color:white;line-height:30px; ">
	<div class="show-seat h-30">
		
	</div>
	<div class="text-left" style="padding-left:50px;">
			<h5>캣츠<40주년> 내한공연</h5>
		<div class="seat-grade mx-3 mb-3 border text-left" style="margin-top:30px;">
			<ul style="padding-left:20px;">
				<li class="d-block" style="border-bottom:1px solid #eeeeee;line-height:40px;">2020.09.30</li>
				<li>
					총 N석 선택
					<br />
					R석 1층 3열 15번
				</li>
			</ul>
		</div>
		<div class="side-bar d-block text-left" style="padding-left:20px;">
			<h5>티켓 결제 금액</h5>
			<div class="seat-grade mb-3 border text-left" style="margin-top:30px;width:316px;">
			<table>
				<tr>
					<td style="width:120px;padding-left:20px;">티켓금액</td>
					<td style="width:180px;text-align:right;padding-right:20px;">0원</td>
				</tr>
				<tr>
					<td style="width:120px;padding-left:20px;">기본가</td>
					<td style="width:180px;text-align:right;padding-right:20px;">0원</td>
				</tr>
				<tr>
					<td style="width:120px;padding-left:20px;">가격할인</td>
					<td style="width:180px;text-align:right;padding-right:20px;">0원</td>
				</tr>
				<tr>
					<td style="width:120px;padding-left:20px;">쿠폰할인</td>
					<td style="width:180px;text-align:right;padding-right:20px;">0원</td>
				</tr>
				<tr>
					<td style="width:150px;padding-left:20px;"><h5>총결제금액</h5></td>
					<td style="width:150px;text-align:right;padding-right:20px;"><h5>0원</h5></td>
				</tr>
			</table>
		</div>
			
		</div>
		<div class="button" style="padding-left:20px;padding-top:30px;">
		<button type="button" class="btn btn-secondary" style="width:150px;" onclick="history.go(-1);">이전</button>
		<button type="button" class="btn btn-primary" style="width:150px;" onclick="location.href='${pageContext.request.contextPath}/performance/paySelect.do'">다음</button>
		</div>
	</div>
	<div class="loading position-absolute" style="top:0;left:0;opacity:0.7;width:1000px;height:1000px;background-color:white;display:none;">
		<img class="position-absolute" src="${pageContext.request.contextPath }/resources/images/etc/loading.png" style="top:380px;left:300px;"/>
	</div>
	</div>
	<script>
		
	</script>
	

</body>
</html>