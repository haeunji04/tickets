<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"  %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- 한글 인코딩 처리 --%>
<fmt:requestEncoding value="utf-8"/>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <link href="${pageContext.request.contextPath }/resources/css/master.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath }/resources/js/Chart.min.css" rel="stylesheet">
<style>
	.card{
		background-color:#fff;
		border:1px solid rgba(0,0,0,.125);
	}
	.col-sm-6{
		padding: 10px;
	}
	.col-md-6{
		display:inline-block;
	}
</style>
    <div class="wrapper">
        <div id="body" class="active">
            <div class="content">
                <div class="container-fluid">
                    <div class="row" style="padding-left:470px;height:80px;">
                        <h2>판매자 매출현황</h2>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="card" style="width:500px;">
                                <div class="content">
                                    <div class="head">
                                        <h4 class="mb-0">월별매출</h4>
                                        <p class="text-muted">월단위 판매량</p>
                                    </div>
                                    <div class="canvas-wrapper">
                                        <canvas class="chart" id="trafficflow"></canvas>
                                    </div>
                                    <div class="ui hidden divider"></div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card" style="width:500px;">
                                <div class="content">
                                    <div class="head">
                                        <h4 class="mb-0">일일매출</h4>
                                        <p class="text-muted">일단위 판매량</p>
                                    </div>
                                    <div class="canvas-wrapper">
                                        <canvas class="chart" id="sales"></canvas>
                                    </div>
                                    <div class="ui hidden divider"></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="card">
                                <div class="content">
                                    <div class="head">
                                        <h4 class="mb-0">월별 공연 순위</h4>
                                        <p class="text-muted">Your year long sales data</p>
                                    </div>
                                    <div class="canvas-wrapper">
                                        <table class="table no-margin bg-lighter-grey">
                                            <thead class="success">
                                                <tr>
                                                    <th>Performance</th>
                                                    <th class="text-right">Sales</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>
                                                    <a href="#">
                                                    <i class="flag-icon flag-icon-us"></i> United States
                                                    </a>
                                                    </td>
                                                    <td class="text-right">27,340</td>
                                                </tr>
                                                <tr>
                                                    <td><i class="flag-icon flag-icon-in"></i> India</td>
                                                    <td class="text-right">21,280</td>
                                                </tr>
                                                <tr>
                                                    <td><i class="flag-icon flag-icon-jp"></i> Japan</td>
                                                    <td class="text-right">18,210</td>
                                                </tr>
                                                <tr>
                                                    <td><i class="flag-icon flag-icon-gb"></i> United Kingdom</td>
                                                    <td class="text-right">15,176</td>
                                                </tr>
                                                <tr>
                                                    <td><i class="flag-icon flag-icon-es"></i> Spain</td>
                                                    <td class="text-right">14,276</td>
                                                </tr>
                                                <tr>
                                                    <td><i class="flag-icon flag-icon-de"></i> Germany</td>
                                                    <td class="text-right">13,176</td>
                                                </tr>
                                                <tr>
                                                    <td><i class="flag-icon flag-icon-br"></i> Brazil</td>
                                                    <td class="text-right">12,176</td>
                                                </tr>
                                                <tr>
                                                    <td><i class="flag-icon flag-icon-id"></i> Indonesia</td>
                                                    <td class="text-right">11,886</td>
                                                </tr>
                                                <tr>
                                                    <td><i class="flag-icon flag-icon-ph"></i> Philippines</td>
                                                    <td class="text-right">11,509</td>
                                                </tr>
                                                <tr>
                                                    <td><i class="flag-icon flag-icon-sg"></i> Singapore</td>
                                                    <td class="text-right">1,700</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card">
                                <div class="content">
                                    <div class="head">
                                        <h4 class="mb-0">일별 공연 순위</h4>
                                        <p class="text-muted">Your year long sales data</p>
                                    </div>
                                    <div class="canvas-wrapper">
                                        <table class="table no-margin bg-lighter-grey">
                                            <thead class="success">
                                                <tr>
                                                    <th>Performance</th>
                                                    <th class="text-right">Sales</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td><i class="flag-icon flag-icon-us"></i> United States</td>
                                                    <td class="text-right">7,200</td>
                                                </tr>
                                                <tr>
                                                    <td><i class="flag-icon flag-icon-in"></i> India</td>
                                                    <td class="text-right">6,190</td>
                                                </tr>
                                                <tr>
                                                    <td><i class="flag-icon flag-icon-jp"></i> Japan</td>
                                                    <td class="text-right">4,790</td>
                                                </tr>
                                                <tr>
                                                    <td><i class="flag-icon flag-icon-gb"></i> United Kingdom</td>
                                                    <td class="text-right">4,480</td>
                                                </tr>
                                                <tr>
                                                    <td><i class="flag-icon flag-icon-es"></i> Spain</td>
                                                    <td class="text-right">4,276</td>
                                                </tr>
                                                <tr>
                                                    <td><i class="flag-icon flag-icon-de"></i> Germany</td>
                                                    <td class="text-right">3,455</td>
                                                </tr>
                                                <tr>
                                                    <td><i class="flag-icon flag-icon-br"></i> Brazil</td>
                                                    <td class="text-right">3,201</td>
                                                </tr>
                                                <tr>
                                                    <td><i class="flag-icon flag-icon-id"></i> Indonesia</td>
                                                    <td class="text-right">1,996</td>
                                                </tr>
                                                <tr>
                                                    <td><i class="flag-icon flag-icon-ph"></i> Philippines</td>
                                                    <td class="text-right">1,809</td>
                                                </tr>
                                                <tr>
                                                    <td><i class="flag-icon flag-icon-sg"></i> Singapore</td>
                                                    <td class="text-right">1,550</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                       
                    </div>
                    
                    <div class="row">
                        <div class="col-sm-6 col-md-6 col-lg-3">
                            <div class="card">
                                <div class="content">
                                    <div class="row">
                                        <div class="dfd text-center">
                                            <i class="blue large-icon mb-2 fas fa-thumbs-up"></i>
                                            <h4 class="mb-0">+21,90000</h4>
                                            <p class="text-muted">월 판매액</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-md-6 col-lg-3">
                            <div class="card">
                                <div class="content">
                                    <div class="row">
                                        <div class="dfd text-center">
                                            <i class="orange large-icon mb-2 fas fa-reply-all"></i>
                                            <h4 class="mb-0">+22,56600</h4>
                                            <p class="text-muted">일판매액</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-md-6 col-lg-3">
                            <div class="card">
                                <div class="content">
                                    <div class="row">
                                        <div class="dfd text-center">
                                            <i class="grey large-icon mb-2 fas fa-envelope"></i>
                                            <h4 class="mb-0">+15,56600000</h4>
                                            <p class="text-muted">총 판매액</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-md-6 col-lg-3">
                            <div class="card">
                                <div class="content">
                                    <div class="row">
                                        <div class="dfd text-center">
                                            <i class="olive large-icon mb-2 fas fa-dollar-sign"></i>
                                            <h4 class="mb-0">+98,6010</h4>
                                            <p class="text-muted">총 판매량</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath }/resources/js/Chart.min.js"></script>
	<script>
	
	var trafficchart = document.getElementById("trafficflow");
	var saleschart = document.getElementById("sales");

	var myChart1 = new Chart(trafficchart, {
	    type: 'line',
	    data: {
	            labels: ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'],
	            datasets: [{
	                backgroundColor: "rgba(48, 164, 255, 0.5)",
	                borderColor: "rgba(48, 164, 255, 0.8)",
	                data: ['1135', '1135', '1140','1168', '1150', '1145','1155', '1155', '1150','1160', '1185', '1190'],
	                label: '',
	                fill: true
	            }]
	    },
	    options: {
	        responsive: true,
	        title: {display: false,text: 'Chart'},
	        legend: {position: 'top',display: false,},
	        tooltips: {mode: 'index',intersect: false,},
	        hover: {mode: 'nearest',intersect: true},
	        scales: {
	            xAxes: [{
	                display: true,
	                scaleLabel: {
	                    display: true,
	                    labelString: 'Months'
	                }
	            }],
	            yAxes: [{
	                display: true,
	                scaleLabel: {
	                    display: true,
	                    labelString: 'Number of Sales'
	                }
	            }]
	        }
	    }
	});

	var myChart2 = new Chart(saleschart, {
	    type: 'bar',
	    data: {
	        labels: ['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31'],
	        datasets: [{
	            label: 'Income',
	            backgroundColor: "rgba(76, 175, 80, 0.5)",
	            borderColor: "#6da252",
	            borderWidth: 1,
	            data: ["280","300","400","600","450","400","500","550","450","650","950","1000","280","300","400","600","450","400","500","550","450","650","950","1000","600","450","400","500","550","450","650"],
	        }]
	    },
	    options: {
	        responsive: true,
	        title: {display: false,text: 'Chart'},
	        legend: {position: 'top',display: false,},
	        tooltips: {mode: 'index',intersect: false,},
	        hover: {mode: 'nearest',intersect: true},
	        scales: {
	            xAxes: [{
	                display: true,
	                scaleLabel: {
	                    display: true,
	                    labelString: 'Days'
	                }
	            }],
	            yAxes: [{
	                display: true,
	                scaleLabel: {
	                    display: true,
	                    labelString: 'Number of Sales'
	                }
	            }]
	        }
	    }
	});
	</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>