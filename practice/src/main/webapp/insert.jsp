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
    	
	ptmt = conn.prepareStatement(addSql);
	ptmt.setString(1, name);
	System.out.println("setString");
	ptmt.setString(2,id);
	ptmt.setString(3,pw);
	ptmt.setString(4, email);
	ptmt.setString(5,address);
	
	ptmt.executeUpdate(); //실행 
	System.out.println("실행성공");
			
	response.sendRedirect("login.jsp");

} catch (Exception e) {
	
    e.printStackTrace();   
    out.println(e);
    
    response.sendRedirect("index.jsp");
}finally{
	
	//회원가입 성공시 input값에서 받아온 이름값 삭제하기, 회원가입 페이지 한번 더 들어갔을떄 session 값이 그대로 남아있음
	session.removeAttribute("name"); 
	session.removeAttribute("writeId"); 
	session.removeAttribute("pw"); 
	session.removeAttribute("email"); 
	session.removeAttribute("address");  
	
    conn.close();
} 
%>

<h3>회원가입 실패</h3>
</body>
</html>