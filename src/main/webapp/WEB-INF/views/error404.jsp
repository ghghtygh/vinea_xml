<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page isErrorPage="true"%>
<%
	response.setStatus(200);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>404 Error</title>
<!-- CSS -->
<link href="/resources/css1/styles.css" rel="stylesheet" />
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />
<link href="/resources/css/_bootswatch.scss" rel="stylesheet">
<link href="/resources/css/_variables.scss" rel="stylesheet">

<!-- JAVSCRIPT, JQUERY -->
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/js/all.min.js" crossorigin="anonymous"></script>
</head>
<body>
	<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
		<a class="navbar-brand" href="/">XML Statics</a>
		<button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle" href="#">
			<i class="fas fa-bars"></i>
		</button>
		<!-- 홈버튼-->
		<div style="margin-left: 1600px">
			<ul class="navbar-nav ml-auto ml-md-0">
				<li class="nav-item dropdown"><a class="nav-link" id="userDropdown" href="/" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-home"></i></a></li>
			</ul>
		</div>
	</nav>
	<div id="layoutError">
		<div id="layoutError_content">
			<main>
			<div class="container">
				<div class="row justify-content-center">
					<div class="col-lg-6">
						<div class="text-center mt-4">
							<img class="mb-4 img-error" src="/resources/image/error-404-monochrome.svg" />
							<p class="lead">This requested URL was not found on this server.</p>
							<a href="/"><i class="fas fa-arrow-left mr-1"></i>Return to Home</a>
						</div>
					</div>
				</div>
			</div>
			</main>
		</div>
		<div id="layoutError_footer">
			<footer class="py-4 bg-light mt-auto">
			<div class="container-fluid">
				<div class="d-flex align-items-center justify-content-between small">
					<div class="text-muted">Copyright &copy; Your Website 2019</div>
					<div>
						<a href="#">Privacy Policy</a> &middot; <a href="#">Terms &amp; Conditions</a>
					</div>
				</div>
			</div>
			</footer>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.4.1.min.js" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
	<script src="js/scripts.js"></script>
</body>
</html>