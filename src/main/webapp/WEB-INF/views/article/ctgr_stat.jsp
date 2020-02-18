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
<script>
    /** JQUERY 사용 **/
	$(document).ready(function() {
		/** 연구분야 옵션 선택 **/
	    $('#ctgrselect').change(function() {
	       var state = $('#ctgrselect option:selected').val();
	       /** 연구분야 옵션에서 전체를 제외하고 모두 연구분야 주제명을 포함하는 통계 목록을 나타나게 함 **/
	       if (state == 'artH') 
	       {
	          $('.layer2').show();
	          $('.layer1').hide();
	       } 
	       else if (state == 'lifeSc') 
	       {
	          $('.layer2').show();
	          $('.layer1').hide();
	       } 
	       else if (state == 'pysicSc') 
	       {
	          $('.layer2').show();
	          $('.layer1').hide();
	       } 
	       else if (state == 'socialSc') 
	       {
	          $('.layer2').show();
	          $('.layer1').hide();
	       } 
	       else if (state == 'tech') 
	       {
	          $('.layer2').show();
	          $('.layer1').hide();
	       } 
	       /** 연구분야 옵션중 (전체) **/
	       else 
	       {
	          $('.layer1').show();
	          $('.layer2').hide();
	       }
	    });
		
		/** 연구분야별 데이터 통계 정렬 기준 **/
	    $('#cnt2').change(function() {
	       var state = $('#cnt2 option:selected').val();
	
	    });
	    
		/** 주제별 상위 통계 분류 기준 **/
	    $('#cnt3').change(function() {
	    	var state = $('#cnt3').val();
	    	if(state == 'authcnt')
	    	{
	    		$('.authStat').show();
	    		$('.refrStat').hide();
	    		$('.artiStat').hide();
	    		$('.jrnlStat').hide();
	    	}
	    	else if(state == 'articnt')
	    	{
	    		$('.artiStat').show();
	    		$('.authStat').hide();
	    		$('.jrnlStat').hide();
	    		$('.refrStat').hide();
	    	}
	    	else if(state == 'jrnlcnt')
	    	{
	    		$('.jrnlStat').show();
	    		$('.authStat').hide();
	    		$('.artiStat').hide();
	    		$('.refrStat').hide();
	    	}
	    	else
	    	{
	    		$('.refrStat').show();
	    		$('.authStat').hide();
	    		$('.artiStat').hide();
	    		$('.jrnlStat').hide();
	    	}
	    });
	    
	 });
</script>
<style>
/** 연구분야별 데이터 통계 연구분야 선택 SelectBox **/
#ctgrselect 
{
	position: relative;
	width: 250px;
	border: 1px solid #999;
	z-index=1;
}
/** 연구분야별 데이터 통계 정렬기준 SelectBox **/
#cnt2
{
	position: relative;
	width: 170px;
	border: 1px solid #999;
	z-index=1;
}
/** 주제별 상위 통계 분류기준 SelectBox **/
#cnt3 
{
	position: relative;
	width: 170px;
	border: 1px solid #999;
	z-index=1;
}
/** 주제별 상위통계 연구분야 선택 SelectBox **/
#ctgrselect2 
{
	position: relative;
	width: 250px;
	border: 1px solid #999;
	z-index=1;
}
/** 처음 들어갔을 때, 표시 되지 않는 layer **/
.layer2, .artiStat, .jrnlStat, .refrStat 
{
	display: none;
}

#section, #article, #aside 
{
      display:block;
      width:400px;
      text-align:left;
}
#section
{
      float:left;
      width:280px;
      height:60px;
}
#article 
{
      width:500px;
}
#aside 
{
      float:left;
      margin-top: 20px;
      margin-left: 300px;
      width:800px;
      height:450px;
}
</style>
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
						<!-- 분야별 현황 페이지에서는 '현황>분야별 현황'을 선택상태로 둠 -->
						<li class="active">
							<a href="#pageSubmenu" data-toggle="collapse" aria-expanded="true" class="dropdown-toggle">현황</a>
							<ul class="list-unstyled collapse show in" id="pageSubmenu" aria-expanded="true">
								<li>
									<a href="/article/yearstat">연도별 현황</a>
								</li>
								<li>
									<a href="/article/orgnstat">소속기관별 현황</a>
								</li>
								<li class="active">
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
		<!-- 메뉴에서 분야별 현황 눌렀을때 결과 페이지  -->
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
			<section>
				<article>
				<!-- tab 정의 -->
				<ul class="nav nav-tabs">
   					<li class="nav-item">
   						<a class="nav-link active" href="#ctgr1" data-toggle="tab">연구분야별 통계</a>
   					</li>
   					<li class="nav-item">
   						<a class="nav-link" href="#ctgr2" data-toggle="tab">연구분야별 상위통계</a>
   					</li>
				</ul>
				<div class="tab-content">
				<!-- 첫번째 tab에 들어갈 내용(시작) -->
				<!-- tab 정의 부분에서의 href 속성과 동일하게 id를 각각 지정 -->
   				<div class="tab-pane active" id="ctgr1">
   				<!-- 연구분야별 데이터 통계 : 테이블 -->
   				<div id="ctgr_stat1" style="margin-top: 20px">
					<p style="font-size: 20px; font-weight: bold; color: #000069">연구분야별 데이터 통계</p>
					<div class="row">
					<div class="col-lg-12">
					<ol class="breadcrumb">
						<!-- 연구분야별로 검색 -->
						<li class="breadcrumb-item">
							<p style="font-size: 15px; font-weight: bold; margin-right: 10px; margin-left: 15px">연구분야</p>
						</li>
						<select class="form-control" id="ctgrselect" name="ctgrselect">
							<option value="" selected="selected">전체</option>
							<option value="artH">예술 및 체육</option>
							<option value="lifeSc">자연과학</option>
							<option value="pysicSc">물상과학</option>
							<option value="socialSc">사회과학</option>
							<option value="tech">공학</option>
						</select>
						<!-- 정렬 기준 선택 -->
						<li class="breadcrumb-item">
							<p style="font-size: 15px; font-weight: bold; margin-left: 20px; margin-right: 10px;">정렬</p>
						</li>
						<select class="form-control" id="cnt2">
							<option value="" selected="selected">전체</option>
							<option value="authcnt">저자</option>
							<option value="articnt">논문 수</option>
							<option value="jrnlcnt">학술지</option>
							<option value="refrcnt">참고문헌</option>
						</select>
						<p style="margin-left: 15px"></p>
						<button class="btn btn-primary" type="button">검색</button>
					</ol>
					</div>
					</div>
					<!-- 연구분야별 데이터 통계: 전체 -->
					<div class="row">
					<div class="col-lg-12">
					<div class="layer1">
						<table style="text-align: center;" class="table table-hover">
						<tbody>
							<!-- 전체 분야별 데이터 통계 들어갈 부분 -->
							<th style="border-top: 2px solid #000069">분야명</th>
							<th style="border-top: 2px solid #000069">저자</th>
							<th style="border-top: 2px solid #000069">논문 수</th>
							<th style="border-top: 2px solid #000069">학술지</th>
							<th style="border-top: 2px solid #000069">참고문헌</th>
							<tr>
							<td style="border-top: 1px solid #b4b4b4">
								<a href="#">분야명 데이터</a>
							</td>
							<td style="border-top: 1px solid #b4b4b4">0</td>
							<td style="border-top: 1px solid #b4b4b4">0</td>
							<td style="border-top: 1px solid #b4b4b4">0</td>
							<td style="border-top: 1px solid #b4b4b4">0</td>
							</tr>
						</tbody>
						</table>
					</div>
					<!-- 연구분야별 데이터 통계: 분야별 -->
					<div class="layer2">
						<table style="text-align: center;" class="table table-hover">
						<tbody>
							<!-- 분야별 데이터 통계 들어갈 부분 -->
							<th style="border-top: 2px solid #000069">분야명</th>
							<th style="border-top: 2px solid #000069">주제명</th>
							<th style="border-top: 2px solid #000069">저자</th>
							<th style="border-top: 2px solid #000069">논문 수</th>
							<th style="border-top: 2px solid #000069">학술지</th>
							<th style="border-top: 2px solid #000069">참고문헌</th>
							<tr>
							<td style="border-top: 1px solid #b4b4b4">
								<a href="#">분야명 데이터</a>
							</td>
							<td style="border-top: 1px solid #b4b4b4">
								<a href="#">주제명 데이터</a>
							</td>
							<td style="border-top: 1px solid #b4b4b4">0</td>
							<td style="border-top: 1px solid #b4b4b4">0</td>
							<td style="border-top: 1px solid #b4b4b4">0</td>
							<td style="border-top: 1px solid #b4b4b4">0</td>
							</tr>
						</tbody>
						</table>
					</div>
					</div>
					</div>
				</div>
   				</div>
   				<!-- 첫번째 tab에 들어갈 내용(끝) -->
   				<!-- 두번째 tab에 들어갈 내용(시작) -->
  				<div class="tab-pane" id="ctgr2">
  				<!-- 연구분야의 주제별 상위 통계 : 테이블, 차트 -->
  				<div id="ctgr_stat2" style="margin-top: 20px">
					<p style="font-size: 20px; font-weight: bold; color: #000069">연구분야별 상위 통계</p>
					<div class="row">
					<div class="col-lg-12">
					<ol class="breadcrumb">
						<!-- 분야별 조회 -->
						<li class="breadcrumb-item">
							<p style="font-size: 15px; font-weight: bold; margin-right: 10px; margin-left: 15px">연구분야</p>
						</li>
						<select class="form-control" id="ctgrselect2" name="ctgrselect2">
							<option value="artH">예술 및 체육</option>
							<option value="lifeSc">자연과학</option>
							<option value="pysicSc">물상과학</option>
							<option value="socialSc">사회과학</option>
							<option value="tech">공학</option>
						</select>
						<!-- (보고자 하는  통계) 조회 기준 -->
						<li class="breadcrumb-item">
							<p style="font-size: 15px; font-weight: bold; margin-left: 20px; margin-right: 10px;">분류</p>
						</li>
						<select class="form-control" id="cnt3">
							<option value="authcnt">저자</option>
							<option value="articnt">논문 수</option>
							<option value="jrnlcnt">학술지</option>
							<option value="refrcnt">참고문헌</option>
						</select>
					</ol>
					</div>
					</div>
						<!-- 연구분야의 주제별 상위 통계: 테이블 부분 -->
						<!-- 저자수 통계 -->
						<div class="row">
						<div class="col-lg-5">
							<table style="text-align: center;" class="table table-hover">
							<tbody>
								<th style="border-top: 2px solid #000069">분야명</th>
								<th style="border-top: 2px solid #000069">주제명</th>
								<th style="border-top: 2px solid #000069">저자</th>
								<tr>
								<td style="border-top: 1px solid #b4b4b4">
									<a href="#">분야명 데이터</a>
								</td>
								<td style="border-top: 1px solid #b4b4b4">
									<a href="#">주제명 데이터</a>
								</td>
								<td style="border-top: 1px solid #b4b4b4">
									<a href="#">0</a>
								</td>									
								</tr>
							</tbody>
							</table>
						<!-- 논문수 통계 -->
						<div class="artiStat">
							<table style="text-align: center;" class="table table-hover">
							<tbody>
								<th style="border-top: 2px solid #000069">분야명</th>
								<th style="border-top: 2px solid #000069">주제명</th>
								<th style="border-top: 2px solid #000069">논문 수</th>
								<tr>
								<td style="border-top: 1px solid #b4b4b4">
									<a href="#">분야명 데이터</a>
								</td>
								<td style="border-top: 1px solid #b4b4b4">
									<a href="#">주제명 데이터</a>
								</td>
								<td style="border-top: 1px solid #b4b4b4">
									<a href="#">0</a>
								</td>									
								</tr>
							</tbody>
							</table>
						</div>
						<!-- 학술지수 통계 -->
						<div class="jrnlStat">
							<table style="text-align: center;" class="table table-hover">
							<tbody>
								<th style="border-top: 2px solid #000069">분야명</th>
								<th style="border-top: 2px solid #000069">주제명</th>
								<th style="border-top: 2px solid #000069">학술지</th>
								<tr>
								<td style="border-top: 1px solid #b4b4b4">
									<a href="#">분야명 데이터</a>
								</td>
								<td style="border-top: 1px solid #b4b4b4">
									<a href="#">주제명 데이터</a>
								</td>
								<td style="border-top: 1px solid #b4b4b4">
									<a href="#">0</a>
								</td>									
								</tr>
							</tbody>
							</table>
						</div>
						<!-- 참고문헌 수 통계 -->
						<div class="refrStat">
							<table style="text-align: center;" class="table table-hover">
							<tbody>
								<th style="border-top: 2px solid #000069">분야명</th>
								<th style="border-top: 2px solid #000069">주제명</th>
								<th style="border-top: 2px solid #000069">참고문헌</th>
								<tr>
								<td style="border-top: 1px solid #b4b4b4">
									<a href="#">분야명 데이터</a>
								</td>
								<td style="border-top: 1px solid #b4b4b4">
									<a href="#">주제명 데이터</a>
								</td>
								<td style="border-top: 1px solid #b4b4b4">
									<a href="#">0</a>
								</td>									
								</tr>
							</tbody>
							</table>
						</div>
						</div>
						<!-- 연구분야의 주제별 상위 통계를 보여줄 차트 캔버스 정의 -->
						<div class="col-lg-7">
						<canvas id="ctgr" width="800" height="450"></canvas>
						</div>
						</div>
						<script>
							var myChart = new Chart(document.getElementById("ctgr"), {
								    type: 'bar',
								    data: {
								      /** 해당 연구분야의 주제명 **/
								      labels: ["주제1", "주제2", "주제3", "주제4", "주제5", "주제6", "주제7", "주제8", "주제9", "주제10"],
								      /** 실제 데이터가 들어갈 부분 **/
								      datasets: [{
								    	  /** 분류 기준(라벨) **/
								          label: "저자수",
								          type: "line",
								          borderColor: "#8e5ea2",
								          /** 실제 통계 수치 **/
								          data: [250, 250, 300, 320, 400, 480, 500, 530, 550, 600],
								          fill: false,
								        },{
								          label: "저자수",
								          type: "bar",
								          backgroundColor: "rgba(102,153,255,0.5)",
								          data: [250, 250, 300, 320, 400, 480, 500, 530, 550, 600],
								        }]
								    },
								    options: {
								      responsive: true,
								      scales: {
						                    yAxes: [{
						                        stacked: true,
						                        ticks: {
						                        }
						                     }],
						                     xAxes: [{
						                         stacked: true,
						                        ticks: {
						                        }
						                     }]
						                },
						                showValue: {
						                	fontSize: 15,
						                	fontStyle: 'Helvetica'
						                },
						                animation: false
						                ,
								      	legend: { display: false }
								    }
								});
						</script>
  						</div>
					</div>	
				</article>
			</section>
		</div>
	</div>
<!-- JQUERY, 필요한 JAVASCRIPT 파일 -->		
<script src="/resources/js/jquery.min.js"></script>
<script src="/resources/js/popper.js"></script>
<script src="/resources/js/bootstrap.min.js"></script>
<script src="/resources/js/main.js"></script>
</body>
</html>