<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		
		$("#btn_div").hide();
		$("#content").hide();
		
		$("#chk").click(function() {

			var filePath = $("#filePath").val();

			if (filePath == "") {
				alert("경로 입력");
				return;
			}

			$.ajax({
				async : true,
				url : "${pageContext.request.contextPath}/xml/check",
				type : 'POST',
				data : {
					"filePath" : filePath
				},
				dataType : "json",
				traditional : true,
				success : function(data) {

					console.log(data);
					
					$("input[name=title]").val(data['title']);
					$("input[name=abstr]").val(data['abstr']);
					$("input[name=org]").val(data['org']);
					$("input[name=authors]").val(data['authors']);
					$("input[name=category]").val(data['category']);
					$("input[name=subject]").val(data['subject']);
					$("input[name=publisher]").val(data['publisher']);
					
					$("#title").html(data['title']);
					$("#org").html(data['org']);
					$("#authors").html(data['authors']);
					$("#publisher").html(data['publisher']);
					
					$("#content").show();
					$("#btn_div").show();
				},
				error : function(request, error) {
					console.log('실패');
					//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		});
		$("#btn_submit").click(function(){
			
			var result = confirm("등록 하시겠습니까 ?");
			
    		if(result){
				var formObj = $("#frm");
				formObj.attr("action","/xml/insert");
				formObj.attr("method","post");
				formObj.submit();
    		}
		});
		

		

	});
</script>

</head>

<body>


	<!--  <div>
		경로입력 <input type="text" id="filePath" name="filePath">
		<button id="chk">확인</button>
	</div>
	<div id="content">
		<table>
			
			<tr>
				<td>title</td>
				<td id="title"></td>
			</tr>
			<tr>
				<td>org</td>
				<td id="org"></td>
			</tr>
			<tr>
				<td>author</td>
				<td id="authors"></td>
			</tr>
			<tr>
				<td>publisher</td>
				<td id="publisher"></td>
			</tr>
		</table>
	</div>
	<div id="btn_div">
		<button id="btn_submit">등록</button>
	</div>
	
	
<form id="frm">
	<input type="hidden" name="title" value="">
	<input type="hidden" name="abstr" value="">
	<input type="hidden" name="org" value="">
	<input type="hidden" name="authors" value="">
	<input type="hidden" name="category" value="">
	<input type="hidden" name="subject" value="">
	<input type="hidden" name="publisher" value="">
</form>-->
</body>
</html>