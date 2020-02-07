<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파싱 페이지</title>

<!--  StyleSheet_부트스트랩 사용 -->
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>

<link href="<c:url value='/resources/css/bootstrap.css' />" rel="stylesheet">
<link href="<c:url value='/resources/css/_bootswatch.scss' />" rel="stylesheet">
<link href="<c:url value='/resources/css/_variables.scss' />" rel="stylesheet">
</head>
<script>


	$(document).ready(function() {

		$("#loading").hide();

		/** 알림창 닫기 **/
		$("#btn_alert_hide").on("click", function(e) {

			e.preventDefault();
			$("#div_alert").hide();

		});
		
		/** 버튼, 파싱현황 세팅 **/
		$.ajax({
			type:"POST",
			url:"/article/parsing/check",
			dataType:"json",
			async:false,
			success:function(data){
				
				var str = "";
				
				str+="<div>";
				
				$.each(data, function(index, item){
					console.log(index+" : "+item['file_name']+" "+item['y_cnt']+" "+item['all_cnt']);
					
					str+="<div class='row' style='font-size:90%;'>";
					
					str+="	<div class='col-sm-8'>";
					str+=		item['file_name'];
					str+="	</div>";
					str+="	<div class='col-sm-2' align='right' name="+item['file_name']+">";
					str+=		item['y_cnt']+"/"+item['all_cnt'];
					str+="	</div>"
					str+="	<div class='col-sm-2'>";
					str+="		<button type='button' class='btn btn-primary btn-sm' name='btn_parse' value="+item['file_name']+">파싱";
					str+="		</button>";
					str+="	</div>";
					
					str+="</div>"
					
				});
				
				str+="</div>";
				$("#parse_div").html(str);
			},
			error:function(request,error){
				console.log("request :"+request+"\nerror:"+error);
				return;	
			}
		});
		
		/* [파싱현황 확인] 버튼 클릭*/
		$("#btn_parse_chk").click(function(e){
			
			e.preventDefault();
			parsing_check();
			
		});
		
		
		
		$("button[name='btn_parse']").click(function(e){
			
			e.preventDefault();
		
			$.ajax({
				
			
				type:"POST",
				url:"/article/parsing/test",
				data:{
					"file_name":$(this).attr('value')
				},
				dataType:"json",
				async:false,
				success:function(data){
					
					
					console.log(data['uid']);
					//console.log(data['content']);
					parsing_check();
					
				},
				error:function(request,error){
					console.log("request :"+request+"\nerror:"+error);
					return;	
				}
			});
				
		});
		
		$("#btn_test").click(function(e){
			
			e.preventDefault();
			
			
				
		});
	});

	function parsing_check(){
		
		$.ajax({
			type:"POST",
			url:"/article/parsing/check",
			dataType:"json",
			async:false,
			success:function(data){
				$.each(data, function(index, item){
					
					
					//console.log("index : "+index);
					console.log(item['file_name']+" "+item['y_cnt']+" "+item['all_cnt']);
					
					$("div[name='"+item['file_name']+"']").html(item['y_cnt']+"/"+item['all_cnt']);
				});
				
				
				
			},
			error:function(request,error){
				console.log("request :"+request+"\nerror:"+error);
				return;	
			}
		});
		
	}
	function parsing_one(){
		
		
	}
</script>

<body>
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">XML 파싱</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>

			<div class="modal-body">
				<div class="container">
					<div>
					
					
					</div>

					<!-- 로딩표시 -->
					<div id="loading" class="text-center">
						<div class="spinner-border" role="status">
							<span class="sr-only">Loading...</span>
						</div>
					</div>

					<!-- 알림창 -->
					<div id="div_alert" class="alert alert-dismissible alert-primary" style="display: none;">
						<button type="button" class="close" id="btn_alert_hide" style="color: white;">&times;</button>
						<strong id="alert_subject">경로를 입력하지 않았습니다</strong><br>
						<p id="alert_content">XML 파일의 경로를 입력해주세요</p>
					</div>

					<!-- 파싱 내용 -->
					<div>
						<div id="parse_div"></div>
					</div>
					
					<!-- 테스트 -->
					<div>
						<button type="button" class="btn btn-secondary" id="btn_parse_chk">파싱 현황 확인</button>
						<button type="button" class="btn btn-secondary" id="btn_test" value="WR_2017_20180509131811_CORE_0001.xml">테스트</button>
					</div>
					
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" >저장</button>
				<button type="button" class="btn btn-secondary" >취소</button>
			</div>
		</div>
	</div>
</body>
</html>