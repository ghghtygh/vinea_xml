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
<script>
	/** document 로딩 시작 **/
	$(document).ready(function() {

		/** 현황 페이지 탭 속성 가져옴 **/
		$("#${tab_option}").addClass("active");
		$("a[name='${tab_option}']").addClass("active");

		/** 연구분야별 현황에서 분야선택 옵션과 정렬 옵션의 selected(선택상태) 속성을 가져옴 **/
		$('#ctgrselect option[value="${ctgr_option}"]').attr("selected", true);
		$('#sort_option option[value="${sort_option}"]').attr("selected", true);
		$('#cnt_option option[value="${cnt_option}"]').attr("selected", true);

		/** 연구분야 상위통계의 차트를 생성 **/
		createChart();

		/** tab을 넘어갈 때, 차트가 버벅거리는 현상을 해결 **/
		$('a[data-toggle="tab"]').on('hidden.bs.tab', function(e) {

			$("#div_canvas_ctgr").html("");
			$("#div_canvas_ctgr").html("<canvas id='canvas_ctgr'></canvas>");

			createChart();

		})

		var th_option_html = $('#sort_option option[value="${sort_option}"]').html();

		if (th_option_html == "분야명") {
			$("#th_option").html("논문");
		} else {
			$("#th_option").html(th_option_html);
		}

		$("#cnt_option").on('change', function() {

			/** 선택된 옵션에 따라 페이지를 업데이트 **/
			var formObj = $("#frm");
			formObj.attr("action", "/article/ctgrstat");
			formObj.attr("method", "get");
			formObj.submit();

		});

		/** 연구분야 옵션 선택 **/
		$('#ctgrselect').change(function() {

			var formObj = $("#frm");

			var input_tab = document.createElement("input");
			$(input_tab).attr("type", "hidden");
			$(input_tab).attr("name", "tab_option");
			$(input_tab).attr("value", $(".tab-pane.active").attr('id'));
			formObj.append(input_tab);

			formObj.attr("action", "/article/ctgrstat");
			formObj.attr("method", "get");
			formObj.submit();
		});

		/** 연구분야별 데이터 통계 정렬 기준 **/
		$('#sort_option').change(function() {

			var formObj = $("#frm");

			var input_tab = document.createElement("input");
			$(input_tab).attr("type", "hidden");
			$(input_tab).attr("name", "tab_option");
			$(input_tab).attr("value", $(".tab-pane.active").attr('id'));
			formObj.append(input_tab);

			formObj.attr("action", "/article/ctgrstat");
			formObj.attr("method", "get");
			formObj.submit();

		});
	});
	/** document 로딩 종료 **/

	/** 연구분야별 데이터 통계(목록형 데이터 통계: 페이징 처리) **/
	function fn_paging(nowPage) {

		var formObj = $("#frm");

		var input_page = document.createElement("input");
		$(input_page).attr("type", "hidden");
		$(input_page).attr("name", "page");
		$(input_page).attr("value", nowPage);
		formObj.append(input_page);

		formObj.attr("action", "/article/ctgrstat");
		formObj.attr("method", "get");
		formObj.submit();

	}
</script>
<style>
/** 연구분야별 데이터 통계 연구분야 선택 SelectBox **/
#ctgrselect {
	position: relative;
	width: 250px;
	border: 1px solid #999;
	z-index
	=1;
}
/** 연구분야별 데이터 통계 정렬기준 SelectBox **/
#sort_option {
	position: relative;
	width: 170px;
	border: 1px solid #999;
	z-index:1;
}
#cnt_option {
	position: relative;
	width: 120px;
	border: 1px solid #999;
	z-index:1;
}
/** 주제별 상위 통계 분류기준 SelectBox **/
#cnt3 {
	position: relative;
	width: 170px;
	border: 1px solid #999;
	z-index:1;
}
/** 주제별 상위통계 연구분야 선택 SelectBox **/
#ctgrselect2 {
	position: relative;
	width: 250px;
	border: 1px solid #999;
	z-index:1;
}
/** 처음 들어갔을 때, 표시 되지 않는 layer **/
.layer2, .artiStat, .jrnlStat, .refrStat {
	display: none;
}
/** layout 설정 **/
#section, #article, #aside {
	display: block;
	width: 400px;
	text-align: left;
}

#section {
	float: left;
	width: 280px;
	height: 60px;
}

#article {
	width: 500px;
}

#aside {
	float: left;
	margin-top: 20px;
	margin-left: 300px;
	width: 800px;
	height: 450px;
}
</style>
</head>
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
							<a class="nav-link" href="/article/yearstat">
								<div class="sb-nav-link-icon">
									<i class="fas fa-chart-bar"></i>
								</div>
								연도별 현황
							</a>
							<a class="nav-link" href="/article/orgnstat">
								<div class="sb-nav-link-icon">
									<i class="fa fa-table"></i>
								</div>
								소속기관별 현황
							</a>
							<a  style="font-weight: bold; color: #fff"  class="nav-link" href="/article/ctgrstat">
								<div  class="sb-nav-link-icon">
									<i class="fas fa-chart-area"></i>
								</div>
								분야별 현황
							</a>
							<a class="nav-link" href="/article/kwrdstat">
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
				<form id="frm">
				<main>
					<div class="container-fluid"> 
						<div style="margin-top: 45px"></div>  
						<!-- tab 정의 -->
						<ul class="nav nav-tabs">
							<!-- 연구분야별 통계 -->
							<li class="nav-item"><a class="nav-link" href="#ctgr1" name="ctgr1" data-toggle="tab">연구분야별 통계</a></li>
							<!-- 연구분야별 상위통계 -->
							<li class="nav-item"><a class="nav-link" href="#ctgr2" name="ctgr2" data-toggle="tab">연구분야별 상위통계</a></li>
						</ul>
						<div class="tab-content">
							<p style="font-size: 20px; font-weight: bold; color: #000069; margin-top: 20px">연구분야별 데이터 통계</p>
								<div class="row">
									<div class="col-sm-12">
										<ol class="breadcrumb">
											<!-- 연구분야별로 검색 -->
											<li class="breadcrumb-item">
												<p style="font-size: 15px; font-weight: bold; margin-right: 10px; margin-left: 15px">연구분야</p>
											</li>
											<!-- 연구분야 선택옵션 -->
											<select class="form-control" id="ctgrselect" name="ctgr_option">
												<option value="1">전체</option>
												<option value="2">Science & Technology</option>
												<option value="3">Arts & Humanities</option>
												<option value="4">Social Sciences</option>
											</select>
											<!-- 정렬 기준 선택 -->
											<li class="breadcrumb-item">
												<p style="font-size: 15px; font-weight: bold; margin-left: 20px; margin-right: 10px;">정렬</p>
											</li>
											<select class="form-control" name="sort_option" id="sort_option">
												<option value="1">전체</option>
												<option value="2">저자</option>
												<option value="3">논문</option>
												<option value="4">학술지</option>
												<option value="5">참고문헌</option>
											</select>
											<!-- 정렬 기준 선택 -->
											<li class="breadcrumb-item">
												<p style="font-size: 15px; font-weight: bold; margin-left: 20px; margin-right: 10px;">&nbsp;</p>
											</li>
											<select class="form-control" name="cnt_option" id="cnt_option">
												<option value="10">10개</option>
												<option value="20">20개</option>
												<option value="30">30개</option>
												<option value="50">50개</option>
												<option value="100">100개</option>
											</select>
											<p style="margin-left: 15px"></p>
										</ol>
									</div>
								</div>
								<!-- 첫번째 tab에 들어갈 내용(시작) -->
							<!-- tab 정의 부분에서의 href 속성과 동일하게 id를 각각 지정 -->
							<div class="tab-pane" id="ctgr1">
								<!-- 연구분야별 데이터 통계 : 테이블 -->
								<div id="ctgr_stat1" style="margin-top: 20px">
									<!-- 연구분야별 데이터 통계: 전체 -->
									<div class="row">
										<div class="col-sm-12">
											<div class="layer1">
												<table style="text-align: center;" class="table table-hover">
													<thead>
													<colgroup>
														<col width="10%" />
														<col width="20%" />
														<col width="*" />
														<col width="10%" />
														<col width="10%" />
														<col width="10%" />
														<col width="10%" />
													</colgroup>
													</thead>
													<tbody>
														<!-- 전체 분야별 데이터 통계 들어갈 부분 -->
														<th style="border-top: 2px solid #000069">순번</th>
														<th style="border-top: 2px solid #000069; text-align: left;">분야명</th>
														<th style="border-top: 2px solid #000069; text-align: left;">주제명</th>
														<th style="border-top: 2px solid #000069">저자 수</th>
														<th style="border-top: 2px solid #000069">논문 수</th>
														<th style="border-top: 2px solid #000069">학술지 수</th>
														<th style="border-top: 2px solid #000069">참고문헌 수</th>
														<!-- 테이블에 실제 데이터가 들어가는 부분 -->
														<c:choose>
															<c:when test="${not empty ctgrList}">
																<c:forEach items="${ctgrList }" var="vo" varStatus="g">
																	<tr>
																		<td style="border-top: 1px solid #b4b4b4">${vo.num}</td>
																		<td style="border-top: 1px solid #b4b4b4; text-align: left;">${vo.ctgr_nm}</td>
																		<td style="border-top: 1px solid #b4b4b4; text-align: left;">${vo.subj_nm}</td>
																		<td style="border-top: 1px solid #b4b4b4"><fmt:formatNumber value="${vo.auth_cnt}" pattern="#,###,###"/></td>
																		<td style="border-top: 1px solid #b4b4b4"><fmt:formatNumber value="${vo.arti_cnt}" pattern="#,###,###"/></td>
																		<td style="border-top: 1px solid #b4b4b4"><fmt:formatNumber value="${vo.jrnl_cnt}" pattern="#,###,###"/></td>
																		<td style="border-top: 1px solid #b4b4b4"><fmt:formatNumber value="${vo.refr_cnt}" pattern="#,###,###"/></td>
																	</tr>
																</c:forEach>
															</c:when>
															<c:otherwise>
																<tr>
																	<td colspan="5" style="border-top: 1px solid #b4b4b4; border-bottom: 1px solid #b4b4b4; text-align: center">등록된 논문이 없습니다</td>
																</tr>
															</c:otherwise>
														</c:choose>
													</tbody>
												</table>
											</div>
										</div>
										<!-- 페이징 처리(시작) -->
										<div style="width: 100%;">
											<div align="right" style="position: relative;">
												<div style="position: absolute; text-align: center; width: 100%; margin-bottom: 20px">
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
												<div>
													<div style="position: relative; float: right; z-index: 10;"></div>
												</div>
											</div>
										</div>
										<!-- 페이징 처리(종료) -->
									</div>
								</div>
							</div>
							<!-- 첫번째 tab에 들어갈 내용(끝) -->
							<!-- 두번째 tab에 들어갈 내용(시작) -->
							<div class="tab-pane" id="ctgr2">
								<p style="font-size: 20px; font-weight: bold; color: #000069; margin-top: 20px">주제별 상위 통계</p>
								<!-- 연구분야의 주제별 상위 통계 : 테이블, 차트 -->
								<!-- 연구분야의 주제별 상위 통계: 테이블 부분 -->
								<div class="row">
									<div class="col-sm-5">
										<table style="text-align: center;" class="table table-hover">
											<tbody>
												<th style="border-top: 2px solid #000069">분야명</th>
												<th style="border-top: 2px solid #000069">주제명</th>
												<th style="border-top: 2px solid #000069" id="th_option">저자</th>
												<c:choose>
													<c:when test="${not empty ctgrList}">
														<c:forEach items="${ctgrList }" var="vo" varStatus="g" end="10">
															<tr>
																<td style="border-top: 1px solid #b4b4b4">${vo.ctgr_nm}</td>
																<td style="border-top: 1px solid #b4b4b4">${vo.subj_nm }</td>
																<td style="border-top: 1px solid #b4b4b4">
																	<c:choose>
																		<c:when test='${sort_option==1 }'>
                                                         					<fmt:formatNumber value="${vo.arti_cnt}" pattern="#,###,###"/>
                                                         				</c:when>
																		<c:when test='${sort_option==2 }'>
                                                         					<fmt:formatNumber value="${vo.auth_cnt}" pattern="#,###,###"/>
                                                         				</c:when>
																		<c:when test='${sort_option==3 }'>
                                                         					<fmt:formatNumber value="${vo.arti_cnt}" pattern="#,###,###"/>
                                                        				 </c:when>
																		<c:when test='${sort_option==4 }'>
                                                         					<fmt:formatNumber value="${vo.jrnl_cnt}" pattern="#,###,###"/>
                                                         				</c:when>
																		<c:when test='${sort_option==5 }'>
                                                         					<fmt:formatNumber value="${vo.refr_cnt}" pattern="#,###,###"/>
                                                         				</c:when>
																		<c:otherwise>
                                                         					<fmt:formatNumber value="${vo.arti_cnt}" pattern="#,###,###"/>
                                                         				</c:otherwise>
																	</c:choose>
																</td>
															</tr>
														</c:forEach>
													</c:when>
													<c:otherwise>
														<tr>
															<td colspan="5" style="border-top: 1px solid #b4b4b4; border-bottom: 1px solid #b4b4b4; text-align: center">등록된 논문이 없습니다</td>
														</tr>
													</c:otherwise>

												</c:choose>
											</tbody>
										</table>
									</div>
									<!-- 연구분야의 주제별 상위 통계를 보여줄 차트 캔버스 정의 -->
									<div class="col-sm-7" id="div_canvas_ctgr">
										<canvas id="canvas_ctgr"></canvas>
									</div>
								</div>
								<script>
									/** 위에 정의한 canvas 아이디를 가져와 차트를 정의 **/
									var ctx = document.getElementById(
											"canvas_ctgr").getContext("2d");
									/** 차트의 크기 정의 **/
									ctx.canvas.width = 700;
									ctx.canvas.height = 400;

									/** 차트 그리는 부분 **/
									function createChart() {
										/* 정렬 옵션 */
										var so = "${sort_option}";
										/* 실제 데이터 */
										var m_data = [];
										/* x축에 표시될 주제명 */
										var chartLabels = [];
										/* 분야 리스트 */
										var ctgrList = [];

										/* script안에서의 jstl 활용  */
										<c:choose>
										<c:when test="${not empty ctgrList}">
										<c:forEach items="${ctgrList }" var="vo" varStatus="g">

										/* 라벨에 주제명 데이터 */
										chartLabels.push("${vo.subj_nm}");

										/* default(전체)로 논문수 */
										if (so == 1) {
											m_data.push("${vo.arti_cnt}");
										}
										/* 정렬기준(2)_저자수 */
										else if (so == 2) {
											m_data.push("${vo.auth_cnt}");
										}
										/* 정렬기준(3)_논문수 */
										else if (so == 3) {
											m_data.push("${vo.arti_cnt}");
										}
										/* 정렬기준(4)_학술지수*/
										else if (so == 4) {
											m_data.push("${vo.jrnl_cnt}");
										}
										/* 정렬기준(5)_참고문헌수 */
										else if (so == 5) {
											m_data.push("${vo.refr_cnt}");
										} else {

										}
										</c:forEach>
										</c:when>
										</c:choose>

										/* 실제 차트 생성 부분(믹스 차트: 바+라인) */
										var chart = new Chart(document.getElementById("canvas_ctgr"), {
													type : 'bar',
													data : {
														/** 해당 연구분야의 주제명 **/
														labels : chartLabels,
														/** 실제 데이터가 들어갈 부분 **/
														datasets : [
																{
																	type : "line",
																	borderColor : "#8e5ea2",
																	/** 실제 통계 수치 **/
																	data : m_data,
																	fill : false
																},
																{
																	type : "bar",
																	backgroundColor : "rgba(102,153,255,0.5)",
																	data : m_data
																} ]
													},
													options : {
														responsive : true,
														tooltips: {
									        		          callbacks: {
									        		                label: function(tooltipItem, data) {
									        		                    var value = data.datasets[0].data[tooltipItem.index];
									        		                    if(parseInt(value) >= 1000){
									        		                               return  value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
									        		                            } else {
									        		                               return  value;
									        		                            }
									        		                }
									        		          } 
									        		     },
														scales : {
															yAxes : [ {
																stacked : true,
																ticks : {}
															} ],
															xAxes : [ {
																stacked : true,
																ticks : {}
															} ]
														},
														showValue : {
															fontSize : 15,
															fontStyle : 'Helvetica'
														},
														animation : {
															easing : 'easeOutCubic'
														},
														legend : {
															display : false
														}
													}
												});
									}

									/** 현재 차트를 정의  **/
									var currentChart;

									function updateChart() {
										/** 차트가 업데이트 될때 에는 현재 차트를 지움 **/
										if (currentChart) {
											currentChart.destroy();
										}

										/** 위에 정의한 SelectBox의 id를 가지고 옵션의 value값을 차트를 결정하는 기준으로 둠 **/
										var determineChart = "1";
										/** 선택한 option에 따른 차트를 params라는 변수에 정의 **/
										var params = dataMap[determineChart];
										/** 차트를 생성 **/
										currentChart = new Chart(ctx)[params.method]
												(params.data, {});
									}
								</script>
						</div>
						<!-- 두번째 tab에 들어갈 내용(종료) -->
					</div>
				</div>
			</main>
		</form>			
	</div>
</div>
<script src="/resources/js/scripts.js"></script>	
</body>
</html>