<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <%  

	request.setCharacterEncoding("UTF-8"); 
	
	String url = "jdbc:mariadb://localhost:3306/test"; // DB 이름 test
	String user = "root";                             // 사용자
	String password = "1234";   // 비밀번호
	PreparedStatement ptmt;
	 
	String addSql="insert into member(name,id,password,join_date,email,address) values(?,?,?,sysdate(),?,?)"; 
	
	ArrayList<String> arr = new ArrayList<String>(); //결과 담을 변수
	int count = 1;
	
	//form 태그 안에서 파라미터 받아오기  
	String name=request.getParameter("name"); 
	String id=request.getParameter("id");
	String pw=request.getParameter("password");
	String email=request.getParameter("email"); 
	String address=request.getParameter("address");

    // JDBC Driver 로드 (신버전은 생략 가능)
    Class.forName("org.mariadb.jdbc.Driver");
    Connection conn = DriverManager.getConnection(url, user, password);
try {
    System.out.println("MariaDB 연결 성공!dfsfsdfsdfds");
    	
	ptmt = conn.prepareStatement(addSql);
	ptmt.setString(1, name);
	System.out.println("setString");
	ptmt.setString(2,id);
	ptmt.setString(3,pw);
	ptmt.setString(4, email);
	ptmt.setString(5,address);
	
	ptmt.executeUpdate(); //실행 
	System.out.println("실행성공");
	//ResultSet rs = ptmt.executeQuery(); => ptmt를 2번 실행해서 오류가남 
	
	response.sendRedirect("login.jsp");

} catch (Exception e) {
	System.out.println("db연결실패...");
    e.printStackTrace();   
    out.println(e);
    
    response.sendRedirect("index.jsp");
}finally{
	System.out.println("id값"+id);
    conn.close();
} 
%>

<h3>회원가입 실패</h3>
</body>
</html>