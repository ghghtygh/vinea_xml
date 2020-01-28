<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>Home2</title>
</head>
<body>
	<form>
	
    <h1>페이징테스트</h1>
 	
 	<c:catch>
	    <c:choose>
	    
	        <c:when test="${empty user }">
	            <button type="submit" formaction="signin" formmethod="get">로그인</button>
 				<button type="submit" formaction="signup">회원가입</button>
	        </c:when>
	        
	        <c:otherwise>
	        
	            <c:choose>
	            
	                <c:when test="${user.user_num eq 1 }">
	                       <p>관리자 ${user.user_id} 로그인</p>
	                       <a href="/signout"> 로그아웃</a>
	                </c:when>
	                
	                <c:otherwise>
	                       <p>${user.user_id} 로그인</p>
	                       <a href="/signout"> 로그아웃</a>
	                </c:otherwise>
	                
	            </c:choose>
	            
	        </c:otherwise>
	    </c:choose>
	</c:catch>

 	
 	<hr>
	    <table>
	        <thead>
	            <tr>
	            	<th width="50">글번호</th>
	                <th width="100">제목</th>
	                <th width="50">작성자</th>
	                <th width="40">날짜</th>
	                <th width="40">시간</th>
	                <th width="50">조회수</th>
	            </tr>
	        </thead>
	        <tbody>
	            <c:forEach items="${postList}" var="post">
	                <tr>
	                	<td>${post.post_num}</td>
	                    <td><a href='/read?num=${post.post_num}'>${post.title}</a></td>
	                    <td>${post.wrt_id}</td>
	                    <td>${post.date}</td>
	                    <td>${post.time}</td>
	                    <td>${post.view_cnt}</td>
	                </tr>
	            </c:forEach>
	        </tbody>
	    </table>

    	<button type="submit" formaction="write" formmethod="get">글 쓰기</button>
    </form>
</body>
</html>