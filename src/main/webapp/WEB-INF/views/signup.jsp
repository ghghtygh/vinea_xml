<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Signup</title>

<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
<link href="<c:url value='/resources/css/bootstrap.css' />" rel="stylesheet">
<link href="<c:url value='/resources/css/_bootswatch.scss' />" rel="stylesheet">
<link href="<c:url value='/resources/css/_variables.scss' />" rel="stylesheet">

<script type="text/javascript">
	
	// 아이디 중복확인 여부
	var idck = false;
	
	// 비밀번호 일치,입력 여부
	var pwck = false;
	var reck = false;
	
	// 이메일 입력 여부
	var emck = false;
	$(function() {
		
	    //중복확인 
	    $("#idck").click(function() {
	        
	        var userId =  $("#userId").val(); 
	        
	        if (userId==""){
	        	alert("아이디 입력");
	        	return;
	        }
	        $.ajax({
	        	async: true,
	        	url : "${pageContext.request.contextPath}/idCheck",
	            type : 'POST',
	            data : {
	            	"userId":userId
	            },
	            dataType:"json",
	            
	            success : function(data){
	            	
	                if (data.cnt > 0) {
	                	idck = false;
	                    alert("해당 아이디 존재, 다른 아이디를 입력하세요");
	                    $("#userId").val('');
	                
	                } else {
	                	idck = true;
	                    alert("사용가능 아이디입니다.");
	                    
	                    
	                }
	            },
	            error:function(request, error){
	            	//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
	            }
	        });
	    });
	    
	    //회원가입
	    $("#sbmt").click(function() {
	    	
	    	var m_idck = idck;
	    	var m_pwck = pwck;
	    	var m_emck = emck;
	    	
	    	if(!m_idck){
	    	
	    		alert("아이디 중복 확인");
	    	
	    	}else if(!m_pwck){
	    	
	    		alert("패스워드 확인");
	    	}else if(!m_emck){
	    		
	    		alert("이메일 확인");
	    		
	    	
	    	}else{
	    		
	    		var result = confirm("회원가입 하시겠습니까 ?");
				
	    		if(result){
	    			var formObj = $("#frm");
	    			formObj.attr("action","/signup");
	    			formObj.attr("method","post");
	    			formObj.submit();
	    		}
	    	}
	    	
	    });
	});
	
	// 비밀번호 같은지 체크
	function checkPw(){
		
		var f1 = document.getElementById("frm");
		
		var pw1 = f1.pw1.value;
		var pw2 = f1.pw2.value;
		if (pw1!=pw2){
			document.getElementById("checkPw").style.color="red";
			document.getElementById("checkPw").innerHTML="동일한 암호를 입력하세요";
			pwck = false;
		}else{
			document.getElementById("checkPw").style.color="black";
			document.getElementById("checkPw").innerHTML="";
			pwck = true;
		}
	}
	// 비밀번호 다시 입력했을 때
	function rePw(){
		
		if(pwck){
			
			reck=true;
			checkPw();
			
		}else{
			
			if(reck){
				
				checkPw();
				
			}
			
		}
		
		
	}
 	
	// 이메일 정규식
	function chkEmail(){
		
		var email = document.getElementById("email").value;

		
		var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;

		if (exptext.test(email)==false){
			document.getElementById("checkEm").style.color="red";
			document.getElementById("checkEm").innerHTML="올바르지 않은 이메일 형식입니다";
			emck = false;
		}else{
			emck = true;
			document.getElementById("checkEm").innerHTML="";
		}
		
	}
	
</script>
</head>

<form name="frm" id="frm">
<body>

	<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
		<div style="margin-left:10px;">
			<a class="navbar-brand" href="/">home</a>
		</div>
	</nav>
	<div class="container">
		<div style="margin-top:50px;">
				
			<div class="card mb-3">
				<h5 class="card-header">Signup</h5>
				<div class="card-body">
					<ul class="list-group list-group-flush">
						<li class="list-group-item">
						
							<div class="input-group mb-3">
							
								<label class="col-sm-3 col-form-label">아이디</label>
								<input type="text" class="form-control-plaintext" id="userId" name="userId" aria-describedby="emailHelp" placeholder="Enter ID" maxlength =30>
								<button type="button" class="btn btn-secondary" name="idck" id="idck">중복확인</button>
							
							</div>
							
							<div class="input-group mb-3">
							
								<label class="col-sm-3 col-form-label">비밀번호</label>
								<input type="password" class="form-control-plaintext" id="pw1" name="userPw" onkeyup="rePw()" aria-describedby="emailHelp" placeholder="Enter Password"  maxlength =32>
							
							</div>
							
							<div class="input-group mb-3">
							
								<label class="col-sm-3 col-form-label">비밀번호 확인</label>
								<input type="password" class="form-control-plaintext" id="pw2" onkeyup="checkPw()" aria-describedby="emailHelp" placeholder="Password Confirm"  maxlength =32>
							</div>
							
							<p id="checkPw" class="input-group mb-3">&nbsp;</p>
							
						</li>
						<li class="list-group-item">
							<div class="input-group mb-3">
								<label class="col-sm-3 col-form-label" maxlength =100>이메일</label>
								<input type="text" class="form-control-plaintext" id="email" name="userEmail" onkeyup="chkEmail()" aria-describedby="emailHelp" placeholder="Example@example.com">
							</div>
							<p id="checkEm" class="input-group mb-3">&nbsp;</p>
						</li>
						<li class="list-group-item">
							<div align="right">
								<input type="button" class="btn btn-primary" id="sbmt" value="회원가입">
							</div>
						</li>
					</ul>
				</div>
				
				<div class="card-footer" align="right">
					<a class="text-muted" href="/" ><b>돌아가기</b></a>
				</div>
				
			</div>
			
		</div>
	</div>


</body>
</form>
</html>