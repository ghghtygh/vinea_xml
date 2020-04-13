<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파싱 페이지</title>
<!-- STYLE 지정 -->
<style>
td{
	text-overflow:ellipsis;
	overflow:hidden;
	white-space:nowrap;
}

</style>
</head>
<script>
	var m_mode;
	
	/** document 로딩 **/
	$(document).ready(function() {

		m_mode = false;
		
		/* 파싱 모달창을 첨 열었을 때, 로딩바 숨김 */
		$("#loading").hide();

		/* 알림창 닫기 */
		$("#btn_alert_hide").on("click", function(e) {

			e.preventDefault();
			$("#div_alert").hide();

		});
		
		/** 버튼, 파싱현황 세팅 **/
		$.ajax({
			type:"POST",
			url:"/parsing/check",
			dataType:"json",
			async:false,
			success:function(data){
								
				$.each(data, function(index, item){
										
					var tb_str = "";
					
					/* 인덱스 */
					tb_str+="<tr>";
					tb_str+="<td>";
					tb_str+=index;
					tb_str+="</td>";
					/* 파일명 */
					tb_str+="<td title='"+item['file_name']+"'>";
					tb_str+=item['file_name'];
					tb_str+="</td>";					
					tb_str+="<td name='"+item['file_name']+"'>";
					/* 파싱완료된 논문 건수 */
					tb_str+=item['y_cnt'];
					tb_str+="</td>";					
					tb_str+="<td>";
					/* 모든 논문 건수 */
					tb_str+=item['all_cnt'];
					tb_str+="</td>";					
					tb_str+="<td>";
					/* 파싱을 위한 버튼 정의 */
					tb_str+="<button type='button' class='btn btn-primary btn-sm' name='btn_parse' value="+item['file_name']+">파싱";
					tb_str+="</button>";
					/*
					"<div id='loading' class='text-center'>"
					"<div class='spinner-border' role='status'>"
					"<span class='sr-only'>Loading...</span>"
					"</div>"
					</div>*/
					
					tb_str+="</td>";					
					tb_str+="</tr>";
					
					$("#table1 > tbody:last").append(tb_str);
				});
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
		
		
		/* [파싱] 동작 */
		$("button[name='btn_parse']").click(function(e){
			
			e.preventDefault();		
			parsing_do($(this).attr('value'));
							
		});
				
	});
	/** document 로딩 종료 **/
	
	
	/** 파싱 시작 **/
	function parsing_do(fileName){
		
		/* 파싱할 파일 선택 */
		m_mode = $("input:checkbox[id='chk_auto']").is(":checked");

		$.ajax({			
			type:"POST",
			url:"/parsing/do",
			data:{
				"file_name":fileName,
				"file_cnt":$("#file_cnt").val()
			},
			dataType:"json",
			async:true,
			success:function(data){				
				parsing_check();	
				
				if (!m_mode){
					return;
				}else{
					parsing_do(fileName);
				}				
			},
			error:function(request,error){
				console.log("request :"+request+"\nerror:"+error);
				return;	
			}
		});
	}
	
	/** 파싱 현황 체크  **/
	function parsing_check(){
		
		$.ajax({
			type:"POST",
			url:"/parsing/check",
			dataType:"json",
			async:false,
			success:function(data){
				$.each(data, function(index, item){				
					$("td[name='"+item['file_name']+"']").html(item['y_cnt']);
				});			
			},
			error:function(request,error){
				console.log("request :"+request+"\nerror:"+error);
				return;	
			}
		});
		
	}
</script>
<body>
	<!-- 모달창 제목, 닫기 버튼 -->
	<div class="modal-header">
		<h5 class="modal-title">XML 파싱</h5>
		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			<span aria-hidden="true">&times;</span>
		</button>
	</div>

	<!-- 모달창 안에 들어갈 내용 -->
	<div class="modal-body">
		<div class="container">
			<div>
				<table id="table1" class="table table-hover"
					style="table-layout: fixed">
					<thead>
					<colgroup>
						<col width="5%" />
						<col width="*" />
						<col width="20%" />
						<col width="20%" />
						<col width="20%" />
					</colgroup>

					<!-- 모달창 내부 구성: 파일이름, 파싱완료된 태그수(논문수), 전체 태그수(논문수), 파싱 개수(옵션선택) -->
					<tr>
						<th scope="col"></th>
						<th scope="col">파일 이름</th>
						<th scope="col">파싱완료태그</th>
						<th scope="col">전체태그개수</th>
						<th scope="col">파싱 
							<!-- 파싱할 논문 건수를 정할 수 있는 selectbox 옵션 -->
							<select id="file_cnt" class="selectpicker">
								<optgroup label="개수">
									<option>1</option>
									<option>10</option>
									<option>100</option>
								</optgroup>
						</select>
						</th>
					</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
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
				<div id="parse_div"></div>
			</div>
			<!-- 테스트 -->
			<div></div>
		</div>
	</div>
	<div class="modal-footer">		
		<div class="custom-control custom-switch">
			<!-- 자동파싱을 눌렀을 경우 수동으로 누르지 않아도 자동으로 파싱되도록 함 -->
			<input type="checkbox" class="custom-control-input" id="chk_auto" checked="">
			<label class="custom-control-label" for="chk_auto">자동파싱</label>
		</div>
		<!-- 현재 파싱완료된 논문건수등을 확인하기 위해 파싱 현황 버튼 배치 -->
		<button type="button" class="btn btn-secondary" id="btn_parse_chk">파싱현황 확인</button>
	</div>
</body>
</html>