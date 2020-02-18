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
<script src='https://cdnjs.cloudflare.com/ajax/libs/Chart.js/1.0.2/Chart.js'></script>
</head>
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
					<button type="button" id="sidebarCollapse" class="btn btn-primary">
						<i class="fa fa-bars"></i> <span class="sr-only">Toggle Menu</span>
					</button>
					<button class="btn btn-dark d-inline-block d-lg-none ml-auto" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
						<i class="fa fa-bars"></i>
					</button>
					<div class="collapse navbar-collapse" id="navbarSupportedContent">
						<ul class="nav navbar-nav ml-auto">
							<li class="nav-item active"><a class="nav-link" href="/article">Home</a></li>
						</ul>
					</div>
				</div>
			</nav>
			<!-- tab 정의 -->
			<ul class="nav nav-tabs">
				<li class="nav-item">
					<a class="nav-link active" href="#year1" data-toggle="tab">연도별 통계</a>					
				</li>
			</ul>
			<!-- 해당 tab 안에 들어갈 내용  -->
			<div class="tab-content">
			<!-- tab 정의 부분에서의 href 속성과 동일하게 id를 지정 -->
			<div class="tab-pane active" id="year1">
			<!--  연도별 통계: 테이블, 차트 -->
			<div id="year_stat" style="margin-top: 20px">
				<p style="font-size: 20px; font-weight: bold; color: #000069">연도별 데이터 통계</p>
				<div class="row">
				<div class="col-lg-12">
				<table style="text-align: center;" class="table table-hover">
					<tbody>
						<th style="border-top: 2px solid #000069">구분</th>
						<th style="border-top: 2px solid #000069">2015</th>
						<th style="border-top: 2px solid #000069">2016</th>
						<th style="border-top: 2px solid #000069">2017</th>
						<th style="border-top: 2px solid #000069">2018</th>
						<th style="border-top: 2px solid #000069">2019</th>
						<th style="border-top: 2px solid #000069">합계</th>
						<!-- 연도별 논문, 도서, 학술지, 참고문헌 수를 통계낸 결과 데이터를 넣을 예정 -->
						<!-- 각 통계데이터 결과를 클릭하였을 때, 그에 해당하는 논문 목록을 보여줌 -->
						<tr>
							<td style="border-top: 1px solid #b4b4b4">논문</td>
							<td style="border-top: 1px solid #b4b4b4">
								<a href="#">0</a>
							</td>
							<td style="border-top: 1px solid #b4b4b4">
								<a href="#">0</a>
							</td>
							<td style="border-top: 1px solid #b4b4b4">
								<a href="#">0</a>
							</td>
							<td style="border-top: 1px solid #b4b4b4">
								<a href="#">0</a>
							</td>
							<td style="border-top: 1px solid #b4b4b4">
								<a href="#">0</a>
							</td>
							<td style="border-top: 1px solid #b4b4b4">0</td>
						</tr>
						<tr>
							<td>도서</td>
							<td>
								<a href="#">0</a>
							</td>
							<td>
								<a href="#">0</a>
							</td>
							<td>
								<a href="#">0</a>
							</td>
							<td>
								<a href="#">0</a>
							</td>
							<td>
								<a href="#">0</a>
							</td>
							<td>0</td>
						</tr>
						<tr>
							<td>학술지</td>
							<td>
								<a href="#">0</a>
							</td>
							<td>
								<a href="#">0</a>
							</td>
							<td>
								<a href="#">0</a>
							</td>
							<td>
								<a href="#">0</a>
							</td>
							<td>
								<a href="#">0</a>
							</td>
							<td>0</td>
						</tr>
						<tr>
							<td>참고문헌</td>
							<td>
								<a href="#">0</a>
							</td>
							<td>
								<a href="#">0</a>
							</td>
							<td>
								<a href="#">0</a>
							</td>
							<td>
								<a href="#">0</a>
							</td>
							<td>
								<a href="#">0</a>
							</td>
							<td>0</td>
						</tr>
					</tbody>
				</table>
				</div>
				</div>
				<!-- 논문, 도서, 학술지, 참고문헌으로 옵션으로 두는 SelectBox 생성 -->
				<div class="row">
				<div class="col-lg-12">
				<select class="form-control" id="yearOption">
					<option value="arti">논문</option>
					<option value="book">도서</option>
					<option value="jrnl">학술지</option>
					<option value="refr">참고문헌</option>
				</select>
				</div>
				</div>
				<!-- 차트를 그릴 canvas 정의 -->
				<div class="row" align="center" style="margin-top: 15px">
					<div class="col-lg-12">
						<canvas id="yearStat"></canvas>
					</div>
				</div>
				<script>
					/** 위에 정의한 canvas 아이디를 가져와 차트를 정의 **/
					var ctx = document.getElementById("yearStat").getContext("2d");
					/** 차트의 크기 정의 **/
		            ctx.canvas.width = 800;
		            ctx.canvas.height = 400;
			
		            	/** 위에 생성한 SelectBox의 옵션에 따른 차트 변경 **/
		                var dataMap = {
		            			/* 논문 선택 */
		                		'arti' : {
	                                 method : 'Line',
	                                 data : {
	                                	/* 연도 */
	                                    labels : [ "2015", "2016", "2017", "2018", "2019" ],
	                                    /* 논문 수 데이터가 들어갈 부분 */
	                                    datasets : [ {
	                                       label : "yearly statistics of article",
	                                       fillColor : "rgba(102,153,255,0.5)",
	                                       strokeColor : "rgba(000,051,153,0.8)",
	                                       highlightFill : "rgba(220,220,220,0.75)",
	                                       highlightStroke : "rgba(220,220,220,1)",
	                                       data : [ 65, 59, 80, 81, 56 ]
	                                    } ],
	                                 },
	                                 /* 차트 옵션 정하는 부분(클릭 이벤트, 차트 제목 등..여러가지 기능) */
	                                 options : {
	                                    title : {
	                                       display : true,
	                                       text : '연도별 논문(건)수'
	                                    }
	                                 }
	                              },
	                              /* 도서 선택 */
	                              'book' : {
	                                 method : 'Line',
	                                 data : {
	                                	/* 연도 */
	                                    labels : [ "2015", "2016", "2017", "2018", "2019" ],
	                                    /* 도서 수 데이터가 들어갈 부분 */
	                                    datasets : [ {
	                                       label : "yearly statistics of book",
	                                       fillColor : "rgba(102,153,255,0.5)",
	                                       strokeColor : "rgba(000,051,153,0.8)",
	                                       highlightFill : "rgba(220,220,220,0.75)",
	                                       highlightStroke : "rgba(220,220,220,1)",
	                                       data : [ 20, 25, 33, 45, 50 ]
	                                    } ],
	                                 },
	                                 /* 차트 옵션 정하는 부분(클릭 이벤트, 차트 제목 등..여러가지 기능) */
	                                 options : {
	                                    title : {
	                                       display : true,
	                                       text : '연도별 도서(권)수'
	                                    }
	                                 }
	                              },
	                              /* 학술지 선택 */
	                              'jrnl' : {
	                                 method : 'Line',
	                                 data : {
	                                	/* 연도 */
	                                    labels : [ "2015", "2016", "2017", "2018", "2019" ],
	                                    /* 학술지 수 데이터가 들어갈 부분 */
	                                    datasets : [ {
	                                       label : "yearly statistics of journal",
	                                       fillColor : "rgba(102,153,255,0.5)",
	                                       strokeColor : "rgba(000,051,153,0.8)",
	                                       highlightFill : "rgba(220,220,220,0.75)",
	                                       highlightStroke : "rgba(220,220,220,1)",
	                                       data : [ 40, 33, 55, 90, 100 ]
	                                    } ],
	                                 },
	                                 /* 차트 옵션 정하는 부분(클릭 이벤트, 차트 제목 등..여러가지 기능) */
	                                 options : {
	                                    title : {
	                                       display : true,
	                                       text : '연도별 학술지(종)수'
	                                    }
	                                 }
	                              },
	                              /* 참고문헌 선택 */
	                              'refr' : {
	                                 method : 'Line',
	                                 data : {
	                                	/* 연도 */
	                                    labels : [ "2015", "2016", "2017", "2018", "2019" ],
	                                    /* 참고문헌 수 데이터가 들어갈 부분 */
	                                    datasets : [ {
	                                       label : "yearly statistics of reference",
	                                       fillColor : "rgba(102,153,255,0.5)",
	                                       strokeColor : "rgba(000,051,153,0.8)",
	                                       highlightFill : "rgba(220,220,220,0.75)",
	                                       highlightStroke : "rgba(220,220,220,1)",
	                                       data : [ 70, 75, 90, 85, 80 ]
	                                    } ]
	                                 },
	                                 /* 차트 옵션 정하는 부분(클릭 이벤트, 차트 제목 등..여러가지 기능) */
	                                 options : {
	                                    title : {
	                                       display : true,
	                                       text : '연도별 참고문헌수'
	                                    }
	                                 }
	                              }
	                           };
	         
		              /** 현재 차트를 정의  **/
		              var currentChart;	
		              
		              function updateChart() {
		            	  /** 차트가 업데이트 될때 에는 현재 차트를 지움 **/
		                  if (currentChart) {
		                     currentChart.destroy();
		                   }
		
		            	  /** 위에 정의한 SelectBox의 id를 가지고 옵션의 value값을 차트를 결정하는 기준으로 둠 **/
			           	  var determineChart = $("#yearOption").val();
		            	  /** 선택한 option에 따른 차트를 params라는 변수에 정의 **/
			              var params = dataMap[determineChart]
		            	  /** 차트를 생성 **/
			              currentChart = new Chart(ctx)[params.method](params.data, {});
		              }
		
		              /** option이 변경될때마다 차트 업데이트 **/
		              $('#yearOption').on('change', updateChart)
		              updateChart();		            
				</script>
			</div>
			</div>
			</div>
		</div>
	</div>		
<!-- JQUERY, 필요한 JAVASCRIPT 파일 -->
<script src="/resources/js/jquery.min.js"></script>
<script src="/resources/js/popper.js"></script>
<script src="/resources/js/bootstrap.min.js"></script>
<script src="/resources/js/main.js"></script>
</body>
</html>