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
 	
	
try{	
	
	String loginUser=(String)session.getAttribute("userId") ; //로그인유저 
	String userId=request.getParameter("userId");  //게시글작성자 id 
	
	if(loginUser.equals(userId )){
	
	//파라미터 전달값 넘기기 
 	ptmt=conn.prepareStatement(sql);
 	ptmt.setString(1,title); 
 	ptmt.setString(2,content);    
 	ptmt.setInt(3,boardNo);
 	
 	ptmt.executeUpdate(); 
 	response.sendRedirect("welcome.jsp"); 
	}
	
	else{
 		out.println("글작성자,로그인유저 정보가 달라 수정불가합니다");
		out.println(title); 
	}	
 	// 수정할떄 user와 글작성자 비교하기 
 		
} catch(Exception e){
	e.printStackTrace(); 
	out.println(e);
	response.sendRedirect("detail.jsp?boardNo="+boardNo);   //수정실패시 원래 화면에 돌아가있기 
}finally{
	conn.close();
}
 
%>
<h3>수정하기</h3>
</body>
</html>