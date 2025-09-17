<%@page import="java.beans.Statement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
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
	
  	String selectKey = request.getParameter("searchKey"); //selectKey 
    String searchVal =  request.getParameter("searchVal"); //검색입력값
  	String column=null; 
       
  	if("title".equals(selectKey)){
  		column = "title";
  	}else if("content".equals(selectKey)){
  		column="content"; 
  	}else if("writer".equals(selectKey)){
  		column="member_id";
  	}    
  	
  	
  %>
  
   <table width="876" border="1" style="margin-bottom: 20px;">
		<thead>
			<th><input type="checkbox"></input></th>
		    <th>번호</th>
			<th>제목</th>
			<th>아이디</th>
		</thead>
		<%
		
		Class.forName("org.mariadb.jdbc.Driver");	
		Connection conn = DriverManager.getConnection(url, user, password);
		String sql = "SELECT * FROM board  WHERE " + column + " LIKE ?";    
		PreparedStatement ptmt = conn.prepareStatement(sql);
		
	  	ptmt.setString(1, "%" + searchVal + "%"); // 부분검색용

	    int boardNo;  

			try {	
			
				ResultSet rs = ptmt.executeQuery(); 		
				while (rs.next()) {
					String no = rs.getString("board_no");
					String id = rs.getString("member_id");
					String title = rs.getString("title");
		%>
		 <tbody>
		    <td>
			  <input id="checkNo" type="checkbox" name="checkNo" value="<%=no%>"></input>
			</td>
		   <td>	
			  <%=no%>	
			</td>
			<td>
			  <a href="detail.jsp?boardNo=<%=no%>"><%=title %></a>
			 </td>
			<td><%=id %></td>
			
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
	
  <!-- 	
	<button type="button" class="btn btn-primary" onClick="button();" style="float: right; margin-right: 10px; background-color="#b8fabe">삭제하기</button>
   -->	
	</div>	
	</table>
	
</body>
</html>