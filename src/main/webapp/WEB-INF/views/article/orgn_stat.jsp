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

<!-- Chart.js 사용(라인, 바, 플롯, 레이더 등 사용) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.min.js"></script>
<script src="/resources/js/jquery-radar-plus.js"></script>
<style>
/** 연도 선택 SelectBox **/
#yearselect {
	position: relative;
	width: 130px;
	border: 1px solid #999;
	z-index:1;
}
/** 기관 선택 SelectBox **/
#orgnselect {
	position: relative;
	width: 170px;
	border: 1px solid #999;
	z-index:1;
}
/** 정렬기준(한페이지에 보여줄 목록수) SelectBox **/
#objectCnt {
	position: relative;
	width: 170px;
	border: 1px solid #999;
	z-index:1;
}
/** a태그에 해당하는 부분 마우스를 올려놓았을 경우 글씨 색깔 변하도록 함 **/
a:hover {
	color: #000069
}
</style>
<script>

	/** document 로딩 시작 **/ 
	$(document).ready(function() {
		
		var searchs = "${search}";
		
		/* 검색어 입력 */
		$("input[name='search']").val(searchs);
		$("#input_search").val(searchs);
		
		/* 국가명 선택 및 정렬 */
		$('#country option[value="${country}"]').attr("selected",true);
		$('#cnt_option option[value="${cnt_option}"]').attr("selected",true);
		
		$("#country").change(function() {
			
			var formObj = $("#frm");
			formObj.attr("action", "/article/orgnstat");
			formObj.attr("method", "get");
			formObj.submit();
				
		});
				
		$("#cnt_option").change(function(){
						
			/** 선택된 옵션에 따라 페이지를 업데이트 **/
			var formObj = $("#frm");
			formObj.attr("action", "/article/orgnstat");
			formObj.attr("method", "get");
			formObj.submit();
			
		});
		
		/** 검색하기 **/
		$("#btn_search").on("click", function(e){
			e.preventDefault();
			
			var search = $("#input_search").val();
			
			$("input[name='search']").val(search);
			
			var formObj = $("#frm");
			formObj.attr("action", "/article/orgnstat");
			formObj.attr("method", "get");
			formObj.submit();
		});		
	});
	/** document 로딩 종료 **/ 
	
	/** 소속기관별 데이터 통계(목록형 데이터 통계: 페이징 처리) **/
	function fn_paging(nowPage) {
	
		var formObj = $("#frm");
		
		var input_page = document.createElement("input");
		$(input_page).attr("type","hidden");
		$(input_page).attr("name","page");
		$(input_page).attr("value",nowPage);
		formObj.append(input_page);
		
		formObj.attr("action", "/article/orgnstat");
		formObj.attr("method", "get");
		formObj.submit();
	
	}
	
	/** input 태그에서 엔터 눌렀을 때 새로고침 방지 및 제출하기 **/
	function inputKey(){
		if(event.keyCode==13){
			
			var search = $("#input_search").val();
			
			$("input[name='search']").val(search);
			
			var formObj = $("#frm");
			formObj.attr("action", "/article/orgnstat");
			formObj.attr("method", "get");
			formObj.submit();
		}else{
			return true;
		}
	}
	
	/** 통계 목록에서 기관명 클릭하였을 때 페이지 이동 **/
	function search_orgn(orgn_nm){
		
		
		var formObj = $("#frm");
		
		$("input[name='search']").val(orgn_nm);
		var input_option = document.createElement("input");
		
		$(input_option).attr("type","hidden");		
		$(input_option).attr("name","search_option");		
		$(input_option).attr("value","6");
		
		formObj.append(input_option);				
		formObj.attr("action", "/article");
		formObj.attr("method", "get");
		formObj.submit();
		

	}
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
							<a class="nav-link" href="/">
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
							<a style="font-weight: bold; color: #fff" class="nav-link" href="/article/orgnstat">
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
						<div style="margin-top: 45px"></div>
						<p style="font-size: 25px; font-weight: bold; color: #000069">소속기관별 데이터 통계</p>
						<hr>
						<div class="row">
							<div class="col-sm-12">
								<ol class="breadcrumb">
									<input type="hidden" name="search" value="">
									<div class="row" style="width:100%;">
										<div class="col-lg-8">
											<div class="form-inline">
												<p style="font-size: 15px; font-weight: bold; margin-right: 15px">기관명</p>
												<input class="form-control" id="input_search" type="text" placeholder="기관명 검색.."
												 style="margin-right: 10px; width: 350px" onKeyDown="return inputKey()" onsubmit="return false" value="" maxlength="50">
												<button class="form-control btn btn-primary" type="button" id="btn_search">검색</button>
											</div>
										</div>
										<div class="col-lg-4" style="margin_left: 20pxs">
										<div class="form-inline">
										<!-- 추가 -->
										<c:if test="${!empty ctryList}">
											<p style="font-size: 15px; font-weight: bold; margin-right: 15px">국가</p>
											<select style="width:150px; margin-right: 10px" class="form-control" id="country" name="country">
												<!-- 전체 -->
												<option value="">ALL</option>
												<!-- 국가명 데이터 -->
												<c:forEach var="list" items="${ctryList}" varStatus="c">
													<option value="${list}">${list}</option>
												</c:forEach>
											</select>
										</c:if>
										<!-- 추가 끝 -->
											<p style="font-size: 15px; font-weight: bold; margin-right: 15px">정렬</p>
											<select style="width:150px;"class="form-control" id="cnt_option" name="cnt_option">
												<option value="10">10개</option>
												<option value="20">20개</option>
												<option value="30">30개</option>
												<option value="50">50개</option>
												<option value="100">100개</option>
											</select>
										</div>
										</div>
									</div>																
								</ol>
							</div>							
						</div>
						<c:choose>
							<c:when test="${search ne ''}">
								<div>
									<div style="">
										<p>총 건수 :<strong style="margin-left: 15px"><fmt:formatNumber value="${cnt}" pattern="#,###,###"/>건</strong></p>
									</div>
								</div>
							</c:when>
							<c:otherwise>
								<p>총 기관 수 :<strong style="margin-left: 15px"><fmt:formatNumber value="${cnt}" pattern="#,###,###"/></strong>개</p>
							</c:otherwise> 
						</c:choose>
						<!-- 소속기관별 논문수, 인용수 목록형 통계 부분 -->
						<div class="row">
							<div class="col-sm-12">
								<table style="text-align: center;" class="table table-hover">
									<thead>
										<colgroup>
											<col width="20%;">
											<col width="*">
											<col width="20%;">
											<col width="20%;">
										</colgroup>
									</thead>
									<tbody>
										<th style="border-top: 2px solid #000069">순번</th>
										<th style="border-top: 2px solid #000069;text-align:center">소속기관명</th>
										<th style="border-top: 2px solid #000069">논문수</th>
										<th style="border-top: 2px solid #000069">인용수</th>
										<c:choose>
											<c:when test="${not empty orgList}">
												<c:forEach items="${orgList }" var="orgnVO" varStatus="g">
													<tr>
														<td>
															${pager.prevPage*pager.pageSize + (g.count)}
														</td>
														<td style="text-align:left;padding-left:5%">
															<!-- 소속기관명 -->
															<a class="mb-0" href="#"  onClick="search_orgn('${orgnVO.orgn_nm}')">
															${orgnVO.orgn_nm}
															</a>
														</td>
														<td>
															<!-- 논문수 -->
															<fmt:formatNumber value="${orgnVO.arti_cnt}" pattern="#,###,###"/>
														</td>
														<td>
															<!-- 인용수 -->
															<fmt:formatNumber value="${orgnVO.cite_cnt}" pattern="#,###,###"/>
														</td>
													</tr>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<!-- 데이터 없음 -->
												<tr>
													<td colspan="4" style="text-align: center">기관 데이터가 존재하지 않습니다</td>
												</tr>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div>
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
							</div>
						</div>
						<!-- 페이징 처리(종료) -->
					</div>
				</div>
			</main>
			</form>
		</div>
	</div>
<script src="/resources/js/scripts.js"></script>
</body>
</html>