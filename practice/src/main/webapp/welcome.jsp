<%@page import="java.sql.Statement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
</head>
<body>
<%
  request.setCharacterEncoding("UTF-8");
  String userId=(String) session.getAttribute("userId");
  
  String url = "jdbc:mariadb://localhost:3306/test"; // DB 이름 test
  String user = "root";                             // 사용자
  String password = "1234";   // 비밀번호
  PreparedStatement ptmt;
  Statement st;  
  int count = 1;
  
   //쿼리문
  ArrayList<String> arr = new ArrayList<String>();
  
  
%>
 <h3>환영합니다~ ! <%=userId%>님</h3>

 
	 <nav class="navbar navbar-light bg-light">
	  <div class="container-fluid">
	    <a class="navbar-brand" href="write.jsp">게시글 쓰기</a> 
	  </div> 
	</nav>
  
    <table width="300" border="1">
		<thead>
		    <th>번호</th>
			<th>제목</th>
			<th>아이디</th>
			<th>삭제</th>
		</thead>
	<%
		Class.forName("org.mariadb.jdbc.Driver");	
		Connection conn = DriverManager.getConnection(url, user, password);
		Statement stmt; 
	    System.out.println("MariaDB 연결 성공!dfsfsdfsdfds");
	    String sql="select * from board order by board_no desc";
	    
	    int boardNo;  

			try {	
				stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(sql); 		
				while (rs.next()) {
					String no = rs.getString("board_no");
					String id = rs.getString("id");
					String title = rs.getString("title");
		%>
		 <tbody>
		   <td>	
				<form action="detail.jsp" method="post" id="form1" >
						<input type="submit" value="<%=no%>" name="boardNo" onclick="send();"></input>
				</form>
		    </td>
			<td><%=title %></td>
			<td><%=id %></td>
			<td>
				<form action="delete.jsp" method="post" id="delForm">
					<input  type="submit" value="<%=no%>" name="boardNo"">삭제</input>
				</form>
			</td>
		<% 
				}	
			} catch (SQLException ex) {
				out.println("Member 테이블 호출 실패<br>");
				out.println("SQLExeption: " + ex.getMessage());
			} finally {
				conn.close();
			}
		%>
		 </tbody>
	</table>
</body>
<script>
	function send(){
		var f1=document.getElementById("form1");
		f1.submit();
	}
</script>
</html>