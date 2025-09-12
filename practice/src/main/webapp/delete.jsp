<%@page import="java.sql.SQLException"%>
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
		int no=Integer.parseInt(request.getParameter("boardNo")); 
		out.println(no); 
		
		 String url = "jdbc:mariadb://localhost:3306/test"; // DB 이름 test
		 String user = "root";                             // 사용자
		 String password = "1234";   // 비밀번호
		 PreparedStatement ptmt;
		
		 Class.forName("org.mariadb.jdbc.Driver");	
		 Connection conn = DriverManager.getConnection(url, user, password);
		 String sql="DELETE FROM board WHERE board_no = ?";
		 
		 try{
			 ptmt=conn.prepareStatement(sql);
			 ptmt.setInt(1, no); 
			 
			 ptmt.executeUpdate(); 
			 response.sendRedirect("welcome.jsp"); 
			 
		 }catch(SQLException e){
			 out.println("삭제를 실패하였습니다"); 
		 }finally{
			 conn.close();
		 }
		
	 %>
	<h3>삭제하기 </h3>
	
</body>
</html>