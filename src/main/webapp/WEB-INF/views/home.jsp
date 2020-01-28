<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
<title>Home</title>

<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 

<link href="<c:url value='/resources/css/bootstrap.css' />" rel="stylesheet">
<link href="<c:url value='/resources/css/_bootswatch.scss' />" rel="stylesheet">
<link href="<c:url value='/resources/css/_variables.scss' />" rel="stylesheet">

<script>
	
	$(document).ready(function() {
		
		$("#chk_all").on("mouseover",function(){
			
			$("#nohover_tr").css("color","white");
		});
		
		$("#chk_all").on("click",function(){
			
			console.log($("input[name='chk_all']").prop('checked'));
			console.log($("input[name='chk_all']").attr('checked'));
			
			if($("#chk_all").prop('checked')){
				 //console.log("체크됨");
				 $("input[name='deletePostNo']").prop('checked',true);
			}else{
				//console.log("체크안댐");
				$("input[name='deletePostNo']").prop('checked',false);
			}
		});
		
		$("input[name='deletePostNo']").on("click",function(){
			
			$("input[name='chk_all']").prop('checked',false);
		});
		
		
		$("#del_sbmt").click(function(){
			
			var result = false;
			var count = $("input[name='deletePostNo']:checked").length;
			if (count<=0){
				
				alert("선택된 게시글이 없습니다");
				
				return;
				
			}else if (count==1){
				
				result=confirm("1개의 게시글이 선택되었습니다.\n삭제하시겠습니까 ?");
				
			}else{
				
				result=confirm("총 "+$("input[name='deletePostNo']:checked").length+"개의 게시글이 선택되었습니다.\n모두 삭제하시겠습니까 ?");
				
			}
			
			if(result){
				var formObj = $("#frm");
				formObj.attr("action","/doDelete");
				formObj.attr("method","post");
				formObj.submit();
			}
			
		});
		
	});
	
	var kw = "${keyword}";
	var so = "${searchOption}";
	
	function fn_paging(nowPage) {
		
		var url="/?page="+nowPage;
		
		
		if (kw!=""){
			
			url+="&searchOption=";
			url+=so;
			url+="&keyword=";
			url+=kw;
		}
		
		location.href=url;
		
	}
	
	function goHome(){
		
		location.href="/";
	}
	
</script>

<style>

#nohover:not(.chk){
	//pointer-events:none;
}

body.a{
	text
}
</style>
</head>
<body>
<form id="frm">
	
		<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
			<div style="margin-left:10px;">
				<a class="navbar-brand" href="/">home</a>
			</div>
		</nav>
		
		<div class="container">
		
			<div>
				<div style="margin-top:50px;">
				
					<div class="col-lg-8 col-md-7 col-sm-6">
					
						<h3>게시판</h3>
					</div>
					
				</div>
				<div align="right">
				    <div class="btn-group btn-group-toggle" >
					 	<c:catch>
						    <c:choose>
						        <c:when test="${empty user }">
						        
							        <input type="button" class="btn btn-primary" onClick="location.href='/signin'" value="로그인">
							        <input type="button" class="btn btn-primary" onClick="location.href='/signup'" value="회원가입">
							        
						        </c:when>
						        <c:when test="${user.userId eq 'admin' }">
						        
				                       <p class="btn btn-primary disabled">
				                       		관리자 ${user.userId}
				                       	</p>
				                       	
				                       <input type="button" class="btn btn-primary" onClick="location.href='/signout'" value="로그아웃">
							        
				                </c:when>
				                
				                <c:otherwise>
				                       <p class="btn btn-primary disabled">
				                       
				                       		${user.userId}
				                       
				                       </p>
				                       
				                       <input type="button" class="btn btn-primary" onClick="location.href='/signout'" value="로그아웃">
							        
				                </c:otherwise>
						                
						    </c:choose>
						</c:catch>
				
				 	</div>
			 	</div>
		 	</div>
		 	
		 	<div style="margin-top:20px;">
		 	
				<div style="float:left;">
					<c:choose>
		 				<c:when test="${!(keyword==''||empty keyword)}">
		 				
		 					검색결과 : ${pager.listCnt}개 |
		 					
		 					<a href="/">전체 보기</a>
		 					
		 				</c:when>
		 				<c:otherwise>
		 					총 게시글 : ${pager.listCnt}개
		 				</c:otherwise>
		 			</c:choose>
	 			</div>
	 			
	 			<div style="float: right;">
	 			
		 			<div class ="form-inline form-group" align="right">
		 			
						<select class="form-control" style="width:auto; margin-left:20px; margin-right: 5px;" name="searchOption">
							
							<option value='all' selected>전체</option>
							<option value='content'>내용</option>
							<option value='title'>제목</option>
							<option value='userId'>작성자</option>
						
						
						</select>
				
						
						<input type="text" class="form-control" style="margin-right: 5px;"id="kw" name="keyword">
						
						<button type="submit" class="btn btn-secondary" style="margin-right: 5px;" formaction="/">검색</button>
					
					</div>
				</div>
			</div>
			
	 		
		 	<div>
				<div align="center">
				
				    <table class="table table-hover" style="width:100%; max-width: 1200px; font-size:100%; text-align:center; table-layout:fixed; word-break:break-all;">
				        <thead>
				        	<colgroup>
				        		<col width="2%"/>
				        		<col width="8%"/>
				        		<col width="37%"/>
				        		<col width="15%"/>
				        		<col width="29%"/>
				        		<col width="9%"/>
				        	</colgroup>
				        	
				            
				        </thead>
				        <tbody>
				        	<tr class="table-primary" id="nohover_tr">
				            
								<td id="nohover_td" style="pointer-events:none;">
									<c:if test="${!(empty user.userId)}">
										<input style="pointer-events: all;" type="checkbox" name="chk_all" id="chk_all">
									</c:if>
				            	</td>
				            	<td style="pointer-events:none;">글번호</td>
				                <td style="pointer-events:none;">제목</td>
				                <td style="pointer-events:none;">작성자</td>
				                <td style="pointer-events:none;">작성일</td>
				                <td style="pointer-events:none;">조회수</td>
				            </tr>
				            
				        	<c:if test="${pager.listCnt<=0}">
				        		<tr>
				        			<td colspan="6">
				        				<c:choose>
							        		<c:when test="${(keyword==''||empty keyword)}">
							        			게시글이 없습니다.
							        		</c:when>
							        		<c:otherwise>
							        			검색결과가 없습니다.
							        		</c:otherwise>
							        	</c:choose>
				        			</td>
				        		</tr>
				        	</c:if>
				            <c:forEach items="${postList}" var="post">
				                <tr class="table-light">
				                	<td>
					                	<c:if test="${(user.userId eq 'admin' )or(user.userId eq post.wrtId)}">
					                			<input type="checkbox" name="deletePostNo" value="${post.postNum}">
					                	</c:if>
				                	</td>
				                	<td>
				                		${post.postNum}
				                	</td>
				                    <td style="">
				                    	<div style="width:100%;">
					                    	
					                    	
					                    	<div style="width:90%;float:left;text-align:left;text-overflow:ellipsis; overflow:hidden;">
						                    	<nobr>
						                    	<c:choose>
							                    	<c:when test="${keyword eq ''||empty keyword}">
							                    		<a class="" href='/read?num=${post.postNum}&page=${pager.nowPage}' title="${post.title}"
								                    	 style="color:#2C3E50;font-weight:600;">
								                    		${post.title}
								                    	</a>					                    	
							                    	</c:when>
							                    	
							                    	<c:otherwise>
							                    		<a class="" href='/read?num=${post.postNum}&page=${pager.nowPage}&selectOption=${selectOption}&keyword=${keyword}' title="${post.title}"
								                    	 style="color:#2C3E50;font-weight:600;">
								                    		${post.title}
								                    	</a>
							                    	</c:otherwise>
						                    	
						                    	</c:choose>
						                    	
						                    	</nobr>
					                    	</div>
					                    	<div align="right" style="width:10%;float:right">
					                    		<c:if test="${post.countFiles>0}">
					                    			<img src='/resources/image/disk.ico' style="width:auto;height:15px;">
					                    		</c:if>
					                    	</div>
				                    	</div>
				                    </td>
				                    <td>${post.wrtId}</td>
				                    
				                    <td>
				                    	${fn:substring(post.wrtDt,0,16) }
				                    </td>
				                    <td style="text-align:right">${post.viewCnt}</td>
				                    
				                     
				                </tr>
				            </c:forEach>
				        </tbody>
				     </table>
				     
				</div>
				
				<div style="position:relative;">
					<div style="left:0;top:0;position:absolute;text-align:center;width:100%;">
					  
					  	<div class="btn-group mr-2" style="z-index:10;">
					  		<c:choose>
					  		
							  	<c:when test="${pager.nowPage ne 1 }">
							  	
							  		<a href='#' class="btn btn-primary" onClick="fn_paging(1)">처음</a>
									
									
								</c:when>
								<c:otherwise>
							  		<a class="btn btn-primary disabled">처음</a>
								</c:otherwise>
						  	</c:choose>
					  
						  	<c:choose>
							  	<c:when test="${pager.nowPage ne 1 }">
								    <a href="#" class="btn btn-primary" onClick="fn_paging('${pager.prevPage}')">&laquo;</a>
								</c:when>
								<c:otherwise>
								    <a class="btn btn-primary disabled">&laquo;</a>
								</c:otherwise>
						  	</c:choose>
					  	
						  	<c:forEach begin="${pager.startPage}" end="${pager.endPage}" var="pageNum">
								        	
				        		<c:choose>
				        		
				        			<c:when test="${pageNum eq pager.nowPage}">
				        				<a href="#" class="btn btn-primary active" onClick="fn_paging('${pageNum}')">${pageNum }</a>
				        				
				        			</c:when>
				        			
				        			<c:otherwise>
				        				<a href="#" class="btn btn-primary" onClick="fn_paging('${pageNum}')">${pageNum}</a>
										
									</c:otherwise>
						 			
								</c:choose>     
								   	
							</c:forEach>
				        	
				        	
							<c:choose>
								<c:when test="${pager.nowPage ne pager.pageCnt && pager.pageCnt > 0 }">
									
									<a class="btn btn-primary" href="#" onClick="fn_paging('${pager.nextPage}')">&raquo;</a>
									
									
								</c:when>
								<c:otherwise>
									
									<a class="btn btn-primary disabled">&raquo;</a>
									
								</c:otherwise>
						  	</c:choose>
							<c:choose>
							  	<c:when test="${pager.nowRange ne pager.rangeCnt && pager.rangeCnt>0 }">
							  		
							  		<a class="btn btn-primary" href="#" onClick="fn_paging('${pager.pageCnt}')">끝</a>
									
									
								</c:when>
								<c:otherwise>
									
									<a class="btn btn-primary disabled">끝</a>
									
								</c:otherwise>
						  	</c:choose>
					  	
					  	</div>
					</div>
					
					<div style="left:0;top:0;position:absolute;text-align:right;width:100%;">
						
						<c:if test="${!(empty user)}">
							<input type="button" class="btn btn-secondary" style="margin-right: 5px;" id="del_sbmt" value="게시글 삭제">
						</c:if>
						<input type="button" class="btn btn-primary" style="margin-right: 5px;" onClick="location.href='/write'" value="게시글 작성">
					</div>
					
				</div>
				
			</div>
    	</div>
    </form>
</body>
</html>