<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인서트 모달</title>

<!--  StyleSheet_부트스트랩 사용 -->
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>

<link href="<c:url value='/resources/css/bootstrap.css' />" rel="stylesheet">
<link href="<c:url value='/resources/css/_bootswatch.scss' />" rel="stylesheet">
<link href="<c:url value='/resources/css/_variables.scss' />" rel="stylesheet">
</head>
<body>
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">XML 데이터추가</h5>
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
							
							<!-- 경로입력 및 파일 확인 -->
							<div class="input-group mb-2" style="width: 100%;">
							
								<input type="text" id="filePath" name="filePath" class="form-control" onkeyup="input_chk();">
								<button id="btn_chk" class="btn btn-secondary">확인</button>
								
							</div>
							
							<!-- 로딩표시 -->
							<div id="loading" class="text-center">
								<div class="spinner-border" role="status">
									<span class="sr-only">Loading...</span>
								</div>
							</div>
							
							<!-- 알림창 -->
							<div id="div_alert" class="alert alert-dismissible alert-primary"
								style="display: none;">
								<button type="button" class="close" id="btn_alert_hide"
									style="color: white;">&times;</button>
								<strong id="alert_subject">경로를 입력하지 않았습니다</strong><br>
								<p id="alert_content">XML 파일의 경로를 입력해주세요</p>
							</div>
							
							<!-- 파싱 내용 -->
							<div>
								<div id="div_parse"></div>
							</div>
							
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" id="btn_saveXml">저장</button>
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal" onclick="input_chk();">취소</button>
					</div>
				</div>
			</div>
</body>
</html>