<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

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
	
	$(document).ready(function() {
		
		
		/* 알림창 닫기 */
		$("#btn_alert_hide").on("click", function(e) {
			
			e.preventDefault();
			$("#div_alert").hide();
			
		});
		
		/* XML파일 추가 Modal 열기 */
		$("#btn_insertModal").on("click", function(e) {
			
			e.preventDefault();
			
			$("#div_alert").hide();
			
			clear_input();
			
			$("#insertModal").modal();
			
			
		});
		
		/* insertModal - 저장 버튼 */
		$("#btn_saveXml").click(function(e){
			
			e.preventDefault();
			
			
			var title = $("input[name=title]").val();

			if (title == "") {
				
				$("#alert_subject").html("XML 정보없음");
				$("#alert_content").html("올바르게 파싱되었는지 확인해주세요");
				
				$("#div_alert").show();
				
				clear_input();
				
				return;
			}
			
			var result = confirm("저장하시겠습니까 ?");
			
			if(result){
			
				var formObj = $("#frm");
				formObj.attr("action", "/xml/insert");
				formObj.attr("method", "post");
				formObj.submit();
			}
			
		});
		
		/* insertModal - 파싱 버튼*/
		$("#btn_chk").click(function() {

			var filePath = $("#filePath").val();
			
			clear_input();
			
			if (filePath == "") {
				
				$("#alert_subject").html("XML 미입력");
				$("#alert_content").html("XML 경로를 입력해주세요");
				$("#div_alert").show();
				return;
			}
			$("#div_alert").hide();
			
			$.ajax({
				async : true,
				url : "${pageContext.request.contextPath}/xml/check",
				type : 'POST',
				data : {
					"filePath" : filePath
				},
				dataType : "json",

				success : function(data) {

					if(data==null){
						return;
					}
					$("input[name=title]").val(data['title']);
					$("input[name=abstr]").val(data['abstr']);
					$("input[name=org]").val(data['org']);
					$("input[name=authors]").val(data['authors']);
					$("input[name=category]").val(data['category']);
					$("input[name=subject]").val(data['subject']);
					$("input[name=publisher]").val(data['publisher']);

					$("#title").html('제목 : '+data['title']);
					$("#org").html('기관 : '+data['org']);
					$("#authors").html("저자 : "+data['authors']);
					$("#publisher").html("출판사 : "+data['publisher']);
				},
				error : function(request, error) {
					//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
				}
			});
		});
		
	});
	
	function clear_input(){
		
		$("input[name=title]").val("");
		$("input[name=abstr]").val("");
		$("input[name=org]").val("");
		$("input[name=authors]").val("");
		$("input[name=category]").val("");
		$("input[name=subject]").val("");
		$("input[name=publisher]").val("");
		
		$("#title").html('');
		$("#org").html('');
		$("#authors").html('');
		$("#publisher").html('');
		
		
	}
	
	/* XML 상세보기 */
	function fn_read(id){
		
		
		$("#readModal").modal();
		
		$.ajax({
			async : true,
			url : "${pageContext.request.contextPath}/xml/read",
			type : 'POST',
			data : {
				"id" : id
			},
			dataType : "json",

			success : function(data) {

				if(data==null){
					console.log("비어있음");
					return;
				}
				
				$("input[name=title]").val(data['title']);
				$("input[name=abstr]").val(data['abstr']);
				$("input[name=org]").val(data['org']);
				$("input[name=authors]").val(data['authors']);
				$("input[name=category]").val(data['category']);
				$("input[name=subject]").val(data['subject']);
				$("input[name=publisher]").val(data['publisher']);
				
				data['authors'] = data['authors'].replace(/;/gi,'\n');
				
				$("textarea[name=title]").val(data['title']);
				$("textarea[name=abstr]").val(data['abstr']);
				$("textarea[name=org]").val(data['org']);
				$("textarea[name=authors]").val(data['authors']);
				
				
			},
			error : function(request, error) {
				//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
			}
		});
	}
	
	
	/* 페이지 이동 */
	function fn_paging(nowPage) {
		
		var url="/xml?page="+nowPage;
		
		
		location.href=url;
		
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

textarea {
	width: 100%;
	padding: 10px;
	border: 0px;
	resize: none;
	overflow-y: auto;
}

textarea:disabled {
	background: white;
}
</style>
</head>

<body>
	<form id="frm" enctype="multipart/form-data">

		<input type="hidden" name="title" value="" /> <input type="hidden"
			name="abstr" value="" /> <input type="hidden" name="org" value="" />
		<input type="hidden" name="authors" value="" /> <input type="hidden"
			name="category" value="" /> <input type="hidden" name="subject"
			value="" /> <input type="hidden" name="publisher" value="" />

		<div id="wrap">



			<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
			<div class="container">
				<a class="navbar-brand" href="/xml">xml parser</a>
			</div>
			</nav>

			<div class="container">
				<div style="min-height: 500px;">
					<div style="margin: 30px;">&nbsp;</div>
					<div style="margin: 30px;">
						<div class="input-group mb-3">
							<!-- 
					<input type="text" name="search" class="form-control">
					<button class="btn btn-secondary">검색</button>
				 -->
						</div>
					</div>
					<div id="contents">



						<div>
							<table class="table table-hover">
								<tbody>
									<c:forEach items="${xmlList}" var="xml" varStatus="g">
										<tr>
											<td>
												<p>${xml.id}</p>
											</td>
											<td>
												<blockquote class="blockquote" style="font-size: 110%;">

													<a href="#" class="mb-0" style="color: black;"
														onClick="fn_read('${xml.id }')"> ${xml.title } </a>


													<footer class="blockquote-footer"> <c:set
														var="tmp_list" value="${fn:split(xml.authors,';') }" /> <c:forEach
														var="tmp" items="${tmp_list }" varStatus="g">
														<c:if test="${g.count==1 }">${tmp }</c:if>
													</c:forEach> <c:if test="${fn:length(tmp_list)>1}">
														<c:out value="(외  ${fn:length(tmp_list)}명)"></c:out>
													</c:if> <!-- 
														<c:forEach var="tmp" items="${tmp_list }" varStatus="g">
															${tmp }
															<c:if test="${g.count!=fn:length(tmp_list) }">,</c:if>
														</c:forEach>
														 --> | ${xml.org } </footer>
												</blockquote>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>

				</div>
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
								<button id="btn_insertModal" class="btn btn-primary">XML파일
									추가</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>

	<div id="insertModal" class="modal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">XML 추가</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="container">
						<div>
							<p>XML 파일의 경로를 입력해주세요</p>
						</div>
						<div class="input-group mb-2" style="width: 100%;">
							<input type="text" id="filePath" name="filePath"
								class="form-control">

							<button id="btn_chk" class="btn btn-secondary">파싱</button>
						</div>
						<div id="div_alert" class="alert alert-dismissible alert-primary"
							style="display: none;">
							<button type="button" class="close" id="btn_alert_hide"
								style="color: white;">&times;</button>
							<strong id="alert_subject">경로 미입력!</strong><br>
							<p id="alert_content">XML 파일의 경로를 입력해주세요</p>
						</div>

						<div id="title"></div>
						<div id="org"></div>
						<div id="authors"></div>
						<div id="publisher"></div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="btn_saveXml">저장</button>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>

	<div id="readModal" class="modal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">상세정보</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<table style="width: 100%;">
						<thead>

						</thead>
						<tbody>

							<tr>
								<td>제목</td>
								<td><textarea name="title" value="" disabled></textarea></td>
							</tr>
							<tr>
								<td>저자</td>
								<td><textarea name="authors" value="" disabled></textarea></td>
							</tr>
							<tr>
								<td>요약</td>
								<td><textarea name="abstr" value="" disabled></textarea></td>
							</tr>


						</tbody>
					</table>
				</div>
				<div class="modal-footer">

					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

</body>
</html>