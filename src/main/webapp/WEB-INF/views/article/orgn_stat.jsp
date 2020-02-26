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
		
		$('#cnt_option option[value="${cnt_option}"]').attr("selected",true);
		
		$("#cnt_option").on('change',function(){
			
			
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
<body>
<form id="frm">
	<div class="wrapper d-flex align-items-stretch">
		<!-- 전체 메뉴 사이드바 -->
		<nav id="sidebar">
			<div class="p-4 pt-5">
				<a href="/article" class="img logo rounded-circle mb-5" style="background-image: url(/resources/image/analyticx.png);"></a>
				<ul class="list-unstyled components mb-5">
					<li><a href="#homeSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">메인</a>
						<ul class="collapse list-unstyled" id="homeSubmenu">
							<li>
								<a href="/article">논문보기</a>
							</li>
						</ul>
					</li>
					<!-- 기관별 현황 페이지에서는 '현황>소속기관별 현황'을 선택상태로 둠 -->
					<li class="active"><a href="#pageSubmenu" data-toggle="collapse" aria-expanded="true" class="dropdown-toggle">현황</a>
						<ul class="list-unstyled collapse show in" id="pageSubmenu" aria-expanded="true">
							<li><a href="/article/yearstat">연도별 현황</a></li>
							<li class="active"><a href="/article/orgnstat">소속기관별 현황</a></li>
							<li><a href="/article/ctgrstat">분야별 현황</a></li>
							<li><a href="/article/kwrdstat">키워드 현황</a></li>
						</ul></li>
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
		<!-- 메뉴에서 소속기관별 현황 눌렀을때 결과 페이지-->
		<div id="content" class="p-4 p-md-5">
			<nav class="navbar navbar-expand-lg navbar-light bg-light">
				<div class="container-fluid">
					<div class="collapse navbar-collapse" id="navbarSupportedContent">
						<ul class="nav navbar-nav ml-auto">
							<li class="nav-item active"><a class="nav-link" target="_blank" href="/article"><img src="/resources/image/home.png" alt="HOME"></a></li>
						</ul>
					</div>
				</div>
			</nav>
					<!--  소속기관별 통계: 테이블 -->
					<div id="orgn_stat1" style="margin-top: 20px">
						<p style="font-size: 20px; font-weight: bold; color: #000069">소속기관별 데이터 통계</p>				
						<div class="row">
							<div class="col-lg-12">
								<ol class="breadcrumb">
									<!-- 소속기관명 검색
									<li class="breadcrumb-item">
										<p style="font-size: 15px; font-weight: bold; margin-left: 15px; margin-right: 10px; margin-top: 10px">기관명</p>
									</li> -->
									
									<input type="hidden" name="search" value="">
									<div class="row" style="width:100%;">
										<div class="col-sm-6">
											<div class="form-inline">
												<input class="form-control" id="input_search" type="text" placeholder="기관명 검색.."
												 style="margin-right: 10px" onKeyDown="return inputKey()" onsubmit="return false" value="" maxlength="30">
												<button class="form-control btn btn-primary" type="button" id="btn_search">검색</button>
											</div>
										</div>
										<div class="col-sm-6" align="right">
											<select style="width:30%;"class="form-control" id="cnt_option" name="cnt_option">
												<option value="10">10개씩 보기</option>
												<option value="20">20개씩 보기</option>
												<option value="30">30개씩 보기</option>
												<option value="50">50개씩 보기</option>
												<option value="100">100개씩 보기</option>
											</select>
										</div>
									</div>
									
									
								</ol>
							</div>
						</div>
						<c:choose>
							<c:when test="${search ne ''}">
								<div>
									<div style="">
										<h5>검색결과 : ${cnt }건</h5>
										<a href="/article/orgnstat">전체보기</a>
									</div>
								</div>
							</c:when>
							<c:otherwise>
								<p>총 기관 수 &nbsp;&nbsp; ${cnt}</p>
							</c:otherwise>
						</c:choose>
						<!-- 소속기관별 논문수, 인용수 목록형 통계 부분 -->
						<div class="row">
							<div class="col-lg-12">
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
															<!-- 순번 -->
															${orgnVO.num }
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
						</div>
					</div>
					<!-- 페이징 처리(종료) -->
		</div>
	</div>
</form>
<!-- JQUERY, 필요한 JAVASCRIPT 파일 -->
<script src="/resources/js/jquery.min.js"></script>
<script src="/resources/js/popper.js"></script>
<script src="/resources/js/bootstrap.min.js"></script>
<script src="/resources/js/main.js"></script>
</body>
</html>