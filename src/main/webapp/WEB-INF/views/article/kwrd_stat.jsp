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
<!--  <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.min.js"></script> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.js"></script>

<!-- 워드클라우드 -->
<!-- zingchart 
<link href="https://fonts.googleapis.com/css?family=Crete+Round" rel="stylesheet">
<script src="https://cdn.zingchart.com/zingchart.min.js"></script>
-->
<!--  anychart -->
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
</style>
<script>
 $(document).ready(function() {
	 
	 $('#ctgrnm option[value="${ctgrnm}"]').attr("selected",true);
	 $('#subjnm option[value="${subjnm}"]').attr("selected",true);
	 
	
		$("#ctgrnm").change(function() {
	
	
			var formObj = $("#frm");
			formObj.attr("action", "/article/kwrdstat");
			formObj.attr("method", "get");
			formObj.submit();
			
		});
		
		$("#subjnm").change(function() {
			
			
			var formObj = $("#frm");
			formObj.attr("action", "/article/kwrdstat");
			formObj.attr("method", "get");
			formObj.submit();
			
		});
		
	});
</script>
</head>
<form id="frm">
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
						<!-- 키워드 동향 페이지에서는 '현황>키워드 현황'을 선택상태로 둠 -->
						<li class="active">
							<a href="#pageSubmenu" data-toggle="collapse" aria-expanded="true" class="dropdown-toggle">현황</a>
							<ul class="list-unstyled collapse show in" id="pageSubmenu" aria-expanded="true">
								<li>
									<a href="/article/yearstat">연도별 현황</a>
								</li>
								<li>
									<a href="/article/orgnstat">소속기관별 현황</a>
								</li>
								<li>
									<a href="/article/ctgrstat">분야별 현황</a>
								</li>
								<li class="active">
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
		<!-- 메뉴에서 키워드 현황을 클릭하였을 때 결과 페이지  -->
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
					<a class="nav-link active" href="#kwrd1" data-toggle="tab">키워드 빈도</a>
				</li>
			</ul>
			<div class="tab-content">
			<!-- 첫번째 tab에 들어갈 내용(시작) -->
			<!-- tab 정의 부분에서의 href 속성과 동일하게 id를 각각 지정 -->
			<div class="tab-pane active" id="kwrd1">
			<div id="ctgr_kwrd1" style="margin-top: 20px">
				<ol class="breadcrumb">
					<!--분야 선택-->
					<li class="breadcrumb-item">
						<p style="font-size: 15px; font-weight: bold; margin-right: 10px; color: #000">분야</p>
					</li>
					<c:if test="${!empty ctgrList}">
					<select class="form-control" id="ctgrnm" name="ctgrnm">
						<option value="">ALL</option>
						<c:forEach var="list" items="${ctgrList}" varStatus="c">
								<option value="${list}">${list}</option>
						</c:forEach>
					</select>
					</c:if>
					<li class="breadcrumb-item">
						<p style="font-size: 15px; font-weight: bold; margin-left: 20px; margin-right: 10px; color: #000">주제</p>
					</li>
					<select class="form-control" name="subjnm" id="subjnm">
							<c:forEach var="sub" items= "${subList}" varStatus = "c">
								<option value = "${sub}">${sub}</option>
							</c:forEach>
					</select>
				</ol>
				<p id = "title" style="font-size: 20px; font-weight: bold; color: #000069; margin-top: 50px">
					분야별 키워드 빈도수
				</p>
				<div>
					<div id="kwrdcloud" style="width: 1200px; height: 800px; margin-left: 130px"></div>
				</div>
				<script>
					var chartLabels = [];
					var chartData = [];
		
					$.getJSON("/article/kwrdcnt", function(data){	
						$.each(data, function(inx, obj){
							chartLabels.push(obj.kwrd_nm);	
							chartData.push(obj.kwrd_cnt);	
						});	
						createChart();
					});
			
					function createChart(){
						anychart.onDocumentReady(function(){
							var data = new Array(); 
							
							<c:forEach items="${list2}" var="item">
								data.push( JSON.parse('${item}'));
							</c:forEach>
							
							var chart = anychart.tagCloud(data);
							var formatter = "{%value}";
							var tooltip = chart.tooltip();		
							
							chart.angles([15,90,30]);
							chart.mode('spiral');
							chart.container("kwrdcloud");
							chart.draw();	
							tooltip.format(formatter);
							
							chart.listen("pointClick", function(e) {
								
								var url = "키워드 해당 논문 경로" + e.point.get("x");
								alert(e.point.get("x"));
								console.log(e.point.get("x"));
							});

							
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