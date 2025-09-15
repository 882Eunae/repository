<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.util.ArrayList"%>
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


String url = "jdbc:mariadb://localhost:3306/test"; // DB 이름 test
String user = "root";                             // 사용자
String password = "1234";   // 비밀번호
PreparedStatement ptmt;
ResultSet rs = null;

String id=request.getParameter("id");
String pw=request.getParameter("password");

out.println(id+pw);
String sql="SELECT * FROM member WHERE id = ? AND PASSWORD = ?"; //쿼리문

int count = 1;
Connection conn = DriverManager.getConnection(url, user, password);

try {
	    Class.forName("org.mariadb.jdbc.Driver");    
        ptmt = conn.prepareStatement(sql);
        ptmt.setString(1, id);
        ptmt.setString(2, pw);
        rs = ptmt.executeQuery();

        if (rs.next()) {
            session.setAttribute("userId", id);
            session.setAttribute("loginCheck", "success");
            response.sendRedirect("welcome.jsp");
        } else {
            session.setAttribute("loginCheck", "fail");
            response.sendRedirect("login.jsp");
        } 
} catch (Exception e) {
	System.out.println("로그인실패ㅜㅜㅜ ");
    e.printStackTrace();
}finally{
	 conn.close();
} 	
%>
<h3>로그인처리화면!</h3>
</body>
</html>