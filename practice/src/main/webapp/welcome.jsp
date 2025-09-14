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
	 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
<style>
	body {
  		width: 900px; 
  		margin-left:auto;
  		margin-right:auto;

	}
</style>	
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
   
%>
	 <h3>환영합니다~ ! <%=userId%>님</h3>
	
	 <input type="hidden" id="sessionId" value="<%=userId%>"></input>
	<div class="container">
	 <nav class="navbar navbar-light bg-light" style="margin-bottom: 20px;" >
	  <div class="container-fluid">
	    <a class="navbar-brand" href="write.jsp">게시글 쓰기</a> 
	  </div> 
	</nav>
    <table width="500" border="1" style="margin-bottom: 20px;">
		<thead>
		    <th>번호</th>
			<th>제목</th>
			<th>아이디</th>
			<th>ㅁ</th>
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
			  <%=no%>	
			</td>
			<td>
			  <a href="detail.jsp?boardNo=<%=no%>"><%=title %></a>
			 </td>
			<td><%=id %></td>
			<td>
			  <input id="checkNo" type="checkbox" name="checkNo"  value="<%=no%>"></input>
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
	
	<button type="button" class="btn btn-primary" onClick="button();" style="float: right; margin-right: 370px;">삭제하기</button>
	
	</div>	
</body>
<script>
	function send(){
		var f1=document.getElementById("form1");
		f1.submit();
	}
	
	console.log($('#sessionId').val()); 
	
	//중복선택 방지 
//	function multiNo(chk){
//			var obj = document.getElementsByName("checkNo");
//			 for(var i=0; i<obj.length; i++){
//			     if(obj[i] != chk){
//			        obj[i].checked = false;
//			  } 
//		}
//	}
	
	console.log('이게왜돼>');
	//삭제버튼 클릭 
	function button(){	
		
 		let checked=$('input[name="checkNo"]:checked');	
 		console.log(checked);	
		for(let i=0; i < checked.length; i++ ){
			console.log(checked[i].value); //boardNo가 출력
			location.href="delete.jsp?boardNo="+checked[i].value;
			alert(checked[i].value+"삭제완료"); //alert삭제 하면 한건만 삭제됨;; 
		}			
	}
</script>
</html>