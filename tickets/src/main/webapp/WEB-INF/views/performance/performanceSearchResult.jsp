<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- 한글 인코딩 처리  -->
<fmt:requestEncoding value="utf-8"/>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle"/>
</jsp:include>

<div id="search-result-container" class="mx-auto pb-5" style="width: 85%">


	<div id="search-result-header" class="my-4 text-center" >
	
		<div class="py-3" style="font-size:40px;">
			<span style="font-size:40px;" class="text-primary">' ${keyword} ' </span>
			검색 결과
		</div>
	
		<!-- 검색 결과 여러 항목으로 나눠서 볼 거 아니면 탭형식 필요없어짐! 기능 구현하면서 고민해볼 것  -->
		<ul class="nav nav-tabs mb-5 mx-auto">
			<li class="nav-item">
				<a class="nav-link active" data-toggle="tab" href="#all">통합검색</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" data-toggle="tab" href="#performance-name">공연 검색</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" data-toggle="tab" href="#performance-hall">공연장 검색</a>
			</li>
		</ul>

		<div id="myTabContent" class="tab-content mx-5">
		
			<!-- 통합검색탭 내용 -->
			<div class="tab-pane fade active show" id="all">

				<table class="table table-hover">
				<!-- 반복될 블록(존재하는 만큼 반복) 시작 -->
				<tr>
					<th>
						<img src="${ pageContext.request.contextPath }/resources/images/poster/캣츠.jpg" alt="포스터"
							 width="150px;" class="img-thumbnail" />
					</th>
					<td class="align-middle"><h6>뮤지컬 〈캣츠〉 40주년 오리지널 내한공연</h6></td>
					<td class="align-middle">2020.11.13 <br /> - 2020.12.20</td>
					<td class="align-middle">롯데아트홀</td>
				</tr>
				<!-- 반복문 블록 끝 -->
				
				<tr>
					<th>
						<img src="${ pageContext.request.contextPath }/resources/images/poster/캣츠.jpg" alt="포스터"
							 width="150px;" class="img-thumbnail" />
					</th>
					<td class="align-middle"><h6>뮤지컬 〈캣츠〉 40주년 오리지널 내한공연</h6></td>
					<td class="align-middle">2020.11.13 <br /> - 2020.12.20</td>
					<td class="align-middle">롯데아트홀</td>
				</tr>
				
				<tr>
					<th>
						<img src="${ pageContext.request.contextPath }/resources/images/poster/캣츠.jpg" alt="포스터"
							 width="150px;" class="img-thumbnail" />
					</th>
					<td class="align-middle"><h6>뮤지컬 〈캣츠〉 40주년 오리지널 내한공연</h6></td>
					<td class="align-middle">2020.11.13 <br /> - 2020.12.20</td>
					<td class="align-middle">롯데아트홀</td>
				</tr>
				
				
				</table>
				
			</div>
			<!-- 공연탭 내용 -->
			<div class="tab-pane fade" id="performance-name">

				<table class="table table-hover">

				<tr>
					<th>
						<img src="${ pageContext.request.contextPath }/resources/images/poster/캣츠.jpg" alt="포스터"
							 width="150px;" class="img-thumbnail" />
					</th>
					<td class="align-middle"><h6>뮤지컬 〈캣츠〉 40주년 오리지널 내한공연</h6></td>
					<td class="align-middle">2020.11.13 <br /> - 2020.12.20</td>
					<td class="align-middle">롯데아트홀</td>
				</tr>

				</table>

			</div>
			
			<!-- 공연장탭 내용 -->
			<div class="tab-pane fade" id="performance-hall">

				<table class="table table-hover">

				<tr>
					<th>
						<img src="${ pageContext.request.contextPath }/resources/images/poster/캣츠.jpg" alt="포스터"
							 width="150px;" class="img-thumbnail" />
					</th>
					<td class="align-middle"><h6>뮤지컬 〈캣츠〉 40주년 오리지널 내한공연</h6></td>
					<td class="align-middle">2020.11.13 <br /> - 2020.12.20</td>
					<td class="align-middle">롯데아트홀</td>
				</tr>

				</table>

			</div>
		</div>
	
	</div>

</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
   
