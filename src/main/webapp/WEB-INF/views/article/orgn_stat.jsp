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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!--  CSS -->
<link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800,900" rel="stylesheet">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/resources/css/style.css">
<link href="/resources/css/_bootswatch.scss" rel="stylesheet">
<link href="/resources/css/_variables.scss" rel="stylesheet">

<!-- Chart.js 사용(라인, 바, 플롯, 레이더 등 사용) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.min.js"></script>
<script src="/resources/js/jquery-radar-plus.js"></script>
<style>
/** 연도 선택 SelectBox **/
#yearselect {
	position: relative;
	width: 130px;
	border: 1px solid #999;
	z-index
	=1;
}
/** 기관 선택 SelectBox **/
#orgnselect {
	position: relative;
	width: 170px;
	border: 1px solid #999;
	z-index
	=1;
}
/** 정렬기준(한페이지에 보여줄 목록수) SelectBox **/
#objectCnt {
	position: relative;
	width: 170px;
	border: 1px solid #999;
	z-index
	=1;
}
</style>

<script>

	$(document).ready(function() {
		
		var searchs = "${search}";
		
		$("input[name='search']").val(searchs);
		$("#input_search").val(searchs);
		
		
		/** 검색하기 **/
		$("#btn_search").on("click", function(e){
			e.preventDefault();
			
			var search = $("#input_search").val();
			
			$("input[name='search']").val(search);
			
			var formObj = $("#frm");
			formObj.attr("action", "/article/orgnstat");
			formObj.attr("method", "get");
			formObj.submit();
		});
		
		
		
		
	});
/** 페이지 이동  **/
function fn_paging(nowPage) {

	var formObj = $("#frm");
	
	var input_page = document.createElement("input");
	$(input_page).attr("type","hidden");
	$(input_page).attr("name","page");
	$(input_page).attr("value",nowPage);
	formObj.append(input_page);
	
	formObj.attr("action", "/article/orgnstat");
	formObj.attr("method", "get");
	formObj.submit();

}
/** input 태그에서 엔터 눌렀을 때 새로고침 방지 및 제출하기 **/
function inputKey(){
	if(event.keyCode==13){
		
		var search = $("#input_search").val();
		
		$("input[name='search']").val(search);
		
		var formObj = $("#frm");
		formObj.attr("action", "/article/orgnstat");
		formObj.attr("method", "get");
		formObj.submit();
	}else{
		return true;
	}
}

function search_orgn(orgn_nm){
	
	
	var formObj = $("#frm");
	
	$("input[name='search']").val(orgn_nm);
	var input_option = document.createElement("input");
	
	$(input_option).attr("type","hidden");
	
	$(input_option).attr("name","search_option");
	
	$(input_option).attr("value","6");
	
	formObj.append(input_option);
	
	
	
	formObj.attr("action", "/article");
	formObj.attr("method", "get");
	formObj.submit();
}

</script>
</head>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<!-- 전체 메뉴 사이드바 -->
		<nav id="sidebar">
			<div class="p-4 pt-5">
				<a href="/article" class="img logo rounded-circle mb-5" style="background-image: url(/resources/image/analyticx.png);"></a>
				<ul class="list-unstyled components mb-5">
					<li><a href="#homeSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">메인</a>
						<ul class="collapse list-unstyled" id="homeSubmenu">
							<li><a href="/article">논문보기</a></li>
						</ul></li>
					<!-- 기관별 현황 페이지에서는 '현황>소속기관별 현황'을 선택상태로 둠 -->
					<li class="active"><a href="#pageSubmenu" data-toggle="collapse" aria-expanded="true" class="dropdown-toggle">현황</a>
						<ul class="list-unstyled collapse show in" id="pageSubmenu" aria-expanded="true">
							<li><a href="/article/yearstat">연도별 현황</a></li>
							<li class="active"><a href="/article/orgnstat">소속기관별 현황</a></li>
							<li><a href="/article/ctgrstat">분야별 현황</a></li>
							<li><a href="/article/kwrdstat">키워드 현황</a></li>
						</ul></li>
				</ul>
				<div class="footer">
					<p>
						<script>
							document.write(new Date().getFullYear());
						</script>
						About XML Parsing <i class="icon-heart" aria-hidden="true"></i>
					</p>
					<p>
						made with by JuHyeon&Minjin <a href="https://github.com/ghghtygh/vinea_xml.git" style="font-size: 12px" target="_blank"> https://github.com/ghghtygh/vinea_xml.git </a>
				</div>
			</div>
		</nav>
		<!-- 메뉴에서 소속기관별 현황 눌렀을때 결과 페이지-->
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
			<!-- tab 정의 
			<ul class="nav nav-tabs">
				<li class="nav-item">
					<a class="nav-link active" href="#orgn1" data-toggle="tab">소속기관별 통계</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#orgn2" data-toggle="tab">소속기관별 연구분야 통계</a>
				</li>
			</ul>-->
			<div class="tab-content">
				<!-- 첫번째 tab에 들어갈 내용(시작) -->
				<!-- tab 정의 부분에서의 href 속성과 동일하게 id를 각각 지정 -->
				<div class="tab-pane active" id="orgn1">
					<!--  소속기관별 통계: 테이블 -->
					<div id="orgn_stat1" style="margin-top: 20px">
						<p style="font-size: 20px; font-weight: bold; color: #000069">소속기관별 데이터 통계</p>
						
						<div class="row">
							<div class="col-lg-12">
								<ol class="breadcrumb">
									<!-- 연도별로 검색 
					<li class="breadcrumb-item">
						<p style="font-size: 15px; font-weight: bold; margin-right: 10px">발행연도</p>
					</li>
					<select class="form-control" id="yearselect">
						<option value="2015">2015</option>
						<option value="2016">2016</option>
						<option value="2017">2017</option>
						<option value="2018">2018</option>
						<option value="2019">2019</option>
					</select>-->
									<!-- 소속기관명 검색 -->
									<li class="breadcrumb-item">
										<p style="font-size: 15px; font-weight: bold; margin-left: 15px; margin-right: 10px; margin-top: 10px">기관명</p>
									</li>
									<form id="frm" class="form-inline my-2 my-lg-0">
										<input type="hidden" name="search" value=""> <input class="form-control" id="input_search" type="text" placeholder="기관명 검색.." style="margin-right: 10px" onKeyDown="return inputKey()" onsubmit="return false" value="" maxlength="30">
										<button class="btn btn-primary" type="button" id="btn_search">검색</button>
									</form>
									<!-- 정렬방식: 어떤 기준으로 몇건씩 볼것인지 정함 
					<li class="breadcrumb-item">
						<p style="font-size: 15px; font-weight: bold; margin-left: 10px; margin-right: 10px;">정렬</p>
					</li>
					<select class="form-control" id="orgnselect">
						<option value="orgn">소속기관</option>
						<option value="articnt">논문 수</option>
						<option value="refrcnt">인용 수</option>
					</select>
					<p style="margin-left: 15px"></p>
					<select class="form-control" id="objectCnt">
						<option value="cnt5">5건</option>
						<option value="cnt7">7건</option>
						<option value="cnt10">10건</option>
						<option value="cnt20">20건</option>
					</select>
					<p style="margin-left: 15px"></p>
					<button class="btn btn-primary" type="button">조회</button>-->
								</ol>
							</div>
						</div>
						<c:choose>
							<c:when test="${search ne ''}">
								<div>
									<div style="">
										<h5>검색결과 : ${cnt }건</h5>
										<a href="/article/orgnstat">전체보기</a>
									</div>
								</div>
							</c:when>
							<c:otherwise>
								<p>총 기관 수 &nbsp;&nbsp; ${cnt}</p>
							</c:otherwise>
						</c:choose>
						<!-- 소속기관별 논문수, 인용수 목록형 통계 부분 -->
						<div class="row">
							<div class="col-lg-12">
								<table style="text-align: center;" class="table table-hover">
									<tbody>
										<th style="border-top: 2px solid #000069">순번</th>
										<th style="border-top: 2px solid #000069">소속기관명</th>
										<th style="border-top: 2px solid #000069">논문수</th>
										<th style="border-top: 2px solid #000069">인용수</th>
										<c:choose>
											<c:when test="${not empty orgList}">
												<c:forEach items="${orgList }" var="orgnVO" varStatus="g">
													<tr>
														<td>
															<!-- 순번 -->
															${orgnVO.num }
														</td>
														<td>
															<!-- 소속기관명 -->
															<a class="mb-0" href="#" style="color: black;"  onClick="search_orgn('${orgnVO.orgn_nm}')">
															${orgnVO.orgn_nm}
															</a>
														</td>
														<td>
															<!-- 논문수 -->
															${orgnVO.arti_cnt}
														</td>
														<td>
															<!-- 인용수 -->
															${orgnVO.cite_cnt}
														</td>
													</tr>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<!-- 데이터 없음 -->
												<tr>
													<td colspan="4" style="text-align: center">기관 데이터가 존재하지 않습니다</td>
												</tr>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<!-- 페이징 처리 시작 -->
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
					<!-- 페이징 처리 끝 -->
				</div>
				<!-- 첫번째 tab에 들어갈 내용(끝) -->
				<!-- 두번째 tab에 들어갈 내용(시작) -->
				<div class="tab-pane" id="orgn2">
					<div id="orgn_stat2" style="margin-top: 20px">
						<p style="font-size: 20px; font-weight: bold; color: #000069">소속기관별 연구분야 통계</p>
						<ol class="breadcrumb">
							<!-- 소속기관명 검색 부분 -->
							<li class="breadcrumb-item">
								<p style="font-size: 15px; color: #000000; font-weight: bold; margin-right: 10px; margin-left: 480px">기관명</p>
							</li>
							<form class="form-inline my-2 my-lg-0">
								<input class="form-control" type="text" placeholder="기관명 검색.." style="margin-right: 10px; width: 450px">
								<button class="btn btn-primary" type="button">검색</button>
							</form>
						</ol>
						<!-- 차트 이전 상태로 되돌리기 -->
						<button class="btn" type="button" style="width: 30px; height: 30px" onclick="resetChart()">
							<img class="btn-img" src="/resources/image/back.png">
						</button>
						<!-- 소속기관별 연구분야 비율을  보여줄 캔버스 정의 -->
						<div class="row" style="margin-top: 35px">
							<div class="col-lg-6">
								<canvas id="orgn-chart1" width="400" height="300"></canvas>
							</div>
							<div class="col-lg-6">
								<canvas id="orgn-chart2" width="400" height="300"></canvas>
							</div>
						</div>
						<script>					
					    /** 위에 정의한 캔버스 아이디를 가져와 차트를 생성 **/
					    var a =  new Chart(document.getElementById("orgn-chart1"), {
						  type: 'radar',
						  data: {
							  /* 연구분야_주제목 */
							  labels: ["공학", "자연과학", "예술 및 체육", "인문학", "사회학"],
							  /* 연구분야 비율 데이터 들어갈 부분 */
							  datasets: [{
							      label: '연구분야',
							      data: [15, 20, 40, 60, 45],
							      backgroundColor: 'rgba(102,153,255,0.5)'
							  }]   
						  },
						  /* 차트 옵션 정하는 부분(클릭 이벤트, 차트 제목 등..여러가지 기능) */
						  options: {
						    tooltips: {
						      callbacks: {
						        label: function(tooltipItem, data) {
						          return data.datasets[tooltipItem.datasetIndex].label + ": " + tooltipItem.yLabel;
						        }
						      }
						    },
						    /* 캔버스 부분에서 vh, vw를 사용하여 반응형 차트를 만들고 싶을 때에는 false로 */
						    responsive: true,
						    /* (이벤트 처리) 각 인덱스를 클릭하였을 때, 차트의 데이터와 라벨이 변할 수 있도록 함 */
						    onClick: function(e) {
						    	var element = this.getElementAtEvent(e);
					    		var index = element[0]["_index"];
					    		var labels = element[0]["_chart"].data.labels[index];
					    		
					    		/* 인덱스 별 옵션 */
								if (index == 0){
									element[0]["_chart"].data.labels = ["정보통신", "컴공", "수학",  "건축", "전자"]
									element[0]["_chart"].data.datasets[0].data =[30, 10, 5, 5, 10];
									element[0]["_chart"].config.data.datasets[0].backgroundColor = "#8e5ea2"
									element[0]["_chart"].config.data.datasets[0].label = "주제"
								}
								else if(index == 1){
									element[0]["_chart"].data.labels = ["물리",  "화학", "생물학", "지구과학", "일반과학"]
									element[0]["_chart"].data.datasets[0].data =[45, 15, 15, 35, 40];
									element[0]["_chart"].config.data.datasets[0].backgroundColor = "#8e5ea2"
									element[0]["_chart"].config.data.datasets[0].label = "주제"
								}
								else if(index == 2){
									element[0]["_chart"].data.labels = ["체육", "미술", "음악", "도예", "운동"]
									element[0]["_chart"].data.datasets[0].data =[20, 20, 40, 35, 40];
									element[0]["_chart"].config.data.datasets[0].backgroundColor = "#8e5ea2"
									element[0]["_chart"].config.data.datasets[0].label = "주제"
								}
								else if(index == 3){
									element[0]["_chart"].data.labels = ["1", "2", "3", "4", "5"]
									element[0]["_chart"].data.datasets[0].data =[20, 25, 60, 45, 75];
									element[0]["_chart"].config.data.datasets[0].backgroundColor = "#8e5ea2"
									element[0]["_chart"].config.data.datasets[0].label = "주제"
								}
								else if(index == 4){
									element[0]["_chart"].data.labels = ["a", "b", "c", "d", "e"]
									element[0]["_chart"].data.datasets[0].data =[90, 70, 40, 65, 55];
									element[0]["_chart"].config.data.datasets[0].backgroundColor = "#8e5ea2"
									element[0]["_chart"].config.data.datasets[0].label = "주제"
								}
								
								element[0]["_chart"].update();
						    },
						    /* 비율은 0부터 100까지로 기준을 둠 */				    
						    scale : {
						    	ticks : {
						    		beginAtZero : true,
						    		min : 0,
						    		max : 100,
						    		stepSize: 10
						    	},
						    	scaleLabel : {
						    		display: true,
						    		labelString: 'Percentage',
						    		fontSize: 20
						    	}
						    },
						    legend : {
						    	position: 'top'
						    },
						    title: {
						    	display: true,
						    	text: '소속기관명',
						    	position: 'bottom',
						    	fontSize: 17,
						    	fontStyle: 'normal'
						    },
						    hover: {
						    	mode: null,
						    }
						  }
					});
					    
					    /** 위에 정의한 캔버스 아이디를 가져와 차트를 생성 **/
					    var b =  new Chart(document.getElementById("orgn-chart2"), {
						  type: 'radar',
						  data: {
							  /* 연구분야_주제목 */
							  labels: ["공학", "자연과학", "예술 및 체육", "인문학", "사회학"],
							  /* 연구분야 비율 데이터 들어갈 부분 */
							  datasets: [{
							      label: '연구분야',
							      data: [75, 10, 30, 45, 45],
							      backgroundColor: 'rgba(102,153,255,0.5)'
							  }]   
						  },
						  /* 차트 옵션 정하는 부분(클릭 이벤트, 차트 제목 등..여러가지 기능) */
						  options: {
						    tooltips: {
						      callbacks: {
						        label: function(tooltipItem, data) {
						          return data.datasets[tooltipItem.datasetIndex].label + ": " + tooltipItem.yLabel;
						        }
						      }
						    },
						    /* 캔버스 부분에서 vh, vw를 사용하여 반응형 차트를 만들고 싶을 때에는 false로 */
						    responsive: true,
						    /* (이벤트 처리) 각 인덱스를 클릭하였을 때, 차트의 데이터와 라벨이 변할 수 있도록 함 */
						    onClick: function(e) {
						    	var element = this.getElementAtEvent(e);
					    		var index = element[0]["_index"];
					    		var labels = element[0]["_chart"].data.labels[index];
					    		
					    		/* 인덱스 별 옵션 */
								if (index == 0){
									element[0]["_chart"].data.labels = ["정보통신", "컴공", "수학",  "건축", "전자"]
									element[0]["_chart"].data.datasets[0].data =[30, 10, 5, 5, 10];
									element[0]["_chart"].config.data.datasets[0].backgroundColor = "#8e5ea2"
									element[0]["_chart"].config.data.datasets[0].label = "주제"
								}
								else if(index == 1){
									element[0]["_chart"].data.labels = ["물리",  "화학", "생물학", "지구과학", "일반과학"]
									element[0]["_chart"].data.datasets[0].data =[20, 30, 15, 35, 40];
									element[0]["_chart"].config.data.datasets[0].backgroundColor = "#8e5ea2"
									element[0]["_chart"].config.data.datasets[0].label = "주제"
								}
								else if(index == 2){
									element[0]["_chart"].data.labels = ["체육", "미술", "음악", "도예", "운동"]
									element[0]["_chart"].data.datasets[0].data =[15, 20, 40, 35, 40];
									element[0]["_chart"].config.data.datasets[0].backgroundColor = "#8e5ea2"
									element[0]["_chart"].config.data.datasets[0].label = "주제"
								}
								else if(index == 3){
									element[0]["_chart"].data.labels = ["1", "2", "3", "4", "5"]
									element[0]["_chart"].data.datasets[0].data =[40, 25, 60, 45, 75];
									element[0]["_chart"].config.data.datasets[0].backgroundColor = "#8e5ea2"
									element[0]["_chart"].config.data.datasets[0].label = "주제"
								}
								else if(index == 4){
									element[0]["_chart"].data.labels = ["a", "b", "c", "d", "e"]
									element[0]["_chart"].data.datasets[0].data =[90, 70, 80, 65, 55];
									element[0]["_chart"].config.data.datasets[0].backgroundColor = "#8e5ea2"
									element[0]["_chart"].config.data.datasets[0].label = "주제"
								}
								
								element[0]["_chart"].update();
						    },
						    /* 비율은 0부터 100까지로 기준을 둠 */				    
						    scale : {
						    	ticks : {
						    		beginAtZero : true,
						    		min : 0,
						    		max : 100,
						    		stepSize: 10
						    	},
						    	scaleLabel : {
						    		display: true,
						    		labelString: 'Percentage',
						    		fontSize: 20
						    	}
						    },
						    legend : {
						    	position: 'top'
	
						    },
						    title: {
						    	display: true,
						    	text: '소속기관명',
						    	position: 'bottom',
						    	fontSize: 17,
						    	fontStyle: 'normal'
						    },
						    hover: {
						    	mode: null,
						    }
						  }
					});
					 
					/** 차트를 맨 처음 차트로 되돌림 **/
					function resetChart(){
						  var c =  new Chart(document.getElementById("orgn-chart1"), {
							  type: 'radar',
							  data: {
								  /* 연구분야_주제목 */
								  labels: ["공학", "자연과학", "예술 및 체육", "인문학", "사회학"],
								  /* 연구분야 비율 데이터 들어갈 부분 */
								  datasets: [{
								      label: '연구분야',
								      data: [15, 25, 70, 35, 45],
								      backgroundColor: 'rgba(102,153,255,0.5)'
								  }]   
							  },
							  /* 차트 옵션 정하는 부분(클릭 이벤트, 차트 제목 등..여러가지 기능) */
							  options: {
							    tooltips: {
							      callbacks: {
							        label: function(tooltipItem, data) {
							          return data.datasets[tooltipItem.datasetIndex].label + ": " + tooltipItem.yLabel;
							        }
							      }
							    },
							    /* 캔버스 부분에서 vh, vw를 사용하여 반응형 차트를 만들고 싶을 때에는 false로 */
							    responsive: true,
							    /* (이벤트 처리) 각 인덱스를 클릭하였을 때, 차트의 데이터와 라벨이 변할 수 있도록 함 */
							    onClick: function(e) {
							    	var element = this.getElementAtEvent(e);				
						    		var index = element[0]["_index"];
						    		var labels = element[0]["_chart"].data.labels[index];
						    		
						    		
									if (index == 0){
										element[0]["_chart"].data.labels = ["정보통신", "컴공", "수학",  "건축", "전자"]
										element[0]["_chart"].data.datasets[0].data =[30, 10, 5, 5, 10];
										element[0]["_chart"].config.data.datasets[0].backgroundColor = "#8e5ea2"
										element[0]["_chart"].config.data.datasets[0].label = "주제"
										element[0]["_chart"].stop();
									}
									else if(index == 1){
										element[0]["_chart"].data.labels = ["물리",  "화학", "생물학", "지구과학", "일반과학"]
										element[0]["_chart"].data.datasets[0].data =[20, 30, 15, 35, 40];
										element[0]["_chart"].config.data.datasets[0].backgroundColor = "#8e5ea2"
										element[0]["_chart"].config.data.datasets[0].label = "주제"
										element[0]["_chart"].stop();
									}
									else if(index == 2){
										element[0]["_chart"].data.labels = ["체육", "미술", "음악", "도예", "운동"]
										element[0]["_chart"].data.datasets[0].data =[15, 20, 40, 35, 40];
										element[0]["_chart"].config.data.datasets[0].backgroundColor = "#8e5ea2"
										element[0]["_chart"].config.data.datasets[0].label = "주제"
										element[0]["_chart"].stop();
									}
									else if(index == 3){
										element[0]["_chart"].data.labels = ["1", "2", "3", "4", "5"]
										element[0]["_chart"].data.datasets[0].data =[40, 25, 60, 45, 75];
										element[0]["_chart"].config.data.datasets[0].backgroundColor = "#8e5ea2"
										element[0]["_chart"].config.data.datasets[0].label = "주제"
										element[0]["_chart"].stop();
									}
									else if(index == 4){
										element[0]["_chart"].data.labels = ["a", "b", "c", "d", "e"]
										element[0]["_chart"].data.datasets[0].data =[90, 70, 80, 65, 55];
										element[0]["_chart"].config.data.datasets[0].backgroundColor = "#8e5ea2"
										element[0]["_chart"].config.data.datasets[0].label = "주제"
										element[0]["_chart"].stop();
									}
									
									element[0]["_chart"].update();
							    },
							    scale : {
							    	ticks : {
							    		beginAtZero : true,
							    		min : 0,
							    		max : 100,
							    		stepSize: 10
							    	},
							    	scaleLabel : {
							    		display: true,
							    		labelString: 'Percentage',
							    		fontSize: 20
							    	}
							    },
							    legend : {
							    	position: 'top'
		
							    },
							    title: {
							    	display: true,
							    	text: '소속기관명',
							    	position: 'bottom',
							    	fontSize: 17,
							    	fontStyle: 'normal'
							    },
							    hover: {
							    	mode: null,
							    }
							  }
						});
						  
						var d =  new Chart(document.getElementById("orgn-chart2"), {
							  type: 'radar',
							  data: {
								  /* 연구분야_주제목 */
								  labels: ["공학", "자연과학", "예술 및 체육", "인문학", "사회학"],
								  /* 연구분야 비율 데이터 들어갈 부분 */
								  datasets: [{
								      label: '연구분야',
								      data: [20, 35, 40, 70, 45],
								      backgroundColor: 'rgba(102,153,255,0.5)'
								  }]   
							  },
							  /* 차트 옵션 정하는 부분(클릭 이벤트, 차트 제목 등..여러가지 기능) */
							  options: {
							    tooltips: {
							      callbacks: {
							        label: function(tooltipItem, data) {
							          return data.datasets[tooltipItem.datasetIndex].label + ": " + tooltipItem.yLabel;
							        }
							      }
							    },
							    /* 캔버스 부분에서 vh, vw를 사용하여 반응형 차트를 만들고 싶을 때에는 false로 */
							    responsive: true,
							    /* (이벤트 처리) 각 인덱스를 클릭하였을 때, 차트의 데이터와 라벨이 변할 수 있도록 함 */
							    onClick: function(e) {
							    	var element = this.getElementAtEvent(e);				
						    		var index = element[0]["_index"];
						    		var labels = element[0]["_chart"].data.labels[index];
						    		
						    		
									if (index == 0){
										element[0]["_chart"].data.labels = ["정보통신", "컴공", "수학",  "건축", "전자"]
										element[0]["_chart"].data.datasets[0].data =[30, 10, 5, 5, 10];
										element[0]["_chart"].config.data.datasets[0].backgroundColor = "#8e5ea2"
										element[0]["_chart"].config.data.datasets[0].label = "주제"
										element[0]["_chart"].stop();
									}
									else if(index == 1){
										element[0]["_chart"].data.labels = ["물리",  "화학", "생물학", "지구과학", "일반과학"]
										element[0]["_chart"].data.datasets[0].data =[20, 30, 15, 35, 40];
										element[0]["_chart"].config.data.datasets[0].backgroundColor = "#8e5ea2"
										element[0]["_chart"].config.data.datasets[0].label = "주제"
										element[0]["_chart"].stop();
									}
									else if(index == 2){
										element[0]["_chart"].data.labels = ["체육", "미술", "음악", "도예", "운동"]
										element[0]["_chart"].data.datasets[0].data =[15, 20, 40, 35, 40];
										element[0]["_chart"].config.data.datasets[0].backgroundColor = "#8e5ea2"
										element[0]["_chart"].config.data.datasets[0].label = "주제"
										element[0]["_chart"].stop();
									}
									else if(index == 3){
										element[0]["_chart"].data.labels = ["1", "2", "3", "4", "5"]
										element[0]["_chart"].data.datasets[0].data =[40, 25, 60, 45, 75];
										element[0]["_chart"].config.data.datasets[0].backgroundColor = "#8e5ea2"
										element[0]["_chart"].config.data.datasets[0].label = "주제"
										element[0]["_chart"].stop();
									}
									else if(index == 4){
										element[0]["_chart"].data.labels = ["a", "b", "c", "d", "e"]
										element[0]["_chart"].data.datasets[0].data =[90, 70, 80, 65, 55];
										element[0]["_chart"].config.data.datasets[0].backgroundColor = "#8e5ea2"
										element[0]["_chart"].config.data.datasets[0].label = "주제"
										element[0]["_chart"].stop();
									}
									
									element[0]["_chart"].update();
							    },
							    scale : {
							    	ticks : {
							    		beginAtZero : true,
							    		min : 0,
							    		max : 100,
							    		stepSize: 10
							    	},
							    	scaleLabel : {
							    		display: true,
							    		labelString: 'Percentage',
							    		fontSize: 20
							    	}						    
							    },
							    legend : {
							    	position: 'top'
		
							    },
							    title: {
							    	display: true,
							    	text: '소속기관명',
							    	position: 'bottom',
							    	fontSize: 17,
							    	fontStyle: 'normal'
							    },
							    hover: {
							    	mode: null,
							    }
							  }
						});
					}
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