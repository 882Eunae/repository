<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <style>
       .box{
		 width: 300px; 
		 display: block; 
		 margin: auto;			
	     margin-top: 200px;
		}
		
		 .fileInput {
	      margin-bottom: 20px; /* 요소 아래쪽 바깥 여백 */
  		}	
    
    </style>
</head>
<body>

	<% 
		request.setCharacterEncoding("UTF-8");
		String userId=(String) session.getAttribute("userId"); //아이디,번호,내용,날짜,글번호 
		
	
	%>
	<div class="box">
		<h3>게시글쓰기</h3>
		<form method="post" action="writehandle.jsp" enctype="multipart/form-data">
		    <span>작성자 :<a><%=userId %></a></span><br>
			<input type="text" id="title" style="width: 252px;"  name="title" required="required" placeholder="제목을 입력해주세요."  ><br> 
			<textarea id="content" cols="30" rows="10" name="content"  style="width: 252px;" placeholder="글을 입력해주세요." required="required"></textarea><br>
			<input type="file" name="attach"><br>
		    <button class="btn btn-primary" type="submit">글등록</button>   
		</form>
	</div>
</body>
</body>
</html>