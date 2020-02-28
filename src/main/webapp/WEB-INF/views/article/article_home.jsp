<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>메인페이지</title>
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
<!-- 파싱, DB, 검색, 정렬  -->
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
		
		/** 정렬하기(UID순, 발행일순) **/
		$("#sort_option").on('change',function(){
			
			/** 선택된 옵션에 따라 페이지를 업데이트 **/
			var formObj = $("#frm");
			formObj.attr("action", "/article");
			formObj.attr("method", "get");
			formObj.submit();
			
		});
		
		/** 목록에 보여질 논문건수 선택 **/
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
							<a style="font-weight: bold; color: #fff" class="nav-link" href="/article">
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
							<a class="nav-link" href="/article/kwrdstat">
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
						<div style="margin-top: 45px">
							<p style="font-size: 30px; font-weight: bold; color: #000069; margin-top: 50px">논문 목록</p>						
						</div>
						<hr>                     
						<!-- 검색기능 -->
						<input type="hidden" name="search" value="">
						<fmt:parseNumber value="${search_option}" var="so"/>
						<c:choose>
							<c:when test="${so >= 4 }">
								<input type="hidden" name="search_option" value="${search_option}">
								<input type="hidden" name="sort_option" value="1">
								<div>
									<div class="form-inline">
									<c:choose>
										<c:when test="${search_option==4}">
											<h5>학술지명 : ${search}</h5>
										</c:when>
										<c:when test="${search_option==5}">
											<h5>저자 : ${search}</h5>
										</c:when>
										<c:when test="${search_option==6}">
											<h5>기관명 : ${search}</h5>
										</c:when>
										<c:when test="${search_option==7}">
											<h5>키워드명 : ${search}</h5>
										</c:when>
									</c:choose>
									</div>
									<div style="margin-bottom: 20px">
										&nbsp;총 &nbsp;<strong><fmt:formatNumber value="${cnt}" pattern="#,###,###"/></strong>&nbsp;건&nbsp;&nbsp; <a href="/">전체보기</a>
										<select class="form-control" style="float: right; width: 150px;" id="cnt_option" name="cnt_option">
											<option value="10">10건</option>
											<option value="20">20건</option>
											<option value="30">30건</option>
											<option value="50">50건</option>
											<option value="100">100건</option>
										</select>
									</div>
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
											</select>
										</div>
									</div>
									<div class="col-sm-2">
										<select class="form-control" id="cnt_option" name="cnt_option">
											<option value="10">10건</option>
											<option value="20">20건</option>
											<option value="30">30건</option>
											<option value="50">50건</option>
											<option value="100">100건</option>
										</select>
									</div>
								</div>
								<!-- 검색한 내용이 공백(null)이 아닐때 -->
								<c:if test="${search ne ''}">
									<div>
										<!-- 총 검색된 논문 건수 -->
										<div style="">
											<h5>검색결과 : <fmt:formatNumber value="${cnt}" pattern="#,###,###"/>건</h5>
										</div>
										<!-- 전체 논문 목록 페이지로 이동 -->
										<div style="">
											<a href="/article">전체보기</a>
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
						<div style="position: absolute; text-align: center; width: 100%; margin-bottom: 20px">
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
					</div>
				</div>
				<!-- 페이징 처리(종료) -->                             
              </div>
            </main>
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
<script src="/resources/js/scripts.js"></script>
</body> 
</html>

