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
				<li class="nav-item dropdown">
					<a class="nav-link" id="userDropdown" href="/" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-home"></i></a>
				</li>
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
								</div>
								논문보기
							</a>
						<div class="sb-sidenav-menu-heading" style="color: #fff">Statics</div>
							<a style="font-weight: bold; color: #fff" class="nav-link" href="/stat/year">
								<div class="sb-nav-link-icon">
									<i class="fas fa-chart-bar"></i>
								</div>
								연도별 현황
							</a>
							<a class="nav-link" href="/stat/orgn">
								<div class="sb-nav-link-icon">
									<i class="fa fa-table"></i>
								</div>
								소속기관별 현황
							</a>
							<a class="nav-link" href="/stat/ctgr">
								<div class="sb-nav-link-icon">
									<i class="fas fa-chart-area"></i>
								</div>
								분야별 현황
							</a>
							<a class="nav-link" href="/stat/kwrd">
								<div class="sb-nav-link-icon">
									<i class="fa fa-cloud"></i>
								</div>
								키워드 현황
							</a>	                          
					</div>
				</div>
				<div class="sb-sidenav-footer">
					<div class="small">Made with by NJH&SMJ</div>
						<a href="https://github.com/ghghtygh/vinea_xml.git" style="font-size: 12px" target="_blank"> 
							<i class="fab fa-github"></i>
							View Source
							<i class="fab fa-github"></i>
							=> Click
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
						<p style="font-size: 15px; font-weight: bold">논문 발행연도
						<select class="form-control" id="yearOption">
							<option value="0">전체</option>
							<option value="1">2015</option>
							<option value="2">2016</option>
							<option value="3">2017</option>
							<option value="4">2018</option>
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
									<td style="border-top: 1px solid #b4b4b4"><strong>논문</strong></td>
									<c:choose>
										<c:when test="${not empty yearVOList}">
											<c:set var = "sum" value = "0" />
											<c:forEach items="${yearVOList}" var="vo" varStatus="g">
												<td style="border-top: 1px solid #b4b4b4"><fmt:formatNumber value="${vo.arti_cnt}" pattern="#,###,###"/></td>
												<c:set var="sum" value="${sum+vo.arti_cnt}" />
											</c:forEach>
											<td style="border-top: 1px solid #b4b4b4"><font color="#28288C"><strong><fmt:formatNumber value="${sum}" pattern="#,###,###"/></strong></font></td>
										</c:when>
									</c:choose>
								</tr>		
								<tr>
									<!-- 도서수 통계 -->
									<td style=""><strong>도서</strong></td>
									<c:choose>
										<c:when test="${not empty yearVOList}">
											<c:set var = "sum" value = "0" />
											<c:forEach items="${yearVOList}" var="vo" varStatus="g">
												<td style=""><fmt:formatNumber value="${vo.book_cnt}" pattern="#,###,###"/></td>
												<c:set var="sum" value="${sum+vo.book_cnt}" />
											</c:forEach>
											<td style=""><font color="#28288C"><strong><fmt:formatNumber value="${sum}" pattern="#,###,###"/></strong></font></td>
										</c:when>
									</c:choose>
								</tr>
								<tr>
									<!-- 학술지수 통계 -->
									<td style=""><strong>학술지</strong></td>
									<c:choose>
										<c:when test="${not empty yearVOList}">
											<c:set var = "sum" value = "0" />
											<c:forEach items="${yearVOList}" var="vo" varStatus="g">
												<td style=""><fmt:formatNumber value="${vo.jrnl_cnt}" pattern="#,###,###"/></td>
												<c:set var="sum" value="${sum+vo.jrnl_cnt}" />
											</c:forEach>
											<td style=""><font color="#28288C"><strong><fmt:formatNumber value="${sum}" pattern="#,###,###"/></strong></font></td>
										</c:when>
									</c:choose>
								</tr>						
								<tr>
									<!-- 참고문헌수 통계 -->
									<td style=""><strong>참고문헌</strong></td>
									<c:choose>
										<c:when test="${not empty yearVOList}">
											<c:set var = "sum" value = "0" />
											<c:forEach items="${yearVOList}" var="vo" varStatus="g">
												<td style=""><fmt:formatNumber value="${vo.refr_cnt}" pattern="#,###,###"/></td>
												<c:set var="sum" value="${sum+vo.refr_cnt}" />
											</c:forEach>
											<td style=""><font color="#28288C"><strong><fmt:formatNumber value="${sum}" pattern="#,###,###"/></strong></font></td>
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
							    /**
								//option이 변경될때마다 차트 업데이트 
					            $('#yearOption').on('change', updateChart)
					            updateChart();
					            **/
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
										/* 총 합계 차트는 업데이트 */
										a.update();
										totalChart.destroy();
										b.destroy();
										c.destroy();
										d.destroy();
										e.destroy();
									}							
									/* 선택된 옵션이 '2015년' 일때(2015년 해당 논문수, 도서수, 학술지수, 참고문헌수 차트) */
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
										/* 2015년 차트 업데이트 */
										b.update();
										totalChart.destroy();
										a.destroy();
										c.destroy();
										d.destroy();
										e.destroy();
									}
									/* 선택된 옵션이 '2016년' 일때(2016년 해당 논문수, 도서수, 학술지수, 참고문헌수 차트) */
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
						        		                               return value;
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
										/* 2016년 차트 업데이트 */
										c.update();		
										totalChart.destroy();
										b.destroy();
										a.destroy();
										d.destroy();
										e.destroy();
									}
									/* 선택된 옵션이 '2017년' 일때(2017년 해당 논문수, 도서수, 학술지수, 참고문헌수 차트) */
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
										/* 2017년 차트 업데이트 */
										d.update();
										totalChart.destroy();
										b.destroy();
										c.destroy();
										a.destroy();
										e.destroy();
									}
									/* 선택된 옵션이 '2018년' 일때(2018년 해당 논문수, 도서수, 학술지수, 참고문헌수 차트) */
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
						        		      legend: { 
						        		    	  display: false 
						        		      },
						        		      tooltips: {
						        		          callbacks: {
						        		                label: function(tooltipItem, data) {
						        		                    var value = data.datasets[0].data[tooltipItem.index];
						        		                    if(parseInt(value) >= 1000){
						        		                               return '$' + value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "건";
						        		                            } else {
						        		                               return '$' + value;
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
										/* 2018년 차트 업데이트 */
										e.update();
										totalChart.destroy();
										b.destroy();
										c.destroy();
										d.destroy();
									}
								});
			        	   
							}
				        	   
			
							/**
				          		//이전 Chart 생성(논문, 도서, 학술지, 참고문헌 선택에 따른 bar차트 변경)_시작 
				          		//위에 생성한 SelectBox의 옵션에 따른 차트 변경 
				                var dataMap = {
				            			//논문 선택  
				                		'arti' : {
			                                 type : 'Bar',
			                                 data : {
			                                	//연도  
			                                    labels : chartLabels,
			                                    //논문 수 데이터가 들어갈 부분  
			                                    datasets : [ {
			                                       label : "논문수",
			                                       fillColor : "rgba(102,153,255,0.5)",
			                                       strokeColor : "rgba(000,051,153,0.8)",
			                                       highlightStroke : "rgba(220,220,220,1)",
			                                       data : artiCnt
			                                    }],
			                                 },
			                                 //차트 옵션 정하는 부분(클릭 이벤트, 차트 제목 등..여러가지 기능) 
			                                 options : {
			                                    responsive: true,
			                                    title : {
			                                       display : true,
			                                       text : '연도별 논문(건)수'
			                                    },
			                                    tooltips: {
			                                    	mode: 'index',
			                                    	intersect: false,
			                                    },
			                                    hover: {
			                                    	mode: 'nearest',
			                                    	intersect: true
			                                    },
			                                    scales: {
			                                        xAxes: [{
			                                            display: true,
			                                            scaleLabel: {
			                                                display: true,
			                                                labelString: '논문건수'
			                                            },
			                                        }],
			                                        yAxes: [{
			                                            display: true,
			                                            ticks: {
			                                                autoSkip: false
			                                            },
			                                            scaleLabel: function(label) {
			                                                display: true,
			                                                labelString: '발행연도',
			                                            }
			                                        }]
			                                    } 
			                                 }
			                              },
			                              //도서 선택  
			                              'book' : {
			                            	 type : 'Bar',
			                                 data : {
			                                	//연도  
			                                    labels : chartLabels,
			                                    //도서 수 데이터가 들어갈 부분  
			                                    datasets : [ {
			                                       label : "도서수",
			                                       fillColor : "rgba(102,153,255,0.5)",
			                                       strokeColor : "rgba(000,051,153,0.8)",
			                                       highlightFill : "rgba(220,220,220,0.75)",
			                                       highlightStroke : "rgba(220,220,220,1)",
			                                       data : bookCnt
			                                    } ],
			                                 },
			                                 //차트 옵션 정하는 부분(클릭 이벤트, 차트 제목 등..여러가지 기능)  
			                                 options : {
			                                    title : {
			                                       display : true,
			                                       text : '연도별 도서(권)수'
			                                    }
			                                 }
			                              },
			                             //학술지 선택  
			                              'jrnl' : {
			                            	 type : 'Bar',
			                                 data : {
			                                	//연도  
			                                    labels : chartLabels,
			                                    //학술지 수 데이터가 들어갈 부분 
			                                    datasets : [ {
			                                       label : "학술지",
			                                       fillColor : "rgba(102,153,255,0.5)",
			                                       strokeColor : "rgba(000,051,153,0.8)",
			                                       highlightFill : "rgba(220,220,220,0.75)",
			                                       highlightStroke : "rgba(220,220,220,1)",
			                                       data : jrnlCnt
			                                    } ],
			                                 },
			                                 //차트 옵션 정하는 부분(클릭 이벤트, 차트 제목 등..여러가지 기능) 
			                                 options : {
			                                    title : {
			                                       display : true,
			                                       text : '연도별 학술지(종)수'
			                                    }
			                                 }
			                              },
			                             //참고문헌 선택 
			                              'refr' : {
			                                 type : 'Bar',
			                                 data : {
			                                	//연도  
			                                    labels : chartLabels,
			                                    //참고문헌 수 데이터가 들어갈 부분 
			                                    datasets : [ {
			                                       label : "yearly statistics of reference",
			                                       fillColor : "rgba(102,153,255,0.5)",
			                                       strokeColor : "rgba(000,051,153,0.8)",
			                                       highlightFill : "rgba(220,220,220,0.75)",
			                                       highlightStroke : "rgba(220,220,220,1)",
			                                       data : refrCnt
			                                    } ]
			                                 },
			                                 //차트 옵션 정하는 부분(클릭 이벤트, 차트 제목 등..여러가지 기능) 
			                                 options : {
			                                    title : {
			                                       display : true,
			                                       text : '연도별 참고문헌수'
			                                    }
			                                 }
			                              }
			                           };
			                  
							  //SelectBox 옵션에 따른 차트업데이트
				              function updateChart() {
				            	  
				            	  //현재 차트를 정의
				            	  var currentChart;	
				            	  
				            	  //선택 사항에 따라, 이전 차트는 지움
				                  if (currentChart) {
				                     currentChart.destroy();
				                   }
				
				            	  //selectBox에서 선택된 value값(논문,도서,학술지,참고문헌)
					           	  var determineChart = $("#yearOption").val();
				            	  //지정한 dataMap안의 value값 밑에 지정한 chart 옵션들을 사용하겠다는 정의
					              var params = dataMap[determineChart]
				            	  //차트 생성(정의한 차트 옵션들을 적용하여 차트를 생성)
				            	  currentChart = new Chart(ctx)[params.type](params.data, {});
				              }		            
				              //이전 Chart 생성(논문, 도서, 학술지, 참고문헌 선택에 따른 bar차트 변경)_종료 
				              **/
						</script>
					</div>
				</main>
		</div>
	</div>
<script src="/resources/js/scripts.js"></script>
</body>
</form>
</html>