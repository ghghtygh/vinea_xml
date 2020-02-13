<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
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
	var m_chk = false;

	$(document).ready(function() {

		$("#loading").hide();

		/** 알림창 닫기 **/
		$("#btn_alert_hide").on("click", function(e) {

			e.preventDefault();
			$("#div_alert").hide();

		});

		$('body').on('hidden.bs.modal', '.modal', function() {

			//console.log("모달 닫힘");
			//$(this).find('.modal-content').empty();
			$("#insertXML").removeData('bs.modal');
		});

		/** 메인 - [XML추가]버튼 : XML 데이터 파일 추가 창 열기_BootStrap Modal 활용  **/
		$("#btn_insertXML").on("click", function(e) {

			e.preventDefault();

			$("#div_alert").hide();

			input_chk();

			//$("#insertXML").modal();
			$("#insertXML").modal({
				remote : "article/parsing"
			});

		});

		/** 파싱모달 - [저장] 버튼 : insertXML - 파싱 후, xml(논문데이터) DB 저장  **/
		$("#btn_saveXml").click(function(e) {

			e.preventDefault();

			var filePath = $("#filePath").val();

			console.log(m_chk);

			if (!m_chk) {

				$("#alert_subject").html("XML 파일경로 미확인");
				$("#alert_content").html("XML 파일이 확인되지 않았습니다<br>파싱 버튼을 눌러주세요");
				$("#div_alert").show();
				return;
			}

			var result = confirm("파싱된 내용을 저장하시겠습니까?");

			if (result) {

				var formObj = $("#frm");
				formObj.attr("action", "/article/insert");
				formObj.attr("method", "post");
				formObj.submit();
			}

		});

		/** insertXml: ArtiParser.java에서 파싱코드 가져와서 xml(논문)데이터 파싱 **/
		$("#btn_chk").click(function(e) {

			$("#loading").show();

			e.preventDefault();

			clear_input();

			var filePath = $("#filePath").val();

			if (filePath == "") {

				$("#alert_subject").html("XML 경로 미입력");
				$("#alert_content").html("XML 경로를 입력하지 않았습니다");
				$("#div_alert").show();
				m_chk = false;
				return;
			}
			$("#div_alert").hide();

			$.ajax({
				async : true,
				url : "${pageContext.request.contextPath}/article/check",
				type : 'POST',
				data : {
					"filePath" : filePath
				},
				dataType : "json",
				success : function(data) {

					if (data == null) {

						$("#alert_subject").html("XML 파싱 실패");
						$("#alert_content").html("올바른 XML파일 경로를 입력하세요");
						$("#div_alert").show();
						m_chk = false;
						return;
					}

					var item_html = "";

					$.each(data, function(index, item) {
						item_html += item['uid'] + "<br>";
					});

					m_chk = true;

					$("#div_parse").html(item_html);

					$("#loading").hide();

				},
				error : function(request, error) {

					$("#alert_subject").html("XML 파싱 실패");
					$("#alert_content").html("올바른 XML파일 경로를 입력하세요");
					$("#div_alert").show();
					m_chk = false;
					return;
				}
			});

		});

	});

	/** 페이지 이동  **/
	function fn_paging(nowPage) {

		var url = "/article?page=" + nowPage;

		location.href = url;

	}
	function input_chk() {

		clear_input();

		m_chk = false;

	}
	function clear_input() {
		$("#div_parse").html("");

	}
</script>


<style>
.modal-backdrop {
	position: fixed;
	top: 0;
	right: 0;
	bottom: 0;
	left: 0;
	z-index: 1030;
	background-color: #333333;
	opacity: 0.8;
}

input:read-only {
	border: 0px;
	width: 100%;
}

a {
	
}

#page-wrapper {
	padding-left: 250px;
}

#sidebar-wrapper {
	position: fixed;
	width: 250px;
	height: 100%;
	margin-left: -250px;
	background: #000;
	overflow-x: hidden;
	overflow-y: auto;
}

#page-content-wrapper {
	width: 100%;
	padding: 20px;
}
</style>

</head>
<body>
<form id="frm" enctype="multipart/form-data">
	<div class="wrapper d-flex align-items-stretch">
	    <!-- 전체 메뉴 사이드바 -->
		<nav id="sidebar">
			<div class="p-4 pt-5">
				<a href="/article" class="img logo rounded-circle mb-5" style="background-image: url(/resources/image/analyticx.png);"></a>
				<ul class="list-unstyled components mb-5">
					<li class="active">
						<a href="#homeSubmenu" data-toggle="collapse" aria-expanded="true" class="dropdown-toggle">메인</a>
						<ul class="list-unstyled collapse show in" id="homeSubmenu" aria-expanded="true">
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
				<!-- 논문 목록 -->
						<div style="min-height: 500px;">
							<table class="table table-hover">
								<tbody>
									<!--  논문 목록이 비어있을때, 없을때를 구분하여 화면에 출력을 다르게 한다 -->
									<c:choose>
										<c:when test="${not empty xmlList}">
											<c:forEach items="${xmlList}" var="ArtiVO" varStatus="g">
												<tr>
													<td>
														<p class="mb-0" style="margin-top: 5px;">${ArtiVO.arti_no}</p>
													</td>
													<td>
														<blockquote class="" style="font-size: 130%;">

															<!-- 논문 제목 클릭시, 논문상세페이지로 이동 -->
															<a class="mb-0" style="color: black;" href='article/article_detail?uid=${ArtiVO.uid}'> ${ArtiVO.arti_title} </a>
															<footer class="" style="font-size: 70%; vertical-align: bottom;">

																<!--  저자정보 추가예정, 학회정보 추가예정, 권(호), 시작~끝페이지, 발행일자, 연구분야 추가예정 -->


																<div align="left" class="text-secondary" style="margin-top: 10px;">
																	&nbsp;
																	<c:forEach var="auth" items="${ArtiVO.list_auth}" varStatus="a">

																		<c:if test="${a.count==1 }">${auth.auth_full_nm}</c:if>

																	</c:forEach>

																	<c:if test="${fn:length(ArtiVO.list_auth)>1}">
																		<c:out value="  외  ${fn:length(ArtiVO.list_auth)-1}명 "></c:out>
																	</c:if>


																	| ${ArtiVO.jrnl_title} |
																	<c:if test="${ArtiVO.issue != ''}">
																	 ${ArtiVO.volume}(${ArtiVO.issue}) 
																	</c:if>

																	<c:if test="${ArtiVO.issue == ''}">
																	${ArtiVO.volume} 
																	</c:if>
																	<c:if test="${ArtiVO.begin_page != '' && ArtiVO.end_page != ''}">
																	| 
																	pp.${ArtiVO.begin_page}~${ArtiVO.end_page}
																	|
																	</c:if>
																	<c:set var="tmp_list" value="${fn:split(ArtiVO.pub_date,'-')}" />

																	<c:forEach var="tmp" items="${tmp_list}" varStatus="g">
																		<c:if test="${g.count == 2}">${ArtiVO.pub_year}.${tmp}</c:if>
																	</c:forEach>
																</div>
															</footer>
														</blockquote>
													</td>
												</tr>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<tr>
												<td style="text-align: center">등록된 논문이 없습니다</td>
											</tr>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
						</div>
				<!-- 페이징 처리  -->
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
						<div>
							<div style="position: relative; float: right; z-index: 10;">
								<button id="btn_insertXML" class="btn btn-primary">XML 추가</button>
							</div>
						</div>
					</div>
				</div>
				<!-- / 페이징처리 -->
				<!-- [XML추가] 모달 -->
				<div id="insertXML" class="modal">
					<div class="modal-dialog" role="document">
						<div class="modal-content"></div>
					</div>
				</div>
				<!-- / [XML추가] 모달 -->
	</div>	
	</div>
</form>
<script src="/resources/js/jquery.min.js"></script>
<script src="/resources/js/popper.js"></script>
<script src="/resources/js/bootstrap.min.js"></script>
<script src="/resources/js/main.js"></script>
</body>
</html>