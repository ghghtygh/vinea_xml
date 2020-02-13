

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>

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
	var m_chk = false;

	var searchs = "${search}";
	
	/** document 로딩 **/
	$(document).ready(function() {

		$("#loading").hide();

		
		$("input[name='search']").val(searchs);
		
		$('#search_option option[value="${search_option}"]').attr("selected",true);
		
		$('#sort_option option[value="${sort_option}"]').attr("selected",true);
		
		
		
		/** 정렬하기 **/
		$("#sort_option").on('change',function(){
			
			var sort_option = $(this).val();
			
			//같은 값 클릭되게 하고싶음
			//$("#sort_option option:eq("+(sort_option-1)+")").remove();
			
			var formObj = $("#frm");
			formObj.attr("action", "/article");
			formObj.attr("method", "get");
			formObj.submit();
			
		});
		
		$("#btn_search").on("click", function(e){
			e.preventDefault();
			
			var search = $("#input_search").val();
			
			$("input[name='search']").val(search);
			
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
			$("#insertXML").modal({remote:"article/parsing"});
			
			
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
	/** document 로딩 끝 **/
	
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
</style>

</head>
<body>
	<form id="frm" enctype="multipart/form-data">
		<input type="hidden" name="search" value="">
		
		<div class="wrap">

			<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
				<div class="container">
					<a class="navbar-brand" href="/article">Article DataParsing</a>
				</div>
			</nav>

			<div class="container">

				<div style="min-height: 500px;">

					<div style="margin: 30px;">&nbsp;</div>

					<div class="row">


						<div class="col-sm-9">

							<div class="form-group row">
								<div class="form-group">
									<div class="input-group mb-3">
										<div class="input-group-prepend">
											<select class="form-control" id="search_option" name="search_option">
												<option value="1">제목</option>
												<option value="2">저자</option>
												<option value="3">키워드</option>
											</select>
										</div>
										<input type="text" class="form-control" id="input_search">
										<div class="input-group-append">
											<button class="btn btn-primary" type="button" id="btn_search">검색</button>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="form-group row">
								<label class="col-sm-4 col-form-label" align="right" >정렬</label>
								<select class="col-sm-8 form-control" id="sort_option" name="sort_option">
									<option value="1">정확도 순</option>
									<option value="2">발행일 순</option>
									<option value="3">인용횟수 순</option>
								</select>
							</div>
						</div>
					</div>

					<div id="contents">

						<div>
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
															<a class="mb-0" style="color: black;"
																href='article/article_detail?uid=${ArtiVO.uid}'>
																${ArtiVO.arti_title} </a>
															<footer class=""
																style="font-size: 70%; vertical-align: bottom;">

																<!--  저자정보 추가예정, 학회정보 추가예정, 권(호), 시작~끝페이지, 발행일자, 연구분야 추가예정 -->


																<div align="left" class="text-secondary"
																	style="margin-top: 10px;">
																	&nbsp;
																	<c:forEach var="auth" items="${ArtiVO.list_auth}"
																		varStatus="a">

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
																	<c:if
																		test="${ArtiVO.begin_page != '' && ArtiVO.end_page != ''}">
																	| 
																	pp.${ArtiVO.begin_page}~${ArtiVO.end_page}
																	|
																	</c:if>
																	<c:set var="tmp_list"
																		value="${fn:split(ArtiVO.pub_date,'-')}" />

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
					</div>
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
										<a href="#" class="btn btn-primary"
											onClick="fn_paging('${pager.prevPage}')">&laquo;</a>
									</c:when>
									<c:otherwise>
										<a class="btn btn-primary disabled">&laquo;</a>
									</c:otherwise>
								</c:choose>

								<c:forEach begin="${pager.startPage}" end="${pager.endPage}"
									var="pageNum">

									<c:choose>

										<c:when test="${pageNum eq pager.nowPage}">
											<a href="#" class="btn btn-primary active"
												onClick="fn_paging('${pageNum}')">${pageNum }</a>

										</c:when>

										<c:otherwise>
											<a href="#" class="btn btn-primary"
												onClick="fn_paging('${pageNum}')">${pageNum}</a>

										</c:otherwise>

									</c:choose>

								</c:forEach>


								<c:choose>
									<c:when
										test="${pager.nowPage ne pager.pageCnt && pager.pageCnt > 0 }">

										<a class="btn btn-primary" href="#"
											onClick="fn_paging('${pager.nextPage}')">&raquo;</a>


									</c:when>
									<c:otherwise>

										<a class="btn btn-primary disabled">&raquo;</a>

									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${pager.nowPage ne pager.pageCnt }">

										<a class="btn btn-primary" href="#"
											onClick="fn_paging('${pager.pageCnt}')">끝</a>


									</c:when>
									<c:otherwise>

										<a class="btn btn-primary disabled">끝</a>

									</c:otherwise>
								</c:choose>

							</div>
						</div>
						<div>
							<div style="position: relative; float: right; z-index: 10;">
								<button id="btn_insertXML" type="button" class="btn btn-primary">XML추가</button>
							</div>
						</div>
					</div>
				</div>
				<!-- / 페이징처리 -->
			</div>
		</div>

		<!-- [XML추가] 모달 -->
		<div id="insertXML" class="modal">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
				</div>
			</div>
		</div>
		<!-- / [XML추가] 모달 -->
		
	</form>
</body>



</html>