<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>게시글쓰기</h3>

<% 
	request.setCharacterEncoding("UTF-8");
	String userId=(String) session.getAttribute("userId"); //아이디,번호,내용,날짜,글번호
	
%>

<form method="post" action="welcome.jsp">
    <span>작성자<a><%=userId %></a></span><br>
	<input type="text" id="title" name="title" ><br> 
	<textarea id="content" cols="30" rows="10" placeholder="글을 입력해주세요."></textarea>
    <input type="submit" value="글등록" />  
</form>
</body>
</body>
</html>