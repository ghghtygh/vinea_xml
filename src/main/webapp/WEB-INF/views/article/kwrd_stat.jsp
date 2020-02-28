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

<!-- 워드클라우드(anychar_Tagcloud 활용) -->
<script src="https://cdn.anychart.com/releases/v8/js/anychart-base.min.js"></script>
<script src="https://cdn.anychart.com/releases/v8/js/anychart-tag-cloud.min.js"></script>
<style>
/** 분야 선택 SelectBox **/
#ctgrnm, #subjnm {
	position: relative;
	width: 500px;
	border: 1px solid #999;
	z-index=1;
}
#cnt_option {
	position: relative;
	width: 150px;
	border: 1px solid #999;
	z-index=1
}
</style>
<script>
	 /** document 로딩 시작 **/  
	 $(document).ready(function() {
		 
		 /** 키워드 빈도 탭에서 분야명과 주제명을 선택하는 옵션들의  selected(선택상태) 속성을 가져옴 **/
		 $('#ctgrnm option[value="${ctgrnm}"]').attr("selected",true);
		 $('#subjnm option[value="${subjnm}"]').attr("selected",true);
		 $('#cnt_option option[value="${cnt_option}"]').attr("selected",true);

		 /* 분야명을 클릭하였을 때 페이지 업데이트 */
		$("#ctgrnm").change(function() {
				
			var formObj = $("#frm");
			formObj.attr("action", "/article/kwrdstat");
			formObj.attr("method", "get");
			formObj.submit();
				
		});
		
		/* 주제명을 클릭하였을 때 페이지 업데이트 */
		$("#subjnm").change(function() {
				
			var formObj = $("#frm");
			formObj.attr("action", "/article/kwrdstat");
			formObj.attr("method", "get");
			formObj.submit();				
		});
		$("#cnt_option").change(function() {
				
			var formObj = $("#frm");
			formObj.attr("action", "/article/kwrdstat");
			formObj.attr("method", "get");
			formObj.submit();				
		});
	});
	/** document 로딩 종료 **/ 
</script>
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
							<a  class="nav-link" href="/">
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
							<a class="nav-link" href="/article/ctgrstat">
								<div class="sb-nav-link-icon">
									<i class="fas fa-chart-area"></i>
								</div>
								분야별 현황
							</a>
							<a style="font-weight: bold; color: #fff" class="nav-link" href="/article/kwrdstat">
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
							<p style="font-size: 25px; font-weight: bold; color: #000069; margin-top: 50px">분야별 키워드 빈도수</p>
							<hr>
							<ol class="breadcrumb">
								<!--분야 선택-->
								<li class="breadcrumb-item">
									<p style="font-size: 15px; font-weight: bold; margin-right: 10px; color: #000">분야</p>
								</li>
								<!-- 분야정보가 들어간 리스트가 비어있지 않은 경우 -->
								<c:if test="${!empty ctgrList}">
								<select class="form-control" id="ctgrnm" name="ctgrnm">
									<!-- 전체 -->
									<option value="">ALL</option>
									<!-- 분야 리스트 데이터 -->
									<c:forEach var="list" items="${ctgrList}" varStatus="c">
											<option value="${list}">${list}</option>
									</c:forEach>
								</select>
								</c:if>
								<li class="breadcrumb-item">
									<p style="font-size: 15px; font-weight: bold; margin-left: 20px; margin-right: 10px; color: #000">주제</p>
								</li>
								<!-- 주제명 리스트 데이터 -->
								<select class="form-control" name="subjnm" id="subjnm">
										<c:forEach var="sub" items= "${subList}" varStatus = "c">
											<option value = "${sub}">${sub}</option>
										</c:forEach>
								</select>
								<li class="breadcrumb-item">
									<p style="font-size: 15px; font-weight: bold; margin-left: 20px; margin-right: 10px; color: #000">키워드수</p>
								</li>
								<!-- 주제명 리스트 데이터 -->
								<select class="form-control" id="cnt_option" name="cnt_option">
										<option value="10">10개</option>
										<option value="30">30개</option>
										<option value="50">50개</option>
								</select>	
							</ol>
							<!-- 분야별 키워드 빈도를 나타낼 워드클라우드  -->
							<div align="center">
								 <div id="kwrdcloud" style="width: 1000px; height: 700px;">
								 	<div style="margin-top: 350px" id="loading" class="text-center">
										<div class="spinner-border text-dark" style="width: 5rem; height: 5rem;" role="status">
											<span class="sr-only">Loading...</span>
								  		</div>
								 	</div>
								</div>
							</div>
							<script>
								/* 키워드명 */
								var chartLabels = [];
								/* 키워드 빈도수 */
								var chartData = [];
								/* JSON 방식으로 데이터를 가져옴 */
								$.getJSON("/article/kwrdcnt", function(data){		
									$("#loading").show();
									createChart();
								});
						
								/* 워드클라우드 생성 */
								function createChart(){
									anychart.onDocumentReady(function(){
										$("#loading").hide();
										/* 새로운 배열 생성 */
										var data = new Array(); 
										
										/* 리스트 데이터를 JSON 형태로 변경하여 데이터에 넣음 */
										<c:forEach items="${list2}" var="item">
											//console.log(JSON.parse('${item}'));
											data.push( JSON.parse('${item}'));
										</c:forEach>
										
										/* 워드클라우드 옵션 설정 */
										var chart = anychart.tagCloud(data);
										var formatter = "{%value}"+"%";
										var tooltip = chart.tooltip();		
										
										chart.angles([0]);						
										chart.textSpacing(5);
										chart.mode('spiral');
										chart.background().fill("#fff");
										chart.container("kwrdcloud");
										chart.draw();	
										tooltip.format(formatter);
										
										/* 각 키워드를 클릭하였을 때 일어나는 이벤트 */
										chart.listen("pointClick", function(e) {
											
											var formObj = $("#frm");
											
											/* 각 키워드에 해당하는 논문 목록 페이지로 이동 */
											var input_search = document.createElement("input");
											$(input_search).attr("type","hidden");
											$(input_search).attr("name","search");
											$(input_search).attr("value",e.point.get("x"));
											formObj.append(input_search);
											
											var input_option = document.createElement("input");
											$(input_option).attr("type","hidden");
											$(input_option).attr("name","search_option");
											$(input_option).attr("value","7");
											formObj.append(input_option);
																											
											formObj.attr("action", "/article");
											formObj.attr("method", "get");
											formObj.submit();
											});
										
										});							
									}						
							</script>
						</div> 
					</main>
				</form>
			</div>
		</div>
<script src="/resources/js/scripts.js"></script>	
</body>
</html>