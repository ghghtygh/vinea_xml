<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인서트 모달</title>

<!--  StyleSheet_부트스트랩 사용 
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script
	src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>

  <script src="https://cdn.anychart.com/releases/v8/js/anychart-base.min.js"></script>
  <script src="https://cdn.anychart.com/releases/v8/js/anychart-tag-cloud.min.js"></script>

<style>
 	html, body, #container {
 	  width: 100%;
      height: 100%;
      margin: 0;
      padding: 0;
 	}
</style>
	

<link href="<c:url value='/resources/css/bootstrap.css' />"
	rel="stylesheet">
<link href="<c:url value='/resources/css/_bootswatch.scss' />"
	rel="stylesheet">
<link href="<c:url value='/resources/css/_variables.scss' />"
	rel="stylesheet">
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

						<input type="text" id="filePath" name="filePath"
							class="form-control" onkeyup="input_chk();">
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
				<button type="button" class="btn btn-secondary" data-dismiss="modal"
					onclick="input_chk();">취소</button>
			</div>
		</div>
	</div>
	
	<div id="container"></div>
	<script>
    anychart.onDocumentReady(function() {
		  var data = [
		    {"x": "Mandarin chinese", "value": 1090000000, category: "Sino-Tibetan"},
		    {"x": "English", "value": 983000000, category: "Indo-European"},
		    {"x": "Hindustani", "value": 544000000, category: "Indo-European"},
		    {"x": "Spanish", "value": 527000000, category: "Indo-European"},
		    {"x": "Arabic", "value": 422000000, category: "Afro-Asiatic"},
		    {"x": "Malay", "value": 281000000, category: "Austronesian"},
		    {"x": "Russian", "value": 267000000, category: "Indo-European"},
		    {"x": "Bengali", "value": 261000000, category: "Indo-European"},
		    {"x": "Portuguese", "value": 229000000, category: "Indo-European"},
		    {"x": "French", "value": 229000000, category: "Indo-European"},
		    {"x": "Hausa", "value": 150000000, category: "Afro-Asiatic"},
		    {"x": "Punjabi", "value": 148000000, category: "Indo-European"},
		    {"x": "Japanese", "value": 129000000, category: "Japonic"},
		    {"x": "German", "value": 129000000, category: "Indo-European"},
		    {"x": "Persian", "value": 121000000, category: "Indo-European"}
		  ];

		 // create a tag (word) cloud chart
		  var chart = anychart.tagCloud(data);
		 

		   // set a chart title
		  chart.title('15 most spoken languages')
		  // set an array of angles at which the words will be laid out
		  chart.angles([0])
		  // enable a color range
		  chart.colorRange(true);
		  // set the color range length
		  chart.colorRange().length('80%');

		  // display the word cloud chart
		  chart.container("container");
		  
		  var formatter = "{%value}{scale:(1)(1000)(1000)(1000)|( dozen)( thousand)( million)( billion)}";
		  var tooltip = chart.tooltip();
		  tooltip.format(formatter);
		  
		  
		  chart.draw();
		});	
	</script>
</body>
</html>