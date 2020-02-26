<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>현황분석 페이지</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- JQUERY, JAVASCRIPT -->
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
	
<!--  CSS -->
<link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800,900" rel="stylesheet">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/resources/css/style.css">
<link href="/resources/css/_bootswatch.scss" rel="stylesheet">
 <link href="/resources/css/_variables.scss" rel="stylesheet">

<!-- Chart.js 사용(라인, 바, 플롯, 레이더 등 사용) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.min.js"></script>
</head>
<form>
<body>
	<div class="wrapper d-flex align-items-stretch">
	    <!-- 전체 메뉴 사이드바 -->
		<nav id="sidebar">
			<div class="p-4 pt-5">
				<a href="/article" class="img logo rounded-circle mb-5" style="background-image: url(/resources/image/analyticx.png);"></a>
				<ul class="list-unstyled components mb-5">
					<li>
						<a href="#homeSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">메인</a>
						<ul class="collapse list-unstyled" id="homeSubmenu">
						<li>
							<a href="/article">논문보기</a>
						</li>
						</ul>
					</li>
						<!-- 연도별 현황 페이지에서는 현황 > 연도별 현황을 선택상태로 둠 -->
						<li class="active">
							<a href="#pageSubmenu" data-toggle="collapse" aria-expanded="true" class="dropdown-toggle">현황</a>
							<ul class="list-unstyled collapse show in" id="pageSubmenu" aria-expanded="true">
								<li class="active">
									<a href="/article/yearstat">연도별 현황</a>
								</li>
								<li>
									<a href="/article/orgnstat">소속기관별 현황</a>
								</li>
								<li>
									<a href="/article/ctgrstat">분야별 현황</a>
								</li>
								<li>
									<a href="/article/kwrdstat">키워드 현황</a>
								</li>
							</ul>
						</li>
				</ul>
				<div class="footer">
					<p>
						<script>
							document.write(new Date().getFullYear());
						</script>
							About XML Parsing
							<i class="icon-heart" aria-hidden="true"></i>
					</p>
					<p>
						made with by JuHyeon&Minjin 
						<a href="https://github.com/ghghtygh/vinea_xml.git" style="font-size: 12px" target="_blank">
							https://github.com/ghghtygh/vinea_xml.git
						</a>
				</div>
			</div>
		</nav>
		<!-- 메뉴에서 연도별 현황을 클릭하였을 때 결과 페이지  -->
		<div id="content" class="p-4 p-md-5">
			<nav class="navbar navbar-expand-lg navbar-light bg-light">
				<div class="container-fluid">
					<div class="collapse navbar-collapse" id="navbarSupportedContent">
						<ul class="nav navbar-nav ml-auto">
							<li class="nav-item active"><a class="nav-link" target="_blank" href="/article"><img src="/resources/image/home.png" alt="HOME"></a></li>
						</ul>
					</div>
				</div>
			</nav>
			<!--  연도별 통계: 테이블, 차트 -->
			<div id="year_stat" style="margin-top: 20px">
				<div class="row">
				<div class="col-lg-10">
				<p style="font-size: 20px; font-weight: bold; color: #000069">연도별 데이터 통계</p>
				</div>
				<div class="col-lg-2">
				<select class="form-control" id="yearOption">
					<option value="1">2015</option>
					<option value="2">2016</option>
					<option value="3">2017</option>
					<option value="4">2018</option>
				</select>
				</div>
				</div>
				<div class="row">
				<div class="col-lg-12">
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
				<!-- 논문, 도서, 학술지, 참고문헌으로 옵션으로 두는 SelectBox 생성 -->
				<div class="row">
				<div class="col-lg-12">
				<!-- <select class="form-control" id="yearOption">
					<option value="arti">논문</option>
					<option value="book">도서</option>
					<option value="jrnl">학술지</option>
					<option value="refr">참고문헌</option>
				</select> -->
				</div>
				</div>
				<!-- 차트를 그릴 canvas 정의 -->
				<div class="row" align="center" style="margin-top: 15px">
					<div class="col-lg-12">
						<canvas id="yearStats" width="800px" height="400px"></canvas>
					</div>
				</div>
				<script>
					/** 위에 정의한 canvas 아이디를 가져와 차트를 정의 **/
					//var ctx = document.getElementById("yearStat").getContext("2d");
					/** 차트의 크기 정의   **/
		            //ctx.canvas.width = 800;
		           // ctx.canvas.height = 400;
		            
		             
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
		            $.getJSON("/article/yearcnt", function(data){	
						$.each(data, function(inx, obj){	
							chartLabels.push(obj.pub_year);	
							artiCnt.push(obj.arti_cnt);
							bookCnt.push(obj.book_cnt);
							jrnlCnt.push(obj.jrnl_cnt);
							refrCnt.push(obj.refr_cnt);
						});
					    /** option이 변경될때마다 차트 업데이트 **/
			            //$('#yearOption').on('change', updateChart)
			            //updateChart();	
					}); 

					function createChart(){
		        	   new Chart(document.getElementById("yearStats"), {
		        		    type: 'horizontalBar',
		        		    data: {
		        		      labels: ["논문", "도서", "학술지", "참고문헌"],
		        		      datasets: [
		        		        {
		        		          label: chartLabels[0],
		        		          backgroundColor: "#3e95cd",
		        		          data: [artiCnt[0], bookCnt[0], jrnlCnt[0], refrCnt[0]]
		        		        }
		        		      ]
		        		    },
		        		    options: {
		        		      legend: { display: false },		        		     
		        		    }
		        		});
		        	   
					}
		        	   
	
		          /** 위에 생성한 SelectBox의 옵션에 따른 차트 변경 
		                var dataMap = {
		            			/* 논문 선택  
		                		'1' : {
	                                 type : 'horizontalBar',
	                                 //type : 'Bar',
	                                 data : {
	                                	/* 	 연도  
	                                    labels : chartLabels,
	                                    /* 	논문 수 데이터가 들어갈 부분  
	                                    datasets : [ {
	                                       label : "논문수",
	                                       fillColor : "rgba(102,153,255,0.5)",
	                                       strokeColor : "rgba(000,051,153,0.8)",
	                                       highlightStroke : "rgba(220,220,220,1)",
	                                       data : artiCnt
	                                    }],
	                                 },
	                                /* 차트 옵션 정하는 부분(클릭 이벤트, 차트 제목 등..여러가지 기능) 
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
	                                                //display: true,
	                                                //labelString: '발행연도',
	                                                return value.toLocaleString("en-US",{style:"currency", currency:"USD"});
	                                            }
	                                        }]
	                                    } 
	                                 }
	                              },
	                              /* 	도서 선택  
	                              '2' : {
	                            	 type : 'Bar',
	                                 data : {
	                                	/* 연도  
	                                    labels : chartLabels,
	                                    /* 	도서 수 데이터가 들어갈 부분  
	                                    datasets : [ {
	                                       label : "도서수",
	                                       fillColor : "rgba(102,153,255,0.5)",
	                                       strokeColor : "rgba(000,051,153,0.8)",
	                                       highlightFill : "rgba(220,220,220,0.75)",
	                                       highlightStroke : "rgba(220,220,220,1)",
	                                       data : bookCnt
	                                    } ],
	                                 },
	                                 /* 차트 옵션 정하는 부분(클릭 이벤트, 차트 제목 등..여러가지 기능)  
	                                 options : {
	                                    title : {
	                                       display : true,
	                                       text : '연도별 도서(권)수'
	                                    }
	                                 }
	                              },
	                             /*  	학술지 선택  
	                              '3' : {
	                            	 type : 'Bar',
	                                 data : {
	                                	/* 	연도  
	                                    labels : chartLabels,
	                                    /* 	학술지 수 데이터가 들어갈 부분 
	                                    datasets : [ {
	                                       label : "학술지",
	                                       fillColor : "rgba(102,153,255,0.5)",
	                                       strokeColor : "rgba(000,051,153,0.8)",
	                                       highlightFill : "rgba(220,220,220,0.75)",
	                                       highlightStroke : "rgba(220,220,220,1)",
	                                       data : jrnlCnt
	                                    } ],
	                                 },
	                                 /* 차트 옵션 정하는 부분(클릭 이벤트, 차트 제목 등..여러가지 기능) 
	                                 options : {
	                                    title : {
	                                       display : true,
	                                       text : '연도별 학술지(종)수'
	                                    }
	                                 }
	                              },
	                             /*  참고문헌 선택 
	                              '4' : {
	                                 type : 'Bar',
	                                 data : {
	                                	/* 연도  
	                                    labels : chartLabels,
	                                    /* 	참고문헌 수 데이터가 들어갈 부분 
	                                    datasets : [ {
	                                       label : "yearly statistics of reference",
	                                       fillColor : "rgba(102,153,255,0.5)",
	                                       strokeColor : "rgba(000,051,153,0.8)",
	                                       highlightFill : "rgba(220,220,220,0.75)",
	                                       highlightStroke : "rgba(220,220,220,1)",
	                                       data : refrCnt
	                                    } ]
	                                 },
	                                 /* 차트 옵션 정하는 부분(클릭 이벤트, 차트 제목 등..여러가지 기능) 
	                                 options : {
	                                    title : {
	                                       display : true,
	                                       text : '연도별 참고문헌수'
	                                    }
	                                 }
	                              }
	                           }; **/
	                           
        
		             /*  현재 차트를 정의  
		              var currentChart;	
		              
		              function updateChart() {
		                  if (currentChart) {
		                     currentChart.destroy();
		                   }
		
			           	  var determineChart = $("#yearOption").val();
			              var params = dataMap[determineChart]
		            	  currentChart = new Chart(ctx)["horizontalBar"](params.data, {});
		              }	   */          
				</script>
			</div>
		</div>
	</div>		
<!-- JQUERY, 필요한 JAVASCRIPT 파일 -->
<script src="/resources/js/jquery.min.js"></script>
<script src="/resources/js/popper.js"></script>
<script src="/resources/js/bootstrap.min.js"></script>
<script src="/resources/js/main.js"></script>
</body>
</form>
</html>