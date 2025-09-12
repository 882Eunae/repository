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
		<!-- 부트스트랩 적용 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<%
   request.setCharacterEncoding("UTF-8"); 
   
   //board 번호 
   int boardNo= Integer.parseInt(request.getParameter("boardNo")); 
   
   
   //데이터베이스 정보 
 	String url = "jdbc:mariadb://localhost:3306/test"; // DB 이름 test
 	String user = "root";                             // 사용자
 	String password = "1234";   // 비밀번호
   //sql 
 	String sql="SELECT * FROM board WHERE board_no = ?";
 	PreparedStatement ptmt; //객체생성
 	
 	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection(url, user, password);
 	
 	ptmt=conn.prepareStatement(sql);
 	ptmt.setInt(1,boardNo); 
    
 	ResultSet rs = ptmt.executeQuery();
 	
 	String title=null; 
    String content=null; 
    String userId=null; 
    
 	if(rs.next()){
 		 title=rs.getString("title");
 		 content=rs.getString("content");
		 userId=rs.getString("id"); 		
 	}
 
%>

	<h3>상세조회</h3>
	<div>
		<div>
			<form action="modify.jsp" method="post" id="form1" >
			<a>작성자 : <%=userId %></a>
				<input type="hidden" value="<%=boardNo%>" name="boardNo">
				<input type="hidden" value="<%=userId%>" name="userId">
			<div class="mb-3 row">
			  <div class="col-sm-10">
			    <input type="text" style="width: 252px;  class="form-control-plaintext" id="title" value="<%=title%>" name="title" required="required" >
			  </div>
			</div>
			<div class="mb-3 row">
			  <div class="col-sm-10">
			    <input  value="<%=content %>" style="width: 252px; height: 190px;"  id="content" class="form-control" name="content" required="required">
			  </div>
			</div>
			 <a class="btn btn-primary" href="welcome.jsp" role="button">글목록이동</a>
			<input  class="btn btn-primary" type="submit" id="modify"  name="boardNo" onclick="send();" value="수정하기" ></input>
			</form>
		</div>
	</div>
	


</body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js">
	
	function send(){ 
		//수정버튼    
		var f1=document.getElementById("modify");
		
		//제목 입력 안될경우 차단
		if($("#title").val() == null){
			$f1.addEventListener("submit", (event) => {
				  // 동작(이벤트)을 실행하지 못하게 막는 메서드입니다.
				  event.preventDefault();
				  alert('제목을 입력하세요');
			});
		}
		else{
			f1.submit();
		}
	}


</script>



</html>