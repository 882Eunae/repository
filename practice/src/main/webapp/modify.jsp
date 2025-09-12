<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
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
   request.setCharacterEncoding("UTF-8"); 
   
   //board 번호 post에서 넘어온값 
   int boardNo= Integer.parseInt(request.getParameter("boardNo")); 
   String title=request.getParameter("title"); 
   String content=request.getParameter("content"); 
     
   //데이터베이스 정보 
 	String url = "jdbc:mariadb://localhost:3306/test"; // DB 이름 test
 	String user = "root";                             // 사용자
 	String password = "1234";   // 비밀번호
 	
   //sql 
 	String sql="UPDATE board SET title= ? , content= ?  WHERE board_no= ? ";
 	PreparedStatement ptmt; //객체생성
 	
 	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection(url, user, password);
 	
	//파라미터 전달값 넘기기 
 	ptmt=conn.prepareStatement(sql);
 	ptmt.setString(1,title); 
 	ptmt.setString(2,content);    
 	ptmt.setInt(3,boardNo);
 	
 	ptmt.executeUpdate(); 
 	
 	out.println(title); 
 	
 	response.sendRedirect("welcome.jsp"); 

%>
<h3>수정하기</h3>
</body>
</html>