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

<!--  탭부분 수정 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- Chart.js 사용(라인, 바, 플롯, 레이더 등 사용) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.min.js"></script>
<script src="/resources/js/jquery-radar-plus.js"></script>
<script>
	$(function() {

		$("p.title span:gt(0)").css({
			"font-size" : "0.8em",
			"font-weight" : "normal"
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

		$(".articleBody h2").click(sectionToggle).keydown(function(e) {
			if (e.which == 13 || e.keyCode == 13)
				sectionToggle();
		});

		$("a.expOverseaOpen").click(
				function() {
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
</script>
</head>
<form>
<body>
		<div class="wrapper d-flex align-items-stretch">
	    <!-- 전체 메뉴 사이드바 -->
		<nav id="sidebar">
			<div class="p-4 pt-5">
				<a href="/article" class="img logo rounded-circle mb-5" style="background-image: url(/resources/image/analyticx.png);"></a>
				<ul class="list-unstyled components mb-5">
					<li class="active">
						<a href="#homeSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">메인</a>
						<ul class="collapse list-unstyled" id="homeSubmenu">
						<li class="active">
							<a href="/article">논문보기</a></li>
						</ul>
						</li>
						<li>
							<a href="#pageSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">현황</a>
							<ul class="collapse list-unstyled" id="pageSubmenu">
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
									<a href="#">키워드 현황</a>
								</li>
							</ul>
						</li>
				</ul>
				<div class="footer">
					<p>
						<script>document.write(new Date().getFullYear());</script>  About XML Parsing<i class="icon-heart" aria-hidden="true"></i>
					</p>
					<p>
						made with by JuHyeon&Minjin
						<a href="https://github.com/ghghtygh/vinea_xml.git" style="font-size: 12px" target="_blank">https://github.com/ghghtygh/vinea_xml.git</a>
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
			<div style="min-height: 500px;">
			<p style="font-size: 35px; font-weight: bold">${ArtiVO.arti_title}</p>
						<hr style="border-bottom: 0.5px dotted #b4b4b4">
						<p style="font-size: 13px; font-style: oblique;">
							<a href="#">${ArtiVO.jrnl_title}</a>
						</p>
						<p style="font-size: 13px">
							${ArtiVO.pub_year},vol.${ArtiVO.volume} <c:if test="${ArtiVO.issue !=''}">, no.${ArtiVO.issue}</c:if> <c:if test="${ArtiVO.begin_page != '' && ArtiVO.end_page != ''}">, pp.${ArtiVO.begin_page}~${ArtiVO.end_page}</c:if> ,(${ArtiVO.page_cnt} pages)
						</p>
						<p style="font-size: 13px; font-style: oblique;">
							DOI: ${ArtiVO.doi}
						</p>
						<p style="font-size: 13px">
							발행기관:
							<c:forEach var="pub" items="${ArtiVO.list_publ}" varStatus="a">
								<a href="#"> ${pub.publ_nm} </a> 
							</c:forEach>
						</p>
						<p style="font-size: 13px; font-style: oblique;">
							<c:if test="${ArtiVO.ctgry_nm != ''}">
                        <a href="#"> ${ArtiVO.ctgry_nm} </a>

								<c:if test="${not empty ArtiVO.ctgry_sub_title}">></c:if>

								<c:set var="tmp_list" value="${fn:split(ArtiVO.ctgry_sub_title,'|') }" />

								<c:forEach var="tmp" items="${tmp_list}" varStatus="g">
									<a href="#"> ${tmp} </a>
									<c:if test="${g.count !=fn:length(tmp_list) }">,</c:if>
								</c:forEach> > <c:set var="tmp_list" value="${fn:split(ArtiVO.ctgry_subject,'|') }" />
								<c:forEach var="tmp" items="${tmp_list}" varStatus="g">
									<a href="#"> ${tmp} </a>
									<c:if test="${g.count !=fn:length(tmp_list) }">,</c:if>
								</c:forEach>
							</c:if>
						</p>
						<hr style="border-bottom: 0.5px dotted #b4b4b4">

						<h2 style="font-size: 14px; font-weight: bold"></h2>
						<p style="font-size: 13px">


							<c:forEach var="auth" items="${ArtiVO.list_auth}" varStatus="a">
								<a href="#"> ${auth.auth_full_nm} <c:if test="${auth.corres_yn == 'Y' and a.count == 1}">(제 1, 교신)</c:if> <c:if test="${auth.corres_yn != 'Y' and a.count == 1}">(제 1)</c:if> <c:if test="${auth.corres_yn == 'Y' and a.count > 1}">(교신)</c:if> <c:if test="${auth.corres_yn != 'Y' and a.count > 1}"></c:if>
								</a>&nbsp;
                     </c:forEach>
							<br>
							<c:forEach var="orgn" items="${ArtiVO.list_orgn}" varStatus="o">
                            ${orgn.orgn_nm}
                            <c:if test="${(o.count != fn:length(ArtiVO.list_orgn))and fn:length(ArtiVO.list_orgn)!=0}">/</c:if>
							</c:forEach>
						</p>
						<hr style="border-bottom: 0.5px dotted #b4b4b4">

						<div class="articleBody">
							<div class="box">
								<h2 style="font-size: 14px; font-weight: bold">
									초록
									<div style="float: right;">
										<img src="/resources/image/up.png" alt="close">
									</div>
								</h2>
								<div class="innerBox open" style="display: block;">
									<p style="white-space: pre-line;">${ArtiVO.abstr}</p>
								</div>
							</div>
							<hr style="border-bottom: 0.5px dotted #b4b4b4">
							<div class="box">
								<h2 style="font-size: 14px; font-weight: bold">
									키워드
									<div style="float: right;">
										<img src="/resources/image/up.png" alt="close">
									</div>
								</h2>
								<div class="innerBox open" style="display: block;">
									<div>
										<c:if test="${empty ArtiVO.list_kwrd}">
											<p style="text-align: center; font-size: 13px">데이터가 없습니다</p>
										</c:if>
										<c:forEach var="kw" items="${ArtiVO.list_kwrd}" varStatus="k">
											<a href="#" style="font-size: 13px"> ${kw.kwrd_nm} <c:if test="${k.count !=fn:length(ArtiVO.list_kwrd) }">,</c:if>

											</a>&nbsp;
                              </c:forEach>
									</div>
								</div>
							</div>
							<hr style="border-bottom: 0.5px dotted #b4b4b4">
							<div class="box">
								<h2 style="font-size: 14px; font-weight: bold">
									참고문헌<a href="#">(${ArtiVO.cite_cnt})</a>
									<div style="float: right;">
										<img src="/resources/image/down.png" alt="open">
									</div>
								</h2>
								<div class="innerBox" style="display: none;">
									<div>
										<p style="font-size: 13px;">
											<c:if test="${empty ArtiVO.list_refr}">
												<p style="text-align: center; font-size: 13px">데이터가 없습니다</p>
											</c:if>
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

						<footer> </footer>

						<div align="left" style="margin-top: 15px; margin-bottom: 8px">
							<button type="submit" class="btn btn-primary disabled" formaction="/article" formmethod="get">돌아가기</button>
						</div>
			</div>												
	</div>	
</div>
</body>
</form>
</html>