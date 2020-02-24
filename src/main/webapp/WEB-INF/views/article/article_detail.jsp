<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세 페이지</title>
<!-- JQUERY, JAVASCRIPT -->
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
	
<!--  CSS -->
<link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800,900" rel="stylesheet">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/resources/css/style.css">
<link href="/resources/css/_bootswatch.scss" rel="stylesheet">
<link href="/resources/css/_variables.scss" rel="stylesheet">

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

/** 사이드바 메뉴 에러 해결 **/
.list-unstyled.show.collapse.in{
	visibility:visible
}
.list-unstyled.show.collapse{
	visibility:hidden
}
.list-unstyled.show.collapsing{
	visibility:hidden
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
		
		if(confirm(title + "학술지의 논문 목록을 보시겠습니까?") == true)
		{
		formObj.attr("action", "/article");
		formObj.attr("method", "get");
		formObj.submit();
		}
		else
			{
				return false;
			}
	}
	
	/** 상세보기 페이지에서 저자명을 클릭하였을 때, 그 저자에 해당하는 논문 목록페이지로 이동 **/
	function search_auth(auth){
		
		$("input[name='search']").val(auth);
		$("input[name='search_option']").val(5);
		
		var formObj = $("#frm");
		if(confirm(auth + "의 논문 목록을 보시겠습니까?") == true)
		{
		formObj.attr("action", "/article");
		formObj.attr("method", "get");
		formObj.submit();
		}
		else
			{
			return false;
			}
		
	}
	
	/** 연구분야를 클릭하였을 때, 연구분야 동향페이지로 이동 전에 alert창으로 물어본다 **/
	function goCtgrStat()
	{
		if(confirm("연구분야 동향을 확인해보시겠습니까?") == true)
			{
				location.href = '/article/ctgrstat';
			}
		else
			{
				return false;
			}
	}
</script>
</head>
<form id="frm">
	<body>
		<!-- 검색 기능을 위한 hidden 정의 -->
		<input type="hidden" name="search" value="">
		<input type="hidden" name="search_option" value="">
		<div class="wrapper d-flex align-items-stretch">
	    <!-- 전체 메뉴 사이드바 -->
		<nav id="sidebar">
			<div class="p-4 pt-5">
				<a href="/article" class="img logo rounded-circle mb-5" style="background-image: url(/resources/image/analyticx.png);"></a>
				<ul class="list-unstyled components mb-5">
					<!-- 상세페이지: 논문보기 메뉴를 선택 상태로 둠 -->
					<li class="active">
						<a href="#homeSubmenu" data-toggle="collapse" aria-expanded="true" class="dropdown-toggle">메인</a>
						<ul class="list-unstyled collapse show in" id="homeSubmenu" aria-expanded="true">
							<li class="active">
								<a href="/article">논문보기</a>
							</li>
						</ul>
					</li>
						<!-- 사이드바 메뉴: 현황 메뉴 -->
						<li>
							<a href="#pageSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">현황</a>
							<ul class="list-unstyled collapse show in" id="pageSubmenu" aria-expanded="false">
								<li>
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
		<!-- 상세 페이지  -->
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
					<!-- 연구분야: 주제목 -->
					<p style="font-size: 13px; font-style: oblique;">
					<c:if test="${ArtiVO.ctgry_nm != ''}">
						<a href="javascript:goCtgrStat()" class="tip"> ${ArtiVO.ctgry_nm}
							<span>연구분야 동향<br>Click</span>
						</a>
						<!-- 연구분야: 소제목 -->
						<c:if test="${not empty ArtiVO.ctgry_sub_title}">></c:if>
						<!-- DB에 저장된 소제목 데이터가  | 구분자로 저장됨: jstl문법의 split 메소드를 사용하여 잘라냄 -->
						<c:set var="tmp_list" value="${fn:split(ArtiVO.ctgry_sub_title,'|') }" />
						<c:forEach var="tmp" items="${tmp_list}" varStatus="g">
							<a href="javascript:goCtgrStat()" class="tip"> ${tmp}
								<span>연구분야 동향<br>Click</span>
							</a>
							<c:if test="${g.count !=fn:length(tmp_list) }">,</c:if>
						</c:forEach> > 
						<!-- DB에 저장된 주제 데이터가  | 구분자로 저장됨: jstl문법의 split 메소드를 사용하여 잘라냄 -->
						<c:set var="tmp_list" value="${fn:split(ArtiVO.ctgry_subject,'|') }" />
						<c:forEach var="tmp" items="${tmp_list}" varStatus="g">
							<a href="/article/ctgrstat" class="tip"> ${tmp}
								<span>연구분야 동향<br>Click</span>
							</a>
							<c:if test="${g.count !=fn:length(tmp_list) }">,</c:if>
						</c:forEach>
					</c:if>
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
		</div>
	</body>
<!-- JQUERY, 필요한 JAVASCRIPT 파일 -->	
<script src="/resources/js/popper.js"></script>
<script src="/resources/js/main.js"></script>
<form>
</html>