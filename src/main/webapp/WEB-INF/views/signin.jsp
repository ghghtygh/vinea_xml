<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<title>Signin</title>

<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
<link href="<c:url value='/resources/css/bootstrap.css' />" rel="stylesheet">
<link href="<c:url value='/resources/css/_bootswatch.scss' />" rel="stylesheet">
<link href="<c:url value='/resources/css/_variables.scss' />" rel="stylesheet">



</head>
<form>
<body>

	<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
		<div style="margin-left:10px;">
			<a class="navbar-brand" href="/">home</a>
		</div>
	</nav>
	<div class="container">
		<div style="margin-top:50px;">
				
			<div class="card mb-3">
			
				<h3 class="card-header">Signin</h3>
				<ul class="list-group list-group-flush">
					<li class="list-group-item">
					
						<div class="card-body">
							<div class="input-group mb-3">
								<label class="col-sm-3 col-form-label">아이디</label>
								<c:choose>
									<c:when test="${empty userId||userId==''}">
										    
										<input type="text" autofocus name="userId" class="form-control-plaintext" aria-describedby="emailHelp" placeholder="Enter ID" maxlength =30>
							
									</c:when>
										    
								    <c:otherwise>
										<input type="text" autofocus name="userId" value="${userId}" class="form-control-plaintext" maxlength =30>							
								    </c:otherwise>
										    
								</c:choose>
							</div>
							<div class="input-group mb-3">
							
								<label class="col-sm-3 col-form-label">비밀번호</label>
								<input type="password" class="form-control-plaintext" name="userPw" placeholder="Password"  maxlength =32>
							
							</div>
							<div align="center" class="text-danger">
								&nbsp;
								<c:if test="${!(empty userId||userId=='')}">
									아이디 비밀번호 불일치
								</c:if>
							</div>
							<div align="right">
								<button type="submit" class="btn btn-primary" formaction="signin" formmethod="post">로그인</button>
							
								<button type="submit" class="btn btn-secondary" formaction="/doSignup" formmethod="post">회원가입</button>
							</div>
						</div>
						
					</li>
				</ul>
				<div align="right" class="card-footer">
					<a class="text-muted" href="/" ><b>돌아가기</b></a>
				</div>
				
			</div>
			
		</div>
	</div>

</body>
</form>
</html>
