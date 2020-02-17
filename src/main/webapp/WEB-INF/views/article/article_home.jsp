<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<!-- JQUERY, JAVASCRIPT -->
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>

<!--  CSS -->
<link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800,900" rel="stylesheet">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/resources/css/style.css">
<link href="/resources/css/_bootswatch.scss" rel="stylesheet">
 <link href="/resources/css/_variables.scss" rel="stylesheet">

<script>
	var m_chk = false;

	var searchs = "${search}";
	
	/** document 로딩 **/
	$(document).ready(function() {

		$("#loading").hide();

		
		$("input[name='search']").val(searchs);
		
		$('#search_option option[value="${search_option}"]').attr("selected",true);
		
		$('#sort_option option[value="${sort_option}"]').attr("selected",true);
		
		
		
		/** 정렬하기 **/
		$("#sort_option").on('change',function(){
			
			var sort_option = $(this).val();
			
			
			var formObj = $("#frm");
			formObj.attr("action", "/article");
			formObj.attr("method", "get");
			formObj.submit();
			
		});
		
		$("#btn_search").on("click", function(e){
			e.preventDefault();
			
			var search = $("#input_search").val();
			
			$("input[name='search']").val(search);
			
			var formObj = $("#frm");
			formObj.attr("action", "/article");
			formObj.attr("method", "get");
			formObj.submit();
		});
		
		/** 알림창 닫기 **/
		$("#btn_alert_hide").on("click", function(e) {

			e.preventDefault();
			$("#div_alert").hide();

		});
		
		/** 모달 닫힐때 modal remote 데이터 지우기 **/
		$('body').on('hidden.bs.modal', '.modal', function () {
			
			//console.log("모달 닫힘");
			//$(this).find('.modal-content').empty();
		    $("#insertXML").removeData('bs.modal');
		});

		/** 메인 - [XML추가]버튼 : XML 데이터 파일 추가 창 열기_BootStrap Modal 활용  **/
		$("#btn_insertXML").on("click", function(e) {

			e.preventDefault();

			
			$("#div_alert").hide();

			input_chk();
			
			//$("#insertXML").modal();
			$("#insertXML").modal({remote:"article/parsing"});
			
			
		});

		/** 파싱모달 - [저장] 버튼 : insertXML - 파싱 후, xml(논문데이터) DB 저장  **/
		$("#btn_saveXml").click(function(e) {

			e.preventDefault();

			var filePath = $("#filePath").val();

			console.log(m_chk);

			if (!m_chk) {

				$("#alert_subject").html("XML 파일경로 미확인");
				$("#alert_content").html("XML 파일이 확인되지 않았습니다<br>파싱 버튼을 눌러주세요");
				$("#div_alert").show();
				return;
			}

			var result = confirm("파싱된 내용을 저장하시겠습니까?");

			if (result) {

				var formObj = $("#frm");
				formObj.attr("action", "/article/insert");
				formObj.attr("method", "post");
				formObj.submit();
			}

		});

		/** insertXml: ArtiParser.java에서 파싱코드 가져와서 xml(논문)데이터 파싱 **/
		$("#btn_chk").click(function(e) {

			$("#loading").show();

			e.preventDefault();

			clear_input();

			var filePath = $("#filePath").val();

			if (filePath == "") {

				$("#alert_subject").html("XML 경로 미입력");
				$("#alert_content").html("XML 경로를 입력하지 않았습니다");
				$("#div_alert").show();
				m_chk = false;
				return;
			}
			$("#div_alert").hide();

			$.ajax({
				async : true,
				url : "${pageContext.request.contextPath}/article/check",
				type : 'POST',
				data : {
					"filePath" : filePath
				},
				dataType : "json",
				success : function(data) {

					if (data == null) {

						$("#alert_subject").html("XML 파싱 실패");
						$("#alert_content").html("올바른 XML파일 경로를 입력하세요");
						$("#div_alert").show();
						m_chk = false;
						return;
					}

					var item_html = "";

					$.each(data, function(index, item) {
						item_html+=item['uid']+"<br>";
					});

					m_chk = true;

					$("#div_parse").html(item_html);

					$("#loading").hide();

				},
				error : function(request, error) {

					$("#alert_subject").html("XML 파싱 실패");
					$("#alert_content").html("올바른 XML파일 경로를 입력하세요");
					$("#div_alert").show();
					m_chk = false;
					return;
				}
			});

		});

	});
	/** document 로딩 끝 **/
	
	/** 페이지 이동  **/
	function fn_paging(nowPage) {

		var formObj = $("#frm");
		
		var input_page = document.createElement("input");
		$(input_page).attr("type","hidden");
		$(input_page).attr("name","page");
		$(input_page).attr("value",nowPage);
		formObj.append(input_page);
		
		formObj.attr("action", "/article");
		formObj.attr("method", "get");
		formObj.submit();

	}
	function input_chk() {

		clear_input();

		m_chk = false;

	}
	function clear_input() {
		$("#div_parse").html("");

	}
	
	function inputKey(){
		if(event.keyCode==13){
			var search = $("#input_search").val();
			
			$("input[name='search']").val(search);
			
			var formObj = $("#frm");
			formObj.attr("action", "/article");
			formObj.attr("method", "get");
			formObj.submit();
		}else{
			return true;
		}
	}
</script>


<style>
.modal-backdrop {
	position: fixed;
	top: 0;
	right: 0;
	bottom: 0;
	left: 0;
	z-index: 1030;
	background-color: #333333;
	opacity: 0.8;
}

input:read-only {
	border: 0px;
	width: 100%;
}

a {
	
}
</style>

</head>
<body>
<div class="wrapper d-flex align-items-stretch">
	    <!-- 전체 메뉴 사이드바 -->
		<nav id="sidebar">
			<div class="p-4 pt-5">
				<a href="/article" class="img logo rounded-circle mb-5" style="background-image: url(/resources/image/analyticx.png);"></a>
				<ul class="list-unstyled components mb-5">
					<li>
						<a href="#homeSubmenu" data-toggle="collapse" aria-expanded="true" class="dropdown-toggle">메인</a>
						<ul class="list-unstyled collapse show in" id="homeSubmenu" aria-expanded="true">
						<li>
							<a href="/article">논문보기</a>
						</li>
						</ul>
					</li>
						<li>
							<a href="#pageSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">현황</a>
							<ul class="collapse list-unstyled" id="pageSubmenu">
								<li class="active">
									<a href="/article/yearstat">연도별 현황</a>
								</li>
								<li>
									<a href="/article/orgnstat">소속기관별 현황</a>
								</li>
								<li>
									<a href="/article/ctgrstat">분야별 현황</a>
								</li>
								<li>
									<a href="/article/kwrdstat">키워드 현황</a>
								</li>
							</ul>
						</li>
				</ul>
				<div class="footer">
					<p>
						<script>
							document.write(new Date().getFullYear());
						</script>
							About XML Parsing
							<i class="icon-heart" aria-hidden="true"></i>
					</p>
					<p>
						made with by JuHyeon&Minjin 
						<a href="https://github.com/ghghtygh/vinea_xml.git" style="font-size: 12px" target="_blank">
							https://github.com/ghghtygh/vinea_xml.git
						</a>
				</div>
			</div>
		</nav>
		<!-- 메인 페이지  -->
		<div id="content" class="p-4 p-md-5">
			<nav class="navbar navbar-expand-lg navbar-light bg-light">
				<div class="container-fluid">
					<button type="button" id="sidebarCollapse" class="btn btn-primary">
						<i class="fa fa-bars"></i> <span class="sr-only">Toggle Menu</span>
					</button>
					<button class="btn btn-dark d-inline-block d-lg-none ml-auto" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
						<i class="fa fa-bars"></i>
					</button>
					<div class="collapse navbar-collapse" id="navbarSupportedContent">
						<ul class="nav navbar-nav ml-auto">
							<li class="nav-item active"><a class="nav-link" href="/article">Home</a></li>
						</ul>
					</div>
				</div>
			</nav>

		</div>
</div>	
</body>
</html>