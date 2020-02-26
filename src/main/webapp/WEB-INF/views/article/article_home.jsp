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
<script>
	var m_chk = false;

	var searchs = "${search}";
	
	/** document 로딩 시작 **/
	$(document).ready(function() {

		/** 처음 파싱 모달창에서 로딩바 숨김 **/
		$("#loading").hide();

		/** 검색한 내용 **/
		$("input[name='search']").val(searchs);
		$("#input_search").val(searchs);
		
		/** 검색 옵션(제목, 저자, 키워드) **/
		$('#search_option option[value="${search_option}"]').attr("selected",true);
		/** 정렬 옵션(UID, 발행일, 제목) **/
		$('#sort_option option[value="${sort_option}"]').attr("selected",true);
		
		$('#cnt_option option[value="${cnt_option}"]').attr("selected",true);
		
		/** 정렬하기 **/
		$("#sort_option").on('change',function(){
			
			/** 선택한 정렬 옵션 **/
			//var sort_option = $(this).val();
			
			/** 선택된 옵션에 따라 페이지를 업데이트 **/
			var formObj = $("#frm");
			formObj.attr("action", "/article");
			formObj.attr("method", "get");
			formObj.submit();
			
		});
		$("#cnt_option").on('change',function(){
			
			
			/** 선택된 옵션에 따라 페이지를 업데이트 **/
			var formObj = $("#frm");
			formObj.attr("action", "/article");
			formObj.attr("method", "get");
			formObj.submit();
			
		});
		/** 검색하기 **/
		$("#btn_search").on("click", function(e){
			e.preventDefault();
			
			/** 선택한 검색 옵션 **/
			var search = $("#input_search").val();
			
			/** 입력한 검색어 **/
			$("input[name='search']").val(search);
			
			/** 검색된 내용에 따라 페이지 업데이트 **/
			var formObj = $("#frm");
			formObj.attr("action", "/article");
			formObj.attr("method", "get");
			formObj.submit();
		});
		
		/** 알림창 닫기 **/
		$("#btn_alert_hide").on("click", function(e) {

			e.preventDefault();
			$("#div_alert").hide();

		});
		
		/** 모달 닫힐때 modal remote 데이터 지우기 **/
		$('body').on('hidden.bs.modal', '.modal', function () {
			
		    $("#insertXML").removeData('bs.modal');
		});

		/** 메인 - [XML추가]버튼 : XML 데이터 파일 추가 창 열기_BootStrap Modal 활용  **/
		$("#btn_insertXML").on("click", function(e) {

			e.preventDefault();
			
			$("#div_alert").hide();

			input_chk();

			$("#insertXML").modal({remote:"article/parsing"});
			
			
		});

		/** 파싱모달 - [저장] 버튼 : insertXML - 파싱 후, xml(논문데이터) DB 저장  **/
		$("#btn_saveXml").click(function(e) {

			e.preventDefault();

			var filePath = $("#filePath").val();

			console.log(m_chk);

			/** 파일 경로가 일치하지 않거나, 파일이 없을 때(validation 처리) **/
			if (!m_chk) {
				$("#alert_subject").html("XML 파일경로 미확인");
				$("#alert_content").html("XML 파일이 확인되지 않았습니다<br>파싱 버튼을 눌러주세요");
				$("#div_alert").show();
				return;
			}

			var result = confirm("파싱된 내용을 저장하시겠습니까?");

			/** 파싱한 결과에 따라 업데이트 되면서 저장될 수 있도록 함 **/
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

			/** 파일 경로를 입력하지 않았을 때(validation 처리) **/
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
						item_html+=item['uid']+"<br>";
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
	/** document 로딩 종료 **/
	
	/** 페이지 이동  **/
	function fn_paging(nowPage) {

		var formObj = $("#frm");
		
		var input_page = document.createElement("input");
		$(input_page).attr("type","hidden");
		$(input_page).attr("name","page");
		$(input_page).attr("value",nowPage);
		formObj.append(input_page);
		
		formObj.attr("action", "/article");
		formObj.attr("method", "get");
		formObj.submit();

	}
	
	function input_chk() {
		
		clear_input();
		m_chk = false;
		
	}
	
	
	function clear_input() {
		
		$("#div_parse").html("");
		
	}
	
	/** input 태그에서 엔터 눌렀을 때 새로고침 방지 및 제출하기 **/
	function inputKey(){
		if(event.keyCode==13){
			var search = $("#input_search").val();
			
			$("input[name='search']").val(search);
			
			var formObj = $("#frm");
			formObj.attr("action", "/article");
			formObj.attr("method", "get");
			formObj.submit();
		}else{
			return true;
		}
	}
</script>
<style>
/** 모달 창 백그라운드를 흐리게 함 **/
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

/** 사이드바 메뉴 에러 해결 **/
.list-unstyled.show.collapse.in {
	visibility: visible
}
.list-unstyled.show.collapse {
	visibility: hidden
}
.list-unstyled.show.collapsing {
	visibility: hidden
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
					<li class="active">
						<a href="#homeSubmenu" data-toggle="collapse" aria-expanded="true" class="dropdown-toggle">메인</a>
						<ul class="list-unstyled collapse show in" id="homeSubmenu">
							<li class="active">
								<a href="/article">논문보기</a></li>
						</ul>
					</li>
					<!-- 기관별 현황 페이지에서는 '현황>소속기관별 현황'을 선택상태로 둠 -->
					<li><a href="#pageSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">현황</a>
						<ul class="list-unstyled collapse show in" id="pageSubmenu">
							<li><a href="/article/yearstat">연도별 현황</a></li>
							<li><a href="/article/orgnstat">소속기관별 현황</a></li>
							<li><a href="/article/ctgrstat">분야별 현황</a></li>
							<li><a href="/article/kwrdstat">키워드 현황</a></li>
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
		<!-- 메인 페이지  -->
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
			<form id="frm" enctype="multipart/form-data">
				<!-- 검색기능 -->
				<input type="hidden" name="search" value="">
				<c:choose>
					<c:when test="${search_option==4}">
						<!-- 검색 옵션: 학술지명 -->
						<input type="hidden" name="search_option" value="4">
						<!--  정렬 옵션: UID 순 -->
						<input type="hidden" name="sort_option" value="1">
						<!-- 학술지명으로 검색하였을 때 결과 -->
						<div>
							<h5>학술지명 : ${search}</h5>
								&nbsp;총 &nbsp;${cnt }&nbsp;건&nbsp;&nbsp; 
							<a href="/">전체보기</a>
						</div>
					</c:when>
					<c:when test="${search_option==5}">
						<!-- 검색 옵션 : 저자명 -->
						<input type="hidden" name="search_option" value="5">
						<!--  정렬 옵션: UID 순 -->
						<input type="hidden" name="sort_option" value="1">
						<!-- 저자명으로 검색하였을 때 결과 -->
						<div>
							<h5>저자 : ${search}</h5>
								&nbsp;총 &nbsp;${cnt }&nbsp;건&nbsp;&nbsp; 
							<a href="/">전체보기</a>
						</div>
					</c:when>
					<c:when test="${search_option==6}">
						<!-- 검색 옵션: 기관명 -->
						<input type="hidden" name="search_option" value="6">
						<!-- 정렬 옵션: UID 순 -->
						<input type="hidden" name="sort_option" value="1">
						<!-- 기관명으로 검색하였을 때 결과 -->
						<div>
							<h5>기관명 : ${search}</h5>
							&nbsp;총 &nbsp;${cnt }&nbsp;건&nbsp;&nbsp; <a href="/">전체보기</a>
						</div>
					</c:when>
					<c:when test="${search_option==7}">
						<!-- 검색 옵션: 키워드명 -->
						<input type="hidden" name="search_option" value="7">
						<!--  정렬 옵션: UID 순 -->
						<input type="hidden" name="sort_option" value="1">
						<!--  키워드명으로 검색하였을 때 결과 -->
						<div>
							<h5>키워드명 : ${search}</h5>
								&nbsp;총 &nbsp;${cnt }&nbsp;건&nbsp;&nbsp; 
							<a href="/">전체보기</a>
						</div>
					</c:when>
					<c:otherwise>
						<div class="row">
							<div class="col-sm-7">
								<div class="form-group row">
									<div class="form-group">
										<div class="input-group mb-3">
											<div class="input-group-prepend">
												<!-- 검색 옵션: 제목, 저자, 키워드 -->
												<select class="form-control" id="search_option" name="search_option">
													<option value="1">제목</option>
													<option value="2">저자</option>
													<option value="3">키워드</option>
												</select>
											</div>
											<input type="text" class="form-control" id="input_search" onKeyDown="return inputKey()" onsubmit="return false" value="" maxlength="30">
											<div class="input-group-append">
												<button class="btn btn-primary" type="button" id="btn_search">검색</button>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="col-sm-3">
								<div class="form-group row">
									<label class="col-sm-4 col-form-label" align="right">정렬</label>
									<!-- 정렬 옵션: UID 순, 발행일순, 제목순 -->
									<select class="col-sm-8 form-control" id="sort_option" name="sort_option">
										<option value="1">UID 순</option>
										<option value="2">발행일 순</option>
										<!-- <option value="3">제목 순</option>  -->
									</select>
								</div>
							</div>
							<div class="col-sm-2">
								<!-- 
								<div class="form-group row" style="width:200px;position: relative; float: left; z-index: 10;">
									<label class="col-sm-8 col-form-label">
									페이지보기
									</label>
									<select class="col-sm-4 form-control" id="" name="">
										<option value="1">10</option>
										<option value="2">20</option>
										<option value="3">30</option>
										<option value="3">50</option>
										<option value="3">100</option>
									</select>
								</div> -->
								<select class="form-control" id="cnt_option" name="cnt_option">
									<option value="10">10개씩 보기</option>
									<option value="20">20개씩 보기</option>
									<option value="30">30개씩 보기</option>
									<option value="50">50개씩 보기</option>
									<option value="100">100개씩 보기</option>
								</select>
							</div>
						</div>
						<!-- 검색한 내용이 공백(null)이 아닐때 -->
						<c:if test="${search ne ''}">
							<div>
								<!-- 총 검색된 논문 건수 -->
								<div style="">
									<h5>검색결과 : ${cnt }건</h5>
								</div>
								<!-- 전체 논문 목록 페이지로 이동 -->
								<div style="">
									<a href="/">전체보기</a>
								</div>
							</div>
						</c:if>
					</c:otherwise>
				</c:choose>
				<div>
					<table class="table table-hover">
						<tbody>
							<!--  논문 정보가 없는지 있는지 판단 -->
							<c:choose>
								<c:when test="${not empty xmlList}">
									<c:forEach items="${xmlList}" var="ArtiVO" varStatus="g">
										<tr>
											<!-- 논문 순번 -->
											<td>
												<p class="mb-0" style="margin-top: 5px;">${ArtiVO.num}</p>
											</td>
											<td>
												<blockquote class="" style="font-size: 130%;">
													<!-- 논문 제목 클릭시, 논문상세페이지로 이동 -->
													<a class="mb-0" style="color: black;" href='article/article_detail?uid=${ArtiVO.uid}'> ${ArtiVO.arti_title} </a>
													<footer style="font-size: 70%; vertical-align: bottom;">
														<div align="left" class="text-secondary" style="margin-top: 10px;">
															&nbsp;
															<!-- 저자정보(주저자 외에 '외 ~명' 으로 표시) -->
															<c:forEach var="auth" items="${ArtiVO.list_auth}" varStatus="a">
																<c:if test="${a.count==1 }">${auth.auth_full_nm}</c:if>
															</c:forEach>
															<c:if test="${fn:length(ArtiVO.list_auth)>1}">
																<c:out value="  외  ${fn:length(ArtiVO.list_auth)-1}명 |"></c:out>
															</c:if>
															<!-- 학술지명 -->
															 ${ArtiVO.jrnl_title}
															<!-- 호번호가 공백이 아닐때 권(호)로 표시 -->
															<c:if test="${ArtiVO.issue != '' and AriVO.volume != ''}">
																| ${ArtiVO.volume}(${ArtiVO.issue}) |
															</c:if>
															<!-- 호번호가 공백일 때 권으로 표시 -->
															<c:if test="${ArtiVO.issue == '' and ArtiVO.volume != ''}">
																 | ${ArtiVO.volume} |
															</c:if>
															<!-- 시작페이지와 끝페이지가 공백이 아닐때 '시작페이지~끝페이지'로 표시 -->
															<c:if test="${ArtiVO.begin_page != '' and ArtiVO.end_page != '' and ArtiVO.issue == '' and ArtiVO.volume == ''}">
																| pp.${ArtiVO.begin_page}~${ArtiVO.end_page} |
															</c:if>
															<c:if test="${ArtiVO.begin_page == '' and ArtiVO.end_page == ''}">
															</c:if>
															<!-- 년-월-일로 표시되있는 pub_date 데이터를 '-'로 구분하여 데이터 표기  -->
															<c:set var="tmp_list" value="${fn:split(ArtiVO.pub_date,'-')}" />
															<c:forEach var="tmp" items="${tmp_list}" varStatus="g">
																<c:if test="${g.count == 2}"> ${ArtiVO.pub_year}.${tmp}</c:if>
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
										<td colspan="4" style="text-align: center">등록된 논문이 없습니다</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<!-- 페이징 처리(시작) -->
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
						<!-- 파싱 모달창으로 이동하는 부분 -->
						<div>
							<div style="position: relative; float: right; z-index: 10;">
								<button id="btn_insertXML" type="button" class="btn btn-primary">XML추가</button>
							</div>
						</div>
						
						<!-- <div>
							<div class="form-group row" style="width:200px;position: relative; float: left; z-index: 10;">
								<label class="col-sm-8 col-form-label">
								페이지보기
								</label>
								<select class="col-sm-4 form-control" id="" name="">
									<option value="1">10</option>
									<option value="2">20</option>
									<option value="3">30</option>
									<option value="3">50</option>
									<option value="3">100</option>
								</select>
							</div>
						</div> -->
					</div>
				</div>
				<!-- 페이징 처리(종료) -->
			</form>
		</div>
	</div>
	<!-- [XML추가] 모달 -->
	<div id="insertXML" class="modal">
		<div class="modal-dialog" role="document">
			<div class="modal-content"></div>
		</div>
	</div>
	<!-- / [XML추가] 모달 -->
	
<!-- JQUERY, 필요한 JAVASCRIPT 파일 -->
<script src="/resources/js/popper.js"></script>
<script src="/resources/js/main.js"></script>
</body>
</html>
