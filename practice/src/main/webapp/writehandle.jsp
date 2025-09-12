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
    //인코딩 방식 설정  
	request.setCharacterEncoding("UTF-8"); 

	//데이터베이스 정보 
	String url = "jdbc:mariadb://localhost:3306/test"; // DB 이름 test
	String user = "root";                             // 사용자
	String password = "1234";   // 비밀번호
	PreparedStatement ptmt; //객체생성 
	
	
	String addSql="INSERT INTO board (title, id, content) values(?, ?, ?)"; 
	
	//form  받아오기 
	String title = request.getParameter("title"); 
	String content = request.getParameter("content");  
	
	//작성자 세션정보 받아오기
	String userId=(String) session.getAttribute("userId");
	
	System.out.println(title);
	
 try{
	 
	// 데이터접근 생성
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection(url, user, password);
	//어떤 sql을 쓸건지 
	ptmt = conn.prepareStatement(addSql);
	//파라미터 값 전달
	ptmt.setString(1,title);
	ptmt.setString(2,userId);
	ptmt.setString(3,content);
	//실행 
	ptmt.executeUpdate(); 
	
	//글 등록후 다시 welcome 페이지 이동 
	response.sendRedirect("welcome.jsp"); 

	
 }catch(Exception e){
	     e.printStackTrace();
    }	

%>
</body>
</html>