<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>현황분석 페이지</title>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<!-- CSS -->
<link href="/resources/css1/styles.css" rel="stylesheet" />
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />
<link href="/resources/css/_bootswatch.scss" rel="stylesheet">
<link href="/resources/css/_variables.scss" rel="stylesheet">

<!-- JAVSCRIPT, JQUERY -->
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/js/all.min.js" crossorigin="anonymous"></script>

<!-- Chart.js 사용(라인, 바, 플롯, 레이더 등 사용) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.min.js"></script>
</head>
<form>
	<body class="sb-nav-fixed">
		<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
			<a class="navbar-brand" href="/">XML Statics</a>
			<button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle" href="#">
				<i class="fas fa-bars"></i>
			</button>
			<!-- 홈버튼-->
			<div style="margin-left: 1600px">
				<ul class="navbar-nav ml-auto ml-md-0">
					<li class="nav-item dropdown"><a class="nav-link" id="userDropdown" href="/" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-home"></i></a></li>
				</ul>
			</div>
		</nav>
		<div id="layoutSidenav">
			<div id="layoutSidenav_nav">
				<nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
					<div class="sb-sidenav-menu">
						<div class="nav">
							<div class="sb-sidenav-menu-heading" style="color: #fff">MainPage</div>
							<a class="nav-link" href="/">
								<div class="sb-nav-link-icon">
									<i class="far fa-sticky-note"></i>
								</div> 논문보기
							</a>
							<div class="sb-sidenav-menu-heading" style="color: #fff">Statics</div>
							<a style="font-weight: bold; color: #fff" class="nav-link" href="/stat/year">
								<div class="sb-nav-link-icon">
									<i class="fas fa-chart-bar"></i>
								</div> 연도별 현황
							</a> <a class="nav-link" href="/stat/orgn">
								<div class="sb-nav-link-icon">
									<i class="fa fa-table"></i>
								</div> 소속기관별 현황
							</a>
							<!-- 추가 -->
							<a class="nav-link" href="/stat/orgn2">
								<div class="sb-nav-link-icon">
									<i class="fa fa-table"></i>
								</div> 소속기관별 현황(test)
							</a> <a class="nav-link" href="/stat/ctgr">
								<div class="sb-nav-link-icon">
									<i class="fas fa-chart-area"></i>
								</div> 분야별 현황
							</a> <a class="nav-link" href="/stat/kwrd">
								<div class="sb-nav-link-icon">
									<i class="fa fa-cloud"></i>
								</div> 키워드 현황
							</a>
						</div>
					</div>
					<div class="sb-sidenav-footer">
						<div class="small">Made with by NJH&SMJ</div>
						<a href="https://github.com/ghghtygh/vinea_xml.git" style="font-size: 12px" target="_blank"> <i class="fab fa-github"></i> View Source <i class="fab fa-github"></i> => Click
						</a>
					</div>
				</nav>
			</div>
			<div id="layoutSidenav_content">
				<main>
					<div class="container-fluid">
						<div style="margin-top: 45px"></div>
						<!--  연도별 통계: 테이블, 차트 -->
						<div class="row">
							<div class="col-sm-10">
								<p style="font-size: 25px; font-weight: bold; color: #000069">연도별 데이터 통계</p>
							</div>
							<div class="col-sm-2">
								<!-- 수정 SelectBox(연도 선택) -->
								<p style="font-size: 15px; font-weight: bold">
									논문 발행연도
									<select class="form-control" id="yearOption">
										<option value="0">전체</option>
										<option value="1">2013</option>
										<option value="2">2014</option>
										<option value="3">2015</option>
										<option value="4">2016</option>
										<option value="5">2017</option>
									</select>
								</p>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
								<table id="table1" style="text-align: center;" class="table table-hover">
									<tbody>
										<th style="border-top: 2px solid #000069">구분</th>
										<c:choose>
											<c:when test="${not empty yearVOList}">
												<c:forEach items="${yearVOList}" var="vo" varStatus="g">
													<!-- 구분: 발행연도 -->
													<th style="border-top: 2px solid #000069">${vo.pub_year}</th>
												</c:forEach>
											</c:when>
										</c:choose>
										<!-- 논문수, 도서수, 학술지수, 참고문헌수 각각 합계 나타낼 부분 -->
										<th style="border-top: 2px solid #000069;"><font color="#000069">합계</font></th>
										<tr>
											<!-- 논문수 통계 -->
											<td style="border-top: 1px solid #b4b4b4">
												<strong>논문</strong>
											</td>
											<c:choose>
												<c:when test="${not empty yearVOList}">
													<c:set var="sum" value="0" />
													<c:forEach items="${yearVOList}" var="vo" varStatus="g">
														<td style="border-top: 1px solid #b4b4b4">
															<fmt:formatNumber value="${vo.arti_cnt}" pattern="#,###,###" />
														</td>
														<c:set var="sum" value="${sum+vo.arti_cnt}" />
													</c:forEach>
													<td style="border-top: 1px solid #b4b4b4">
														<font color="#28288C"><strong><fmt:formatNumber value="${sum}" pattern="#,###,###" /></strong></font>
													</td>
												</c:when>
											</c:choose>
										</tr>
										<tr>
											<!-- 도서수 통계 -->
											<td style="">
												<strong>도서</strong>
											</td>
											<c:choose>
												<c:when test="${not empty yearVOList}">
													<c:set var="sum" value="0" />
													<c:forEach items="${yearVOList}" var="vo" varStatus="g">
														<td style="">
															<fmt:formatNumber value="${vo.book_cnt}" pattern="#,###,###" />
														</td>
														<c:set var="sum" value="${sum+vo.book_cnt}" />
													</c:forEach>
													<td style="">
														<font color="#28288C"><strong><fmt:formatNumber value="${sum}" pattern="#,###,###" /></strong></font>
													</td>
												</c:when>
											</c:choose>
										</tr>
										<tr>
											<!-- 학술지수 통계 -->
											<td style="">
												<strong>학술지</strong>
											</td>
											<c:choose>
												<c:when test="${not empty yearVOList}">
													<c:set var="sum" value="0" />
													<c:forEach items="${yearVOList}" var="vo" varStatus="g">
														<td style="">
															<fmt:formatNumber value="${vo.jrnl_cnt}" pattern="#,###,###" />
														</td>
														<c:set var="sum" value="${sum+vo.jrnl_cnt}" />
													</c:forEach>
													<td style="">
														<font color="#28288C"><strong><fmt:formatNumber value="${sum}" pattern="#,###,###" /></strong></font>
													</td>
												</c:when>
											</c:choose>
										</tr>
										<tr>
											<!-- 참고문헌수 통계 -->
											<td style="">
												<strong>참고문헌</strong>
											</td>
											<c:choose>
												<c:when test="${not empty yearVOList}">
													<c:set var="sum" value="0" />
													<c:forEach items="${yearVOList}" var="vo" varStatus="g">
														<td style="">
															<fmt:formatNumber value="${vo.refr_cnt}" pattern="#,###,###" />
														</td>
														<c:set var="sum" value="${sum+vo.refr_cnt}" />
													</c:forEach>
													<td style="">
														<font color="#28288C"><strong><fmt:formatNumber value="${sum}" pattern="#,###,###" /></strong></font>
													</td>
												</c:when>
											</c:choose>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<!-- 차트를 그릴 canvas 정의 -->
						<div class="row" align="center" style="margin-top: 15px">
							<div class="col-sm-12">
								<canvas id="yearStats" width="700" height="200"></canvas>
							</div>
						</div>
						<script>
                        /** x축에 들어갈 발행연도 데이터  **/
                        var chartLabels = [];
                        /** 논문수 데이터  **/
                        var artiCnt = [];
                        /** 도서수 데이터  **/
                        var bookCnt = [];
                        /** 학술지수 데이터  **/
                        var jrnlCnt = [];
                        /** 참고문헌수 데이터  **/
                        var refrCnt = [];
                        
                        /** 발행연도, 논문수, 도서수, 학술지수, 참고문헌수 각각 데이터를 JSON 방식으로 불러옴  **/
                        $.getJSON("/stat/yearcnt", function(data){   
                        $.each(data, function(inx, obj){   
                           chartLabels.push(obj.pub_year);   
                           artiCnt.push(obj.arti_cnt);
                           bookCnt.push(obj.book_cnt);
                           jrnlCnt.push(obj.jrnl_cnt);
                           refrCnt.push(obj.refr_cnt);
                        });
                         createChart();
                     }); 
      
                        /* 연도 선택에 따른 차트 생성 */
                     function createChart(){
                        
                           /* SelectBox 옵션중 전체를 선택했을 경우 논문수, 도서수, 학술지수, 참고문헌수 합계를 차트에 나타내도록 함 */
                           
                        <c:set var = "sum1" value = "0" />
                        <c:forEach items="${yearVOList}" var="vo" varStatus="g">
                        <c:set var="sum1" value="${sum1+vo.arti_cnt}" />
                        </c:forEach>
                        <c:set var = "sum2" value = "0" />
                        <c:forEach items="${yearVOList}" var="vo" varStatus="g">
                        <c:set var="sum2" value="${sum2+vo.book_cnt}" />
                        </c:forEach>
                        <c:set var = "sum3" value = "0" />   
                        <c:forEach items="${yearVOList}" var="vo" varStatus="g">
                        <c:set var="sum3" value="${sum3+vo.jrnl_cnt}" />
                        </c:forEach>
                        <c:set var = "sum4" value = "0" />   
                        <c:forEach items="${yearVOList}" var="vo" varStatus="g">
                        <c:set var="sum4" value="${sum4+vo.refr_cnt}" />
                        </c:forEach>
      
                        /* 처음 연도별 현황 페이지로 이동하였을 때, 총 연도 논문수, 도서수, 학술지수, 참고문헌수 합계 차트 */
                        var totalChart = new Chart(document.getElementById("yearStats"), {
                                 type: 'horizontalBar',
                                 data: {
                                   labels: ["논문", "도서", "학술지", "참고문헌"],
                                   datasets: [
                                     {
                                       label: chartLabels + "년",
                                       backgroundColor : "rgba(102,153,255,0.5)",
                                       data: [${sum1}, ${sum2}, ${sum3}, ${sum4}]
                                     }
                                   ]
                                 },
                                 options: {
                                   legend: { 
                                      display: false 
                                   },
                                   tooltips: {
                                       callbacks: {
                                             label: function(tooltipItem, data) {
                                                 var value = data.datasets[0].data[tooltipItem.index];
                                                 if(parseInt(value) >= 1000){
                                                            return  value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "건";
                                                         } else {
                                                            return  value;
                                                         }
                                             }
                                       } 
                                   },
                                   scales: {
                                      xAxes: [{
                                         ticks: {
                                            beginAtZero: true, 
                                            fontSize: 14
                                         }
                                      }]
                                   }
                                 }
                             });
                        //총 합계 차트 업데이트
                        totalChart.update();
                        
                        /* 연도 선택 옵션이 변경됨을 감지 */
                        $("#yearOption").change(function(){
                                                      
                           /* 선택된 옵션이 '전체' 일때(총 합계 차트) */
                           if($(this).val() == '0')
                           {                              
                              var a = new Chart(document.getElementById("yearStats"), {
                                    type: 'horizontalBar',
                                    data: {
                                      labels: ["논문", "도서", "학술지", "참고문헌"],
                                      datasets: [
                                        {
                                          label: chartLabels + "년",
                                          backgroundColor : "rgba(102,153,255,0.5)",
                                          data: [${sum1}, ${sum2}, ${sum3}, ${sum4}]
                                        }
                                      ]
                                    },
                                    options: {
                                      responsive: true,
                                      maintainAspectRatio: false,
                                      legend: { 
                                         display: false 
                                      },
                                      tooltips: {
                                          callbacks: {
                                                label: function(tooltipItem, data) {
                                                    var value = data.datasets[0].data[tooltipItem.index];
                                                    if(parseInt(value) >= 1000){
                                                               return  value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "건";
                                                            } else {
                                                                return  value.toString() + "건";
                                                            }
                                                }
                                          } 
                                      },
                                      scales: {
                                         xAxes: [{
                                            ticks: {
                                               beginAtZero: true, 
                                               fontSize: 14
                                            }
                                         }]
                                      }
                                    }
                                });
                              d.destroy();
                              b.destroy();
                              c.destroy();
                              f.destroy();
                              e.destroy();
                              totalChart.destroy();
                              /* 총 합계 차트는 업데이트 */
                              a.update();
                           }                     
                           /* 선택된 옵션이 '2013년' 일때(2013년 해당 논문수, 도서수, 학술지수, 참고문헌수 차트) */
                           else if($(this).val() == '1')
                           {
                              var b = new Chart(document.getElementById("yearStats"), {
                                    type: 'horizontalBar',
                                    data: {
                                      labels: ["논문", "도서", "학술지", "참고문헌"],
                                      datasets: [
                                        {
                                          label: chartLabels[0]+"년",
                                          backgroundColor : "rgba(102,153,255,0.5)",
                                          data: [artiCnt[0], bookCnt[0], jrnlCnt[0], refrCnt[0]]
                                        }
                                      ]
                                    },
                                    options: {
                                      responsive: true,
                                      maintainAspectRatio: false,
                                      legend: { 
                                         display: false 
                                      },
                                      tooltips: {
                                          callbacks: {
                                                label: function(tooltipItem, data) {
                                                    var value = data.datasets[0].data[tooltipItem.index];
                                                    if(parseInt(value) >= 1000){
                                                               return  value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "건";
                                                            } else {
                                                               return  value.toString() + "건";
                                                            }
                                                }
                                          } 
                                      },
                                      scales: {
                                         xAxes: [{
                                            ticks: {
                                               beginAtZero: true, 
                                               fontSize: 14
                                            }
                                         }]
                                      }
                                    }
                                });
                              a.destroy();
                              d.destroy();
                              c.destroy();
                              f.destroy();
                              e.destroy();
                              totalChart.destroy();
                              /* 2013년 차트 업데이트 */
                              b.update();
                           }
                           /* 선택된 옵션이 '2014년' 일때(2014년 해당 논문수, 도서수, 학술지수, 참고문헌수 차트) */
                           else if($(this).val() == '2')
                           {
                              var c = new Chart(document.getElementById("yearStats"), {
                                    type: 'horizontalBar',
                                    data: {
                                      labels: ["논문", "도서", "학술지", "참고문헌"],
                                      datasets: [
                                        {
                                          label: chartLabels[1]+"년",
                                          backgroundColor : "rgba(102,153,255,0.5)",
                                          data: [artiCnt[1], bookCnt[1], jrnlCnt[1], refrCnt[1]]
                                        }
                                      ]
                                    },
                                    options: {
                                      responsive: true,
                                      maintainAspectRatio: false,
                                      legend: { 
                                         display: false 
                                      },
                                      tooltips: {
                                          callbacks: {
                                                label: function(tooltipItem, data) {
                                                    var value = data.datasets[0].data[tooltipItem.index];
                                                    if(parseInt(value) >= 1000){
                                                               return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "건";
                                                            } else {
                                                               return value.toString() + "건";
                                                            }
                                                }
                                          } 
                                      },
                                      scales: {
                                         xAxes: [{
                                            ticks: {
                                               beginAtZero: true, 
                                               fontSize: 14
                                            }
                                         }]
                                      }
                                    }
                                });
                              a.destroy();
                              b.destroy();
                              d.destroy();
                              f.destroy();
                              e.destroy();
                              totalChart.destroy();
                              /* 2014년 차트 업데이트 */
                              c.update();   
                           }
                           /* 선택된 옵션이 '2015년' 일때(2015년 해당 논문수, 도서수, 학술지수, 참고문헌수 차트) */
                           else if($(this).val() == '3')
                           {
                              var d = new Chart(document.getElementById("yearStats"), {
                                    type: 'horizontalBar',
                                    data: {
                                      labels: ["논문", "도서", "학술지", "참고문헌"],
                                      datasets: [
                                        {
                                          label: chartLabels[2]+"년",
                                          backgroundColor : "rgba(102,153,255,0.5)",
                                          data: [artiCnt[2], bookCnt[2], jrnlCnt[2], refrCnt[2]]
                                        }
                                      ]
                                    },
                                    options: {
                                      responsive: true,
                                      maintainAspectRatio: false,
                                      legend: { 
                                         display: false 
                                      },
                                      tooltips: {
                                          callbacks: {
                                                label: function(tooltipItem, data) {
                                                    var value = data.datasets[0].data[tooltipItem.index];
                                                    if(parseInt(value) >= 1000){
                                                               return  value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "건";
                                                            } else {
                                                               return   value.toString() + "건";
                                                            }
                                                }
                                          } 
                                      },
                                      scales: {
                                         xAxes: [{
                                            ticks: {
                                               beginAtZero: true, 
                                               fontSize: 14
                                            }
                                         }]
                                      }
                                    }
                                });
                              a.destroy();
                              b.destroy();
                              c.destroy();
                              f.destroy();
                              e.destroy();
                              totalChart.destroy();
                              /* 2015년 차트 업데이트 */
                              d.update();
                           }
                           /* 선택된 옵션이 '2016년' 일때(2016년 해당 논문수, 도서수, 학술지수, 참고문헌수 차트) */
                           else if($(this).val() == '4')
                           {
                              var e = new Chart(document.getElementById("yearStats"), {
                                    type: 'horizontalBar',
                                    data: {
                                      labels: ["논문", "도서", "학술지", "참고문헌"],
                                      datasets: [
                                        {
                                          label: chartLabels[3]+"년",
                                          backgroundColor : "rgba(102,153,255,0.5)",
                                          data: [artiCnt[3], bookCnt[3], jrnlCnt[3], refrCnt[3]]
                                        }
                                      ]
                                    },
                                    options: {
                                      responsive: true,
                                      maintainAspectRatio: false,
                                      legend: { 
                                         display: false 
                                      },
                                      tooltips: {
                                          callbacks: {
                                                label: function(tooltipItem, data) {
                                                    var value = data.datasets[0].data[tooltipItem.index];
                                                    if(parseInt(value) >= 1000){
                                                               return  value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "건";
                                                            } else {
                                                               return  value.toString() + "건";
                                                            }
                                                }
                                          } 
                                      },
                                      scales: {
                                         xAxes: [{
                                            ticks: {
                                               beginAtZero: true, 
                                               fontSize: 14          
                                            }
                                         }]
                                      }
                                    }
                                });
                              a.destroy();
                              b.destroy();
                              c.destroy();
                              d.destroy();
                              f.destroy();
                              totalChart.destroy();
                              /* 2016년 차트 업데이트 */
                              e.update();
                           }
                           
                           /* 선택된 옵션이 '2017년' 일때(2017년 해당 논문수, 도서수, 학술지수, 참고문헌수 차트) */
                           else if($(this).val() == '5')
                           {
                              var f = new Chart(document.getElementById("yearStats"), {
                                    type: 'horizontalBar',
                                    data: {
                                      labels: ["논문", "도서", "학술지", "참고문헌"],
                                      datasets: [
                                        {
                                          label: chartLabels[3]+"년",
                                          backgroundColor : "rgba(102,153,255,0.5)",
                                          data: [artiCnt[4], bookCnt[4], jrnlCnt[4], refrCnt[4]]
                                        }
                                      ]
                                    },
                                    options: {
                                      responsive: true,
                                      maintainAspectRatio: false,
                                      legend: { 
                                         display: false 
                                      },
                                      tooltips: {
                                          callbacks: {
                                                label: function(tooltipItem, data) {
                                                    var value = data.datasets[0].data[tooltipItem.index];
                                                    if(parseInt(value) >= 1000){
                                                               return  value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "건";
                                                            } else {
                                                               return  value.toString() + "건";
                                                            }
                                                }
                                          } 
                                      },
                                      scales: {
                                         xAxes: [{
                                            ticks: {
                                               beginAtZero: true, 
                                               fontSize: 14          
                                            }
                                         }]
                                      }
                                    }
                                }); 
                              a.destroy();
                              b.destroy();
                              c.destroy();
                              d.destroy();
                              e.destroy();
                              totalChart.destroy();
                              /* 2017년 차트 업데이트 */
                              f.update();
                           }
                        });
                       
                     }
                  </script>
					</div>
				</main>
			</div>
		</div>
		<script src="/resources/js/scripts.js"></script>
	</body>
</form>
</html>