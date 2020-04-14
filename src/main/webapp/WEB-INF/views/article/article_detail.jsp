<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>상세 페이지</title>
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
<style>
/** tootip 스타일 적용 **/
a.tip {
	position: relative;
}
a.tip span {
	display: none;
	position: absolute;
	top: 20px;
	left: -10px;
	width: 125px;
	padding: 5px;
	z-index: 100;
	background: #464646;
	text-align: center; 
	color : #fff;
	font-style: oblique;
	-moz-border-radius: 7px; 
	-webkit-border-radius: 5px;
}

/** 마우스를 올려놓았을 때, tooltip이 나타남 **/
a:hover.tip span {
	display: block;
}
</style>
<script>
	/** 초록, 키워드, 참고문헌  요약보기, 상세보기 기능 **/	
	$(document).ready(function() {

		$("p.title span:gt(0)").css({
			"font-size" : "0.8em",
			"font-weight" : "normal"
		});

		/** open, close 일때 이미지를 변경시키면서 요약,상세를 표시 **/
		/** slideUp과 slideDown 메소드를 사용하여 요약,상세 기능 **/
		$(".articleBody h2").click(sectionToggle).keydown(function(e) {

			if (e.which == 13 || e.keyCode == 13)
				sectionToggle();
		});

		$("a.expOverseaOpen").click(function() {
			var target = $(this).closet("p").next("p.expOversea");
			var image = $(this).find("img");
			var imgName = image.attr("src");
			if (target.hasClass("open")) {
				target.slideUp(200);
				target.removeClass("open");
				image.attr(
						"src",
						imgName.replace("/resources/image/up.png",
								"/resources/image/down.png")).attr(
						"alt", "open");
			} else {
				target.slideDown(200);
				target.addClass("open")
				image.attr(
						"src",
						imgName.replace("/resources/image/down.png",
								"/resources/image/up.png")).attr("alt",
						"close");
			}

		});
		
	});
	
	function sectionToggle() {
		
		var target = $(this).parents(".box").find(".innerBox");
		var image = $(this).find("img");
		var imgName = image.attr("src");
		if (target.hasClass("open")) {
			target.slideUp(200);
			target.removeClass("open");
			image.attr(
					"src",
					imgName.replace("/resources/image/up.png",
							"/resources/image/down.png")).attr("alt",
					"open");
		} else {
			target.slideDown(200);
			target.addClass("open");
			image.attr(
					"src",
					imgName.replace("/resources/image/down.png",
							"/resources/image/up.png"))
					.attr("alt", "close");
		}

	}
	
	/** 상세보기 페이지에서 학술지명을 클릭하였을 때, 학술지명에 해당하는 논문 목록페이지로 이동 **/
	function search_jrnl(title){
		
		$("input[name='search']").val(title);
		$("input[name='search_option']").val(4);
		
		var formObj = $("#frm");
		
		formObj.attr("action", "/article");
		formObj.attr("method", "get");
		formObj.submit();

	}
	
	/** 상세보기 페이지에서 저자명을 클릭하였을 때, 그 저자에 해당하는 논문 목록페이지로 이동 **/
	function search_auth(auth){
		
		$("input[name='search']").val(auth);
		$("input[name='search_option']").val(5);
		
		var formObj = $("#frm");
		
		formObj.attr("action", "/article");
		formObj.attr("method", "get");
		formObj.submit();
	}
</script>
</head>
<form id="frm">
<body class="sb-nav-fixed">
	<!-- 검색 기능을 위한 hidden 정의 -->
	<input type="hidden" name="search" value="">
	<input type="hidden" name="search_option" value="">
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
							<a style="font-weight: bold; color: #fff" class="nav-link" href="/">
								<div class="sb-nav-link-icon">
									<i class="far fa-sticky-note"></i>
								</div>
								논문보기
							</a>
						<div class="sb-sidenav-menu-heading" style="color: #fff">Statics</div>
							<a class="nav-link" href="/stat/year">
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
					<!-- 논문 제목 -->
					<p style="font-size: 35px; font-weight: bold">${ArtiVO.arti_title}</p>
					<hr style="border-bottom: 0.5px dotted #b4b4b4">
					<!-- 학술지 명 -->
					<p style="font-size: 13px; font-style: oblique;">
						<a href="#" class="tip" onClick="search_jrnl('${ArtiVO.jrnl_title}')"> ${ArtiVO.jrnl_title}
							<span>해당 학술지 논문<br>Click</span>
						</a>
					</p>
					<!-- 발행정보: 발행연도, 권(호), 시작~종료페이지, 페이지수 -->
					<p style="font-size: 13px; font-style: oblique;">
						${ArtiVO.pub_year},vol.${ArtiVO.volume}
						<c:if test="${ArtiVO.issue !=''}">, no.${ArtiVO.issue}</c:if>
						<c:if test="${ArtiVO.begin_page != '' && ArtiVO.end_page != ''}">, pp.${ArtiVO.begin_page}~${ArtiVO.end_page}</c:if>
						,(${ArtiVO.page_cnt} pages)
					</p>
					<!-- DOI -->
					<p style="font-size: 13px; font-style: oblique;">DOI: ${ArtiVO.doi}</p>
					<!-- 발행기관 -->
					<p style="font-size: 13px; font-style: oblique;">
						발행기관: <c:forEach var="pub" items="${ArtiVO.list_publ}" varStatus="a">
									 ${pub.publ_nm}
								</c:forEach>
					</p>
					<!-- 연구분야 -->
					<p style="font-size: 13px; font-style: oblique;">
						연구분야:
						
						<c:forEach var="ctgry" items="${ArtiVO.list_ctgry}" varStatus="a">
							<c:choose>
								<c:when test="${a.count==1}">
									<!-- 연구분야: 주제목 -->	
									<a href="/stat/ctgr" class="tip"> ${ctgry.ctgry_nm}
											<span>연구분야 동향<br>Click</span>
									</a>
									<!-- 연구분야: 소제목 -->
									<c:if test="${not empty ctgry.ctgry_sub_title}">
										&gt;
										<a href="/stat/ctgr" class="tip"> ${fn:split(ctgry.ctgry_sub_title,'|')[0]}
											<span>연구분야 동향<br>Click</span>
										</a>
									</c:if>
									&gt;
									<a href="/stat/ctgr" class="tip"> ${ctgry.ctgry_subject}
										<span>연구분야 동향<br>Click</span>
									</a>
								</c:when>
								<c:otherwise>
									,
									<a href="/stat/ctgr" class="tip"> ${ctgry.ctgry_subject}
										<span>연구분야 동향<br>Click</span>
									</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</p>
					
					<hr style="border-bottom: 0.5px dotted #b4b4b4">
					<!-- 저자정보 -->
					<p style="font-size: 13px; font-style: oblique;">
					<c:forEach var="auth" items="${ArtiVO.list_auth}" varStatus="a">
						<a href="#" class="tip" onClick="search_auth('${auth.auth_full_nm}')"> ${auth.auth_full_nm}
							<!-- 1번째 오는 저자가 제1(주 저자) 임을 표시함 -->
							<!-- 교신 여부를 파악하여 교신 저자인경우는 교신이라 표시해줌 -->
							<c:if test="${auth.corres_yn == 'Y' and a.count == 1}">(주저자, 교신)</c:if> 
							<c:if test="${auth.corres_yn != 'Y' and a.count == 1}">(주저자)</c:if> 
							<c:if test="${auth.corres_yn == 'Y' and a.count > 1}">(교신)</c:if> 
							<c:if test="${auth.corres_yn != 'Y' and a.count > 1}"></c:if>
							<span>해당 저자 논문<br>Click</span>
						</a>&nbsp;
                     </c:forEach>
					 <br>
					 <!-- 소속기관 정보 -->
					 <c:forEach var="orgn" items="${ArtiVO.list_orgn}" varStatus="o">
                         ${orgn.orgn_nm}
                         <c:if test="${(o.count != fn:length(ArtiVO.list_orgn))and fn:length(ArtiVO.list_orgn)!=0}">/</c:if>
					 </c:forEach>
					</p>
					<hr style="border-bottom: 0.5px dotted #b4b4b4">
					<div class="articleBody">
						<!-- 초록 -->
						<div class="box">
							<h2 style="font-size: 14px; font-weight: bold">
								초록
								<!-- 초록 내용을 볼 수 있는 화살표 이미지 오른쪽에 배치 -->
								<div style="float: right;">
									<img src="/resources/image/up.png" alt="close">
								</div>
							</h2>
							<div class="innerBox open" style="display: block;">
								<p style="white-space: pre-line;">${ArtiVO.abstr}</p>
							</div>
						</div>
						<hr style="border-bottom: 0.5px dotted #b4b4b4">
						<!-- 키워드 -->
						<div class="box">
							<h2 style="font-size: 14px; font-weight: bold">
								키워드
								<!-- 키워드 데이터를 볼 수 있는 화살표 이미지 오른쪽에 배치 -->
								<div style="float: right;">
									<img src="/resources/image/up.png" alt="close">
								</div>
							</h2>
							<!-- 키워드 데이터 -->
							<div class="innerBox open" style="display: block;">
								<div>
									<!-- 키워드 데이터가 없는 경우 -->
									<c:if test="${empty ArtiVO.list_kwrd}">
										<p style="text-align: center; font-size: 13px">데이터가 없습니다</p>
									</c:if>
									<!-- 키워드 데이터가 있는 경우(각 키워드를 ,로 구분함) -->
									<c:forEach var="kw" items="${ArtiVO.list_kwrd}" varStatus="k">
										<a  style="font-size: 13px"> ${kw.kwrd_nm}  
											<c:if test="${k.count !=fn:length(ArtiVO.list_kwrd) }">,</c:if>
										</a>&nbsp;
                              		</c:forEach>
								</div>
							</div>
						</div>
						<hr style="border-bottom: 0.5px dotted #b4b4b4">
						<!-- 참고문헌 -->
						<div class="box">
							<h2 style="font-size: 14px; font-weight: bold">
								참고문헌
							<!-- 참고문헌 수 -->
							<a href="#" id="refrcnt" class="tip">
								(${ArtiVO.cite_cnt})
								<span>참고문헌수<br>${ArtiVO.cite_cnt}건</span>
							</a>
								<!-- 키워드 데이터를 볼 수 있는 화살표 이미지 오른쪽에 배치 -->
								<div style="float: right;">
									<img src="/resources/image/down.png" alt="open">
								</div>
							</h2>
							<!-- 참고문헌 목록 -->
							<div class="innerBox" style="display: none;">
								<div>
									<p style="font-size: 13px; font-style: oblique;">
										<!-- 참고문헌 데이터가 없는 경우 -->
										<c:if test="${empty ArtiVO.list_refr}">
											<p style="text-align: center; font-size: 13px">데이터가 없습니다</p>
										</c:if>
										<!-- 참고문헌 나타낼 정보 : 순번. 저자 / 발행연도 / 논문제목 / 권(호) / 소속기관명 / 인용페이지 -->
										<c:forEach var="refr" items="${ArtiVO.list_refr}" varStatus="rf">
			                                    ${rf.count}. &nbsp; ${refr.author} / ${refr.pub_year} / ${refr.arti_title} 
			                                    <c:if test="${refr.issue == '' and refr.volume != ''}">
			                                       / ${refr.volume} : 
			                                    </c:if>
											<c:if test="${refr.issue != '' and refr.volume != ''}">
			                                       / ${refr.volume} (${refr.issue}) :
			                                    </c:if>
											<c:if test="${refr.page == '' and refr.orgn_nm != ''}">
			                                       ${refr.orgn_nm}
			                                    </c:if>
											<c:if test="${refr.page != ''}">
			                                       ${refr.page} / ${refr.orgn_nm}
			                                    </c:if>
											<br>
										</c:forEach>
									</p>
								</div>
							</div>
							<hr style="border-bottom: 0.5px dotted #b4b4b4">
						</div>
					</div>
				</div>
			</main> 
		</div>   
	</div>
<script src="/resources/js/scripts.js"></script>
</body>
</form>
</html>