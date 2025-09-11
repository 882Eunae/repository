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
	//데이터베이스 설정 
	String url = "jdbc:mariadb://localhost:3306/test"; // DB 이름 test
	String user = "root";                             // 사용자
	String password = "1234";   // 비밀번호
	PreparedStatement ptmt; //객체생성 
	
	String userId=(String) session.getAttribute("userId");  
	String addSql="INSERT INTO board (title, id, content) values(?, ?, ?)"; 
	
	
 try{
	// 데이터접근 생성
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection(url, user, password);
	ptmt = conn.prepareStatement("INSERT INTO board (title, id, content) values(?,?,?)");
	
	

	
	
	
	
	
 }catch(Exception e){
	     e.printStackTrace();
    }	
	

	
	

%>
</body>
</html>