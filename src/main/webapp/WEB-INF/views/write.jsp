<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<title>Write</title>

<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.form/4.2.2/jquery.form.min.js"
 integrity="sha384-FzT3vTVGXqf7wRfy8k4BiyzvbNfeYjK+frTVqZeNDFl8woCbF0CYG6g2fMEFFo/i" crossorigin="anonymous"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
<link href="<c:url value='/resources/css/bootstrap.css' />" rel="stylesheet">
<link href="<c:url value='/resources/css/_bootswatch.scss' />" rel="stylesheet">
<link href="<c:url value='/resources/css/_variables.scss' />" rel="stylesheet">


<!-- include summernote css/js-->
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.js"></script>
<!-- include summernote-ko-KR -->
<script src="/resources/js/summernote-ko-KR.js"></script>






<script>

	var fileNum = 0;
	
	var valChk  = true;
	
	$(document).ready(function() {
		
		$('#summernote').summernote({
			
		  	placeholder: 'content',
			minHeight: 370,
			maxHeight: null,
			focus: true, 
			lang : 'ko-KR',
			toolbar: [
		        ['style', ['bold', 'italic', 'underline', 'clear']],
		        ['color', ['color']],
		        ['para', ['ul', 'ol']]
		    ]
		});
		
		
		
		$("#sbmt").click(function(){
			
			if($("#summernote").val().length > 4000) {
				
	        	var result=confirm("글자수 초과\n4000자 이하로 글자수를 제한합니다.");
	        	
				if (result){
					
					var idx = 3990;
					
					if(valChk){
						$("#summernote").summernote("code", $("#summernote").val().substring(0, idx));
						valChk = false;
						setTimeout(function () {
							valChk = true;
				        }, 5000);
					}else{
						$("#summernote").summernote("code", $("#summernote").val().substring(0, 2000));
						valChk =true;
					}
					
				}
				
	        }else{
			
			
				var result=confirm("게시글을 작성하시겠습니까 ?");
				
				if (result){
				
					
					var formObj = $("#frm");
					formObj.attr("action","/write");
					formObj.attr("method","post");
					formObj.submit();
					
				}
	        }
		});
		
		
		
		
		
	});

var fileNum = 0;
var click = true;

function fn_del(obj){

	if (click){
		obj.parent().remove();
		fileNum=fileNum-1;
		click=!click;
		
		setTimeout(function () {
            click = true;
        }, 500);
	}else{
		
	}

	
	console.log("fileNum "+fileNum);
}
function fn_add(){
	
	if(fileNum>4){
		alert("파일은 총 5개까지 추가됩니다");
		return false;
	}
	
	//새로 만들기
	$("#fileParent").append("<div id='div_"+fileNum+"'><input type=file name='file"+fileNum+"'>		\
								<a href='#' id='fd' name='delete'>									\
								<b>&nbsp;&nbsp;x&nbsp;&nbsp;</b>														\
								</a>																\
							</div>");
	
	$("a[name='delete']").on("click",function(e){
		
		e.preventDefault();

		fn_del($(this));
		
	});
	
	fileNum+=1;
	
	
	console.log("fileNum "+fileNum);
}



</script>


</head>
<body>

<form name="frm" id="frm" enctype="multipart/form-data">
	<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
		<div style="margin-left:10px;">
			<a class="navbar-brand" href="/">home</a>
		</div>
	</nav>
		

	<div class="container">
		<div style="margin-top:50px;">
				
			<div class="col-lg-8 col-md-7 col-sm-6">
			</div>
			
		</div>
		<div class="jumbotron">
				<h3>Write</h3>
				<hr>
				
			<div>
				
				<div class="input-group mb-3">
					<label class="col-sm-2 col-form-label" style="text-align:right;margin-right:20px;">
						제목
					</label>
					<div style="width:70%;">
						<input type="text" class="form-control" maxlength =50 name="title" aria-describedby="emailHelp" placeholder="제목 없음">
					</div>
				</div>
				
				<hr>
			
				<div class="input-group mb-3">
					<label class="col-sm-2 col-form-label" style="text-align:right;margin-right:20px;">
						내용
					</label>
					<div style="width:70%;">
						<textarea id="summernote" name="content"></textarea>
					</div>
				</div>
					
				<div class="input-group mb-3">
					<label class="col-sm-2 col-form-label" style="text-align:right;margin-right:20px;">
						첨부파일
					</label>
					<div class="input-group mb-3" style="width:70%;">
						<div style="width:60%;padding:5px;" id="fileParent" name="f_Parent">
						</div>
						<div style="width:15%;">
						
						
							<a href='#' id='fileAdd' onclick='fn_add();return false;' style="">
								파일추가
							</a>
						</div>
						<div align = "right" style="width:25%;">
							
							<input type="hidden" name="writer" value="${user.userNum}">
							<input type="button" class="btn btn-primary" id="sbmt" value="등록">
							<button type="button" class="btn btn-secondary" onClick="location.href='/'">취소</button>
						</div>
					</div>
					
					
				</div>
			
			</div>
			
			
		</div>
	</div>
</form>
</body>
</html>