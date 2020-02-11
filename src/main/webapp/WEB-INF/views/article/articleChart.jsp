<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- jstl 문법 사용을 위한 정의 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<!--  StyleSheet_부트스트랩 사용 -->
<!-- JQUERY, JAVASCRIPT -->
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
<script src="/resources/js/bootstrap.min.js"></script>
<!-- CSS -->
<link href="<c:url value='/resources/css/bootstrap.css' />" rel="stylesheet">
<link href="<c:url value='/resources/css/_bootswatch.scss' />" rel="stylesheet">
<link href="<c:url value='/resources/css/_variables.scss' />" rel="stylesheet">

<!--  통계부분_탭 사용 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>

<!-- Chart.js 사용(라인, 바, 플롯, 레이더 등 사용) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.min.js"></script>
<!--  워드클라우드 사용(키워드 빈도)  -->
<script src="https://cdn.anychart.com/releases/v8/js/anychart-base.min.js"></script>
<script src="https://cdn.anychart.com/releases/v8/js/anychart-tag-cloud.min.js"></script>

<script>
$(document).ready(function(){
	 <!-- 수정해야함(임의로, 분야 선택시 테이블 바뀌도록 코딩) -->
	 $('#ctgrselect').change(function() {
		var state = $('#ctgrselect option:selected').val();
		if(state == 'artH')
			{
			 $('.layer2').show();
			 $('.layer1').hide();
			}
		else if(state == 'lifeSc')
			{
			 $('.layer2').show();
			 $('.layer1').hide();
			}
		else if(state == 'pysicSc')
		{
		 $('.layer2').show();
		 $('.layer1').hide();
		}
		else if(state == 'socialSc')
		{
		 $('.layer2').show();
		 $('.layer1').hide();
		}
		else if(state == 'tech')
		{
		 $('.layer2').show();
		 $('.layer1').hide();
		}
		else
			{
			 	$('.layer1').show();
				$('.layer2').hide();
			}
	 });
	 <!-- 연구분야별 통계: 정렬 방식에 따라 테이블 데이터 바뀌는 코드 추가 -->
	 $('#cnt2').change(function() {
			var state = $('#cnt2 option:selected').val();
			
	});
});

</script>

<style>
#yearselect {
	position: relative;
	width: 170px;
	border: 1px solid #999;
	z-index
	=1;
}

#orgnselect {
	position: relative;
	width: 170px;
	border: 1px solid #999;
	z-index
	=1;
}

#cnt {
	position: relative;
	width: 170px;
	border: 1px solid #999;
	z-index
	=1;
}

#cnt2 {
	position: relative;
	width: 170px;
	border: 1px solid #999;
	z-index
	=1;
}

#ctgrselect {
	position: relative;
	width: 170px;
	border: 1px solid #999;
	z-index
	=1;
}

.layer2 {
	display: none;
}

nav>.nav.nav-tabs {
	border: none;
	color: #fff;
	background: #272e38;
	border-radius: 0;
}

nav>div a.nav-item.nav-link, nav>div a.nav-item.nav-link.active {
	border: nonoe;
	padding: 18px 25px;
	color: #fff;
	background: #272e38;
	border-radius: 0;
}

.tab-content {
	background: #fdfdfd;
	line-height: 25px;
	border-top: 5px solid #3071a9;
}

nav>div a.nav-item.nav-link:hover, nav>div a.nav-item.nav-link:focus,
	nav>div a.nav-item.nav-link.active:hover, nav>div a.nav-item.nav-link.active:focus
	{
	border: none;
	background: #3071a9;
	color: #fff;
	border-radius: 0;
	transition: background 0.20s linear;
}
</style>

<meta charset="UTF-8">
<title>논문 현황분석_시각화</title>
</head>
<body>
	<div class="wrap">
		<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
			<div class="container">
				<a class="navbar-brand" href="/article">Article DataParsing</a>
			</div>
		</nav>
		<div class="container">
			<div style="min-height: 500px;">
				<div style="margin: 30px;">
					<nav>
						<div class="nav nav-tabs nav-fill" id="nav-tab" role="tablist">
							<a class="nav-item nav-link active" id="year-tab" data-toggle="tab" href="#year" role="tab" aria-controls="year" aria-selected="true">연도별 통계</a> <a class="nav-item nav-link" id="orgn-tab" data-toggle="tab" href="#orgn" role="tab" aria-controls="orgn" aria-selected="false">저자소속기관별 통계</a> <a class="nav-item nav-link" id="ctgr-tab" data-toggle="tab" href="#ctgr" role="tab" aria-controls="ctgr" aria-selected="false">연구분야별 통계</a> <a class="nav-item nav-link" id="orgnctgr-tab" data-toggle="tab" href="#orgnctgr" role="tab" aria-controls="orgnctgr" aria-selected="false">기관별 연구분야 통계</a>
						</div>
					</nav>
					<div class="tab-content py-3 px-3 px-sm-0" id="nav-tabContent">
						<div class="tab-pane fade show active" id="year" role="tabpanel" aria-labelledby="year-tab">
							<!--  연도별 통계 -->
							<div id="year_stat" style="margin-top: 20px">
								<p style="font-size: 20px; font-weight: bold; color: #000069">연도별 데이터 통계</p>
								<table style="text-align: center;" class="table table-hover">
									<tbody>
										<th style="border-top: 2px solid #000069">구분</th>
										<th style="border-top: 2px solid #000069">2015</th>
										<th style="border-top: 2px solid #000069">2016</th>
										<th style="border-top: 2px solid #000069">2017</th>
										<th style="border-top: 2px solid #000069">2018</th>
										<th style="border-top: 2px solid #000069">2019</th>
										<th style="border-top: 2px solid #000069">합계</th>
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
								<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
								<script src='https://cdnjs.cloudflare.com/ajax/libs/Chart.js/1.0.2/Chart.js'></script>
								<select class="form-control" id="yearOption">
									<option value="arti">논문</option>
									<option value="book">도서</option>
									<option value="jrnl">학술지</option>
									<option value="refr">참고문헌</option>
								</select>
								<div align="center" style="margin-top: 15px">
									<canvas id="yearStat"></canvas>
								</div>
								<script>
										var ctx = document.getElementById("yearStat").getContext("2d");
										ctx.canvas.width = 800;
										ctx.canvas.height = 400;
			
										var dataMap = {
											'arti' : {
												method : 'Line',
												data : {
													labels : ["2015", "2016", "2017","2018", "2019"],
													datasets : [{
														label : "yearly statistics of article",
														fillColor : "rgba(102,153,255,0.5)",
														strokeColor : "rgba(000,051,153,0.8)",
														highlightFill : "rgba(220,220,220,0.75)",
														highlightStroke : "rgba(220,220,220,1)",
														data : [ 65, 59, 80, 81, 56 ]
													}],
												},
												options : {
													title : {
														display : true,
														text : '연도별 논문(건)수'
													}
												}
											},
											'book' : {
												method : 'Line',
												data : {
													labels : ["2015", "2016", "2017","2018", "2019"],
													datasets : [{
														label : "yearly statistics of book",
														fillColor : "rgba(102,153,255,0.5)",
														strokeColor : "rgba(000,051,153,0.8)",
														highlightFill : "rgba(220,220,220,0.75)",
														highlightStroke : "rgba(220,220,220,1)",
														data : [ 20, 25, 33, 45, 50 ]
													}],
												},
												options : {
													title : {
														display : true,
														text : '연도별 도서(권)수'
													}
												}
											},
											'jrnl' : {
												method : 'Line',
												data : {
													labels : ["2015", "2016", "2017","2018", "2019"],
													datasets : [{
														label : "yearly statistics of journal",
														fillColor : "rgba(102,153,255,0.5)",
														strokeColor : "rgba(000,051,153,0.8)",
														highlightFill : "rgba(220,220,220,0.75)",
														highlightStroke : "rgba(220,220,220,1)",
														data : [ 40, 33, 55, 90, 100 ]
													}],
												},
												options : {
													title : {
														display : true,
														text : '연도별 학술지(종)수'
													}
												}
											},
											'refr' : {
												method : 'Line',
												data : {
													labels : ["2015", "2016", "2017","2018", "2019"],
													datasets : [ {
														label : "yearly statistics of reference",
														fillColor : "rgba(102,153,255,0.5)",
														strokeColor : "rgba(000,051,153,0.8)",
														highlightFill : "rgba(220,220,220,0.75)",
														highlightStroke : "rgba(220,220,220,1)",
														data : [ 70, 75, 90, 85, 80 ]
													}]
												},
												options : {
													title : {
														display : true,
														text : '연도별 참고문헌수'
													}
												}
											}
										};
			
										var currentChart;
			
										function updateChart() {
											if (currentChart) {
												currentChart.destroy();
											}
			
											var determineChart = $("#yearOption").val();
			
											var params = dataMap[determineChart]
											currentChart = new Chart(ctx)[params.method](
													params.data, {});
										}
			
										$('#yearOption').on('change', updateChart)
										updateChart();
									</script>
							</div>
						</div>
						<div class="tab-pane fade" id="orgn" role="tabpanel" aria-labelledby="orgn-tab">
							<!--  소속기관별 통계 -->
							<div id="orgn_stat" style="margin-top: 20px">
								<p style="font-size: 20px; font-weight: bold; color: #000069">저자소속기관별 데이터 통계</p>
								<ol class="breadcrumb">
									<li class="breadcrumb-item">
										<p style="font-size: 15px; font-weight: bold; margin-right: 10px">발행연도</p>
									</li>
									<select class="form-control" id="yearselect">
										<option value="2015">2015</option>
										<option value="2016">2016</option>
										<option value="2017">2017</option>
										<option value="2018">2018</option>
										<option value="2019">2019</option>
									</select>
									<li class="breadcrumb-item">
										<p style="font-size: 15px; font-weight: bold; margin-left: 15px; margin-right: 10px;">기관명</p>
									</li>
									<form class="form-inline my-2 my-lg-0">
										<input class="form-control" type="text" placeholder="기관명 검색.." style="margin-right: 10px">
										<button class="btn btn-primary" type="button">검색</button>
									</form>
									<li class="breadcrumb-item">
										<p style="font-size: 15px; font-weight: bold; margin-left: 20px; margin-right: 10px;">정렬</p>
									</li>
									<select class="form-control" id="orgnselect">
										<option value="orgn">소속기관</option>
										<option value="articnt">논문 수</option>
										<option value="refrcnt">인용 수</option>
									</select>
									<p style="margin-left: 15px"></p>
									<select class="form-control" id="cnt">
										<option value="cnt5">5건</option>
										<option value="cnt7">7건</option>
										<option value="cnt10">10건</option>
										<option value="cnt20">20건</option>
									</select>
									<p style="margin-left: 15px"></p>
									<button class="btn btn-primary" type="button">조회</button>
								</ol>
								<table style="text-align: center;" class="table table-hover">
									<tbody>
										<th style="border-top: 2px solid #000069">순번</th>
										<th style="border-top: 2px solid #000069">소속기관명</th>
										<th style="border-top: 2px solid #000069">논문수</th>
										<th style="border-top: 2px solid #000069">인용수</th>
										<tr>
											<td style="border-top: 1px solid #b4b4b4">1</td>
											<td style="border-top: 1px solid #b4b4b4">
												<a href="#">기관데이터 추가..</a>
											</td>
											<td style="border-top: 1px solid #b4b4b4">0</td>
											<td style="border-top: 1px solid #b4b4b4">0</td>
										</tr>
									</tbody>
								</table>
							</div>
							<!--  소속기관별 통계: 페이징 처리 -->
							<div style="width: 100%;">
								<div align="right" style="position: relative;">
									<div style="position: absolute; text-align: center; width: 100%;">
										<div class="btn-group mr-2">
											<c:choose>
												<c:when test="${pager.nowPage ne 1 }">
													<a href='#' class="btn btn-primary" onClick="fn_paging(1)">처음</a>
												</c:when>
												<c:otherwise>
													<a class="btn btn-primary disabled">처음</a>
												</c:otherwise>
											</c:choose>
											<c:choose>
												<c:when test="${pager.nowPage ne 1 }">
													<a href="#" class="btn btn-primary" onClick="fn_paging('${pager.prevPage}')">&laquo;</a>
												</c:when>
												<c:otherwise>
													<a class="btn btn-primary disabled">&laquo;</a>
												</c:otherwise>
											</c:choose>
											<c:forEach begin="${pager.startPage}" end="${pager.endPage}" var="pageNum">
												<c:choose>
													<c:when test="${pageNum eq pager.nowPage}">
														<a href="#" class="btn btn-primary active" onClick="fn_paging('${pageNum}')">${pageNum }</a>
													</c:when>
													<c:otherwise>
														<a href="#" class="btn btn-primary" onClick="fn_paging('${pageNum}')">${pageNum}</a>
													</c:otherwise>
												</c:choose>
											</c:forEach>
											<c:choose>
												<c:when test="${pager.nowPage ne pager.pageCnt && pager.pageCnt > 0 }">
													<a class="btn btn-primary" href="#" onClick="fn_paging('${pager.nextPage}')">&raquo;</a>
												</c:when>
												<c:otherwise>
													<a class="btn btn-primary disabled">&raquo;</a>
												</c:otherwise>
											</c:choose>
											<c:choose>
												<c:when test="${pager.nowPage ne pager.pageCnt }">
													<a class="btn btn-primary" href="#" onClick="fn_paging('${pager.pageCnt}')">끝</a>
												</c:when>
												<c:otherwise>
													<a class="btn btn-primary disabled">끝</a>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="tab-pane fade" id="ctgr" role="tabpanel" aria-labelledby="ctgr-tab"></div>
						<div class="tab-pane fade" id="orgnctgr" role="tabpanel" aria-labelledby="orgnctgr-tab"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>