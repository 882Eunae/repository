<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
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
	    //사용자가 직접입력한 id	   
	   String id=request.getParameter("id"); 
  
	   //데이터베이스 정보 
	 	String url = "jdbc:mariadb://localhost:3306/test"; // DB 이름 test
	 	String user = "root";                             // 사용자
	 	String password = "1234";   // 비밀번호
	 	
	   //sql 
	 	String sql="select * from member where id = ?";
	 	PreparedStatement ptmt; //객체생성
	 	
	 	Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection(url, user, password);
	 	
		//파라미터 전달값 넘기기 
	 	ptmt=conn.prepareStatement(sql);
	 	ptmt.setString(1,id); 
	 	
	 	ResultSet rs = ptmt.executeQuery(); 
	 	
	 	String overlap; 
	 	if(rs.next()){
	 		session.setAttribute("overlap", "overlap"); //중복값 존재   
	 	}else{
	 		session.setAttribute("overlap", "no"); //중복값이 없음 
	 	}
	 		//중복확인후 다시 회원가입 페이지 이동 
	 		response.sendRedirect("index.jsp"); 	
	
	%>
</body>
</html>