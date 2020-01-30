<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세 페이지</title>

<!--  StyleSheet_부트스트랩 사용 -->
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script
	src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>

<link href="<c:url value='/resources/css/bootstrap.css' />"
	rel="stylesheet">
<link href="<c:url value='/resources/css/_bootswatch.scss' />"
	rel="stylesheet">
<link href="<c:url value='/resources/css/_variables.scss' />"
	rel="stylesheet">

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
				image.attr("src", imgName.replace("/resources/image/up.png", "/resources/image/down.png")).attr("alt",
						"open");
			} else {
				target.slideDown(200);
				target.addClass("open");
				image.attr("src", imgName.replace("/resources/image/down.png", "/resources/image/up.png")).attr("alt",
						"close");
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
						image.attr("src", imgName.replace("/resources/image/up.png", "/resources/image/down.png"))
								.attr("alt", "open");
					} else {
						target.slideDown(200);
						target.addClass("open")
						image.attr("src", imgName.replace("/resources/image/down.png", "/resources/image/up.png"))
								.attr("alt", "close");
					}

				});
	});
</script>



</head>
<form>
	<body>

		<div id="wrap">

			<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
				<div class="container">
					<a class="navbar-brand" href="/article">Article DataParsing</a>
				</div>
			</nav>

			<div class="container">
				<div style="min-height: 500px">
					<div style="margin: 30px;">&nbsp;</div>
					 <div style="margin: 30px;">
						<div class="input-group mb-3"></div>
					</div>
					<div id="contents">

						<p style="font-size: 35px; font-weight: bold">${ArtiVO.arti_title}</p>
						<hr style="border-bottom: 0.5px dotted #b4b4b4">
						<p style="font-size: 13px">
							학술지명: <a href="#">${ArtiVO.arti_source_title}</a>
						</p>
						<p style="font-size: 13px">
							발행정보: <a href="#">${ArtiVO.arti_year},vol.${ArtiVO.arti_vol}
								<c:if test="${ArtiVO.arti_issue !=''}">, no.${ArtiVO.arti_issue}</c:if>
								<c:if test="${ArtiVO.arti_bp != '' && ArtiVO.arti_ep != ''}">, pp.${ArtiVO.arti_bp}~${ArtiVO.arti_ep}</c:if>
								,(${ArtiVO.arti_page_cnt} pages)
							</a>
						</p>
						<p style="font-size: 13px">
							DOI: <a href="#">${ArtiVO.arti_doi}</a>
						</p>

						<!-- 기관명 추가 -->
						<p style="font-size: 13px">
							기관명: <a href="#"> 기관 데이터 추가..</a>
						</p>
						<!-- 연구분야 추가 -->
						<p style="font-size: 13px">
							연구분야: <a href="#"> 기관 데이터 추가..</a> <br> <a href="#"> ${ArtiVO.arti_ctgr_name}</a>
						</p>
						<hr style="border-bottom: 0.5px dotted #b4b4b4">
						<!-- 저자 추가 -->
						<p style="font-size: 13px; color: #b4b4b4">
							<a href="#"> 저자 데이터 추가..</a>
						</p>
						<hr style="border-bottom: 0.5px dotted #b4b4b4">

						<div class="articleBody">
							<div class="box">
								<h2 style="font-size: 14px; font-weight:bold">초록 
								&emsp; &emsp; &emsp; &emsp; &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
								&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
								&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
								&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
								&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
								&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
								&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
								<img src="/resources/image/up.png" alt="close">
								</h2>
								<div class="innerBox open" style="display: block;">
									<p style="white-space: pre-line;">${ArtiVO.arti_ab}</p>
								</div>
							</div>	
							<hr style="border-bottom: 0.5px dotted #b4b4b4">
							<div class="box">
								<h2 style="font-size: 14px; font-weight:bold">키워드
								&emsp; &emsp; &emsp; &emsp; &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
								&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
								&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
								&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
								&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
								&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
								&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
								<img src="/resources/image/up.png" alt="close">
								</h2>
								<div class="innerBox open" style="display:block;">
									<div>
										<a href="#" style="font-size: 13px"> 키워드 데이터 추가..</a>
									</div>
								</div>
							</div>
							<hr style="border-bottom: 0.5px dotted #b4b4b4">	
							<div class="box">
								<h2 style="font-size: 14px; font-weight:bold">참고문헌<a href="#">(${ArtiVO.arti_cite_cnt})</a>
								&emsp; &emsp; &emsp; &emsp; &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
								&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
								&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
								&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
								&emsp;&emsp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;
								&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&emsp;&emsp;&emsp;&emsp;&emsp;
								&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&emsp;&emsp;&emsp;
								&emsp;&emsp;&emsp;&emsp;&nbsp;&nbsp;&nbsp;
								<img src="/resources/image/down.png" alt="open">
								</h2>
								<div class="innerBox" style="display:none;">
									<div style="font-size: 13px">
										참고문헌 데이터 추가..
									</div>
								</div>
								<hr style="border-bottom: 0.5px dotted #b4b4b4">
							</div>
												
						</div>
						
						<footer>
						
						</footer>

							<!--  <details>
						<summary style="font-size: 14px; font-weight: bold; color: #3c3c3c">초록</summary>
						<p>${ArtiVO.arti_ab}</p>
						</details>
						<hr style="border-bottom: 0.5px dotted #b4b4b4">
						
						<details>
						<summary style="font-size: 14px; font-weight: bold; color: #3c3c3c">키워드</summary>
						<p style="font-size: 13px; color: #b4b4b4">키워드 데이터 추가..</p>
						</details>
						<hr style="border-bottom: 0.5px dotted #b4b4b4">
						
						<details>
						<summary style="font-size: 14px; font-weight: bold; color: #3c3c3c">참고문헌(${ArtiVO.arti_cite_cnt})</summary>
						<p style="font-size: 13px; color: #b4b4b4">참고문헌 데이터 추가..</p>
						</details>-->

							<div align="left" style="margin-top: 15px; margin-bottom: 8px">
								<button type="submit" class="btn btn-primary disabled"
									formaction="/" formmethod="get">돌아가기</button>
							</div>



						</div>
					</div>
				</div>
			</div>
	</body>

	<form>
</html>