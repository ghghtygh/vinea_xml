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
	
</head>
<body>
	<form id="form" enctype="multipart/form-data">
	
		<!--  input 'hidden'에 값을 담아 전송하여 DB에 저장
		<input type="hidden" name="arti_no" value=""/>
		<input type="hidden" name="arti_uid" value=""/>
		<input type="hidden" name="arti_title" value=""/>
		<input type="hidden" name="arti_source_title" value=""/>
		<input type="hidden" name="arti_year" value=""/>
		<input type="hidden" name="arti_date" value=""/>
		<input type="hidden" name="arti_volume" value=""/>
		<input type="hidden" name="arti_issue" value=""/>
		<input type="hidden" name="arti_sup" value=""/>
		<input type="hidden" name="arti_doi" value=""/>
		<input type="hidden" name="arti_ab" value=""/>
		<input type="hidden" name="arti_issn" value=""/>
		<input type="hidden" name="arti_eissn" value=""/>
		<input type="hidden" name="arti_cite_cnt" value=""/>
		<input type="hidden" name="arti_page_cnt" value=""/>
		<input type="hidden" name="arti_bp" value=""/>
		<input type="hidden" name="arti_ep" value=""/>
		<input type="hidden" name="arti_oa" value=""/>-->
		
		<div id ="wrap">
			
			<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
			<div class="container">
				<a class="navbar-brand" href="/article">Article DataParsing</a>
			</div>
			</nav>
			
			<div class="container">
				<div style="min-height: 500px;">
					<div style="margin: 30px;">&nbsp;</div>
					<div style="margin: 30px;">
						<div class="input-group mb-3"></div>
					</div>
				</div>
					<div id="contents">
					
					<div>
						<table class="table table-hover">
							<tbody>
								<c:forEach items="${articleList}" var="article">
									<tr>
										<td>
										 	<p>${article.arti_no}</p>
										</td>
										<td>
											<blockquote class="blockquote" style="font-size: 110%;">
											
											    <!-- 논문 제목 클릭시, 논문상세페이지로 이동 -->
												<a class="mb-0" style="color: black;" 
													href='/article/read?arti_no=${article.arti_no}'> ${article.arti_title} </a>
													
												<footer class="blockquote text-center">
													<!--   <c:set
														var="authr_list" value="${fn:split(auth.auth_lead';') }" /> 
														<c:forEach
														var="tmp" items="${tmp_list}" varStatus="g">
															<c:if test="${g.count==1 }">${tmp}</c:if>
														</c:forEach> 
															<c:if test="${fn:length(tmp_list)>1}">
																<c:out value="(외  ${fn:length(tmp_list)}명)"></c:out>
															</c:if>	-->
															
													
												</footer>
												
										</td>
								</c:forEach>
							</tbody>
						</table>
					
					
					</div>
		
		
		
		</div>
		

		
		
	</form>
</body>
</html>