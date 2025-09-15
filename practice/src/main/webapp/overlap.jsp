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
	   

	   //데이터베이스 정보 
	 	String url = "jdbc:mariadb://localhost:3306/test"; // DB 이름 test
	 	String user = "root";                             // 사용자
	 	String password = "1234";   // 비밀번호
	 	
	   //sql 
	 	String sql="select * from member where id = ?";
	 	PreparedStatement ptmt; //객체생성
	 	
	 	Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection(url, user, password);
	 	
		//파라미터로 받아온값 
	    String checkId=request.getParameter("checkId");
	    String name=request.getParameter("name");
	    String pw=request.getParameter("password");
		String email=request.getParameter("email"); 
		String address=request.getParameter("address");
		
		//파라미터 전달값 넘기기 
	 	ptmt=conn.prepareStatement(sql);
	 	ptmt.setString(1,checkId); 
	 	
	 	ResultSet rs = ptmt.executeQuery(); 
	 	
	 	if(rs.next()){
			session.setAttribute("overlap", "overlap"); 		 		
	 	}else{
	 		session.setAttribute("overlap", "no" ); 
	 	}
	 	//세션값에 저장하기
	 	session.setAttribute("writeId", checkId); //사용자가 작성한 아이디 
		session.setAttribute("name", name); 
		session.setAttribute("pw", pw); 
		session.setAttribute("email", email); 
		session.setAttribute("address", address);   
	 	
	 	
	 	
	 	response.sendRedirect("index.jsp");

	%>
</body>
</html>