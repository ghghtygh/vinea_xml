<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 

<link href="<c:url value='/resources/css/bootstrap.css' />" rel="stylesheet">
<link href="<c:url value='/resources/css/_bootswatch.scss' />" rel="stylesheet">
<link href="<c:url value='/resources/css/_variables.scss' />" rel="stylesheet">


<!-- include summernote css/js-->
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.js"></script>
<!-- include summernote-ko-KR -->
<script src="/resources/js/summernote-ko-KR.js"></script>



<title>Modify</title>


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
			
				var result=confirm("게시글을 수정하시겠습니까 ?");
				
				if (result){
					
					var formObj = $("#frm");
					formObj.attr("action","/modify");
					formObj.attr("method","post");
					formObj.submit();
				}
			}
			
		});
	  
	  
	  
		 $("a[name='delete']").on("click",function(e){
			e.preventDefault();
		
			fn_del($(this));
			
		});
		 
		fileNum =${fn:length(postVO.fileNames)};
		 
	});
	
	
	var click = true;
	
	// 파일추가 버튼 클릭
	function fn_add(){
		
		if(fileNum>4){
			alert("파일은 총 5개까지 추가됩니다");
			return false;
		}
		
		//새로 만들기
		$("#fileParent").append("<div id='div_"+fileNum+"'><input type=file name='file"+fileNum+"'>		\
									<a href='#' id='fd' name='delete'>									\
									<b>&nbsp;&nbsp;x&nbsp;&nbsp;</b>									\
									</a>																\
								</div>");
		$("a[name='delete']").on("click",function(e){
			
			e.preventDefault();

			fn_del($(this));
			
		});
		
		fileNum+=1;
		
		
		//console.log("fileNum "+fileNum);
	}
	
	// 수정폼에서 추가된 파일 삭제
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
		
		//console.log("fileNum "+fileNum);
	}
	
	// 첨부파일 삭제
	function fn_delete(obj,vl){
		
		if (click){
			
			var tag;
			tag = "<input type='hidden' name='deleteFileNo', value='"+vl+"'/>";
			$("#frm").append(tag);
			
			obj.parent().remove();
			
			fileNum=fileNum-1;
			click=!click;
			
			//console.log("fileNum "+fileNum);
			
			setTimeout(function () {
	            click = true;
	        }, 500);
		}else{
			
		}
		
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
				<h3>Modify</h3>
				<hr>
				
			<div>
				
				<div class="input-group mb-3">
					<label class="col-sm-2 col-form-label" style="text-align:right;margin-right:20px;">
						제목
					</label>
					<div style="width:70%;">
						<input type="text" class="form-control" maxlength =50 name="title" value="${postVO.title}"aria-describedby="emailHelp" placeholder="제목 없음">
					</div>
				</div>

				<div style="font-size:90%;margin-top:30px;width:90%;">
					<p class="text-muted" style="">
						<div align="right">
							<div style="width:200px;text-align:left;">
								<div style="margin-top:5px;">작성자 : ${postVO.wrtId} | 조회수 : ${postVO.viewCnt}</div>
								<div style="margin-top:5px;">작성일 : ${fn:substring(postVO.wrtDt,0,16) }</div>
								<div style="margin-top:5px;">
									<c:if test="${postVO.wrtDt ne postVO.reDt}">
										수정일 : ${fn:substring(postVO.reDt,0,16) }
									</c:if>
								</div>
							</div>
						</div>
					</p>
				</div>

				<hr>
			
				<div class="input-group mb-3">
				
					<label class="col-sm-2 col-form-label" style="text-align:right;margin-right:20px;">
						내용
					</label>
					

					<div style="width:70%;">
						<textarea id="summernote" name="content" >${postVO.content}</textarea>
					</div>
					
				</div>
				<div class="input-group mb-3">
					<label class="col-sm-2 col-form-label" style="text-align:right;margin-right:20px;">
						첨부파일
					</label>
					<div class="input-group mb-3" style="width:70%;">
						<div id="fileParent" style="width:60%;">
							<c:forEach items="${postVO.fileNames}" var="files">
								<div>
									<a href="#" name="files">${files.ORIGINAL_NAME}(${files.FILE_SIZE}KB)</a>
									&nbsp;
									<a href="#" name="delete2" onclick="fn_delete($(this),${files.FILE_NO_PK});"><b>&nbsp;&nbsp;x&nbsp;&nbsp;</b></a>
									<br>
								</div>
							</c:forEach>
						</div>
						<div style="width:15%;">
							<a href='#' id='fileAdd' onclick='fn_add();return false;' style="">
								파일추가
							</a>
						</div>
						<div align = "right" style="width:25%;">
							
							<input type="hidden" name="postNum" value="${postVO.postNum}">
							<input type="button" class="btn btn-primary" id="sbmt" value="수정">
							<button type="button" class="btn btn-secondary" onClick="location.href='/read?num=${postVO.postNum}&page=${page}'">취소</button>
						</div>
					</div>
				</div>
						
			</div>
			
			<div>
			</div>
			
			
		</div>
	</div>

</form>
</body>
</html>