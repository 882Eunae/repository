<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <%
	try{	  
		  if(session.getAttribute("userId") != null ){
			  session.invalidate();
		  }
	} catch (Exception e ){
		out.println(e);
	}finally{
		response.sendRedirect("login.jsp"); 
	}
   
 %>


	<h3>로그아웃</h3>
</body>
</html>