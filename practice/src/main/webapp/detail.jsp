<%@page import="org.apache.tomcat.util.log.SystemLogHandler"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	    <!-- 제이쿼리적용 -->
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<!-- 부트스트랩 적용 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<style>
		.box{
		 width: 300px; 
		 display: block; 
		 margin: auto;			
	     margin-top: 200px;
		}	
	
	
	</style>        
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
 	
 	
 	
 	String title = null; 
    String content = null; 
    String userId = " "; 
    
 	if(rs.next()){
 		 title=rs.getString("title");
 		 content=rs.getString("content");
		 userId=rs.getString("member_id"); 		
 	}
 	
 	String loginUser=(String)session.getAttribute("userId"); //로그인한 유저 정보
 	
				String equal="notequal"; // 
			 	if(loginUser.equals(userId)){
			 		equal= "equal";
			 	}	
				
	String fileSql= "SELECT f.id, r.file_id, r.file_content,f.file_title  FROM file f JOIN r_file r ON f.id = r.file_id WHERE r.board_no = ? "; 
	ptmt=conn.prepareStatement(fileSql);
 	ptmt.setInt(1,boardNo); 
 	
 	rs = ptmt.executeQuery(); //쿼리 
 	
 	String fileTitle=null; 
 	if(rs.next()){
 		 fileTitle=rs.getString("file_title"); 
 	 }

 	// 절대경로,상대경로 차이 
  	// out..println(request.getContextPath()+"/files/"+fileTitle);
	
%>

	<input type="hidden" id="loginInfo" value="<%=loginUser%>"/> 
	<div class="box">
		<div style="width: 400px; margin: 0 auto;">
			<form action="modify.jsp" method="post" id="form1" >
				<input type="hidden" value="<%=boardNo%>" name="boardNo" id="boardNo" >
				<input type="hidden" id="writeId" value="<%=userId%>" name="userId">
			<div class="mb-3 row">
			  <div class="col-sm-10">
			    <label>제목 : </label>
			      <% if(loginUser.equals(userId)){ %>
					 <input type="text" style="width: 252px;  class="form-control-plaintext" id="title" value="<%=title%>" name="title" >
			  		<% } else{   %>
			  			    <span style="color: black;"><%=title %></span><br>
			  			 <% } %>     	
				<label>작성자 :
					<span> <%=userId %> </span>
				</label>
			   </div>
			</div>
			<div class="mb-3 row">
			  <div class="col-sm-10">
			    <%
			 	if(equal.equals("equal")){
			 	%>  
			    	<textarea style="width: 300px; height: 200px;" id="content" name="content"  ><%=content %></textarea>
			    	<image width="200px" height="150px" src="./files/<%=fileTitle%>"></image>
			    <% }  else{ %>
			    	 <textarea style="width: 300px; height: 200px;" id="content" name="content" disabled><%=content %></textarea>
			    	 <image width="200px" height="150px"  src="./files/<%=fileTitle%>"></image>	
			    	 <% } %>
			  </div>
			</div>
			 <a class="btn btn-primary" href="welcome.jsp" role="button">글목록 이동</a>
			 	<%
			 		if(equal.equals("equal")){ //c태그 이용할려 했으나 도저히 안되서 자바코드 사용	
			 	%> 
				<input class="btn btn-warning" type="submit" id="modify"  name="boardNo" onclick="send(event);" value="수정하기" ></input>
				<button type="button" class="btn btn-danger" id="delBtn" >삭제하기</button>
			 	<% } %>
			</form> 
			<div class="input-group mb-3">
				<input type="text" class="form-control" id='replyCotent' placeholder="댓글을 입력해주세요" aria-label="Recipient's username" aria-describedby="button-addon2">
				<button class="btn btn-outline-secondary" type="button" id="replyBtn">댓글입력</button>
			</div>
		</div>
	</div>

 
</body>
<script>
	let originTitle=$('#title').val();
	let originContent= $('#content').val(); 
	let boardNo = $('#boardNo').val(); 
	
	var f1=document.getElementById("modify");
	console.log(f1);
	
	
	//수정하기 이벤트
	function send(event){ 
		//수정버튼    
		var f1=document.getElementById("modify");

		//제목 입력 안될경우 차단
		if($("#title").val() == null){	
			f1.addEventListener("submit", (event) => {
				  event.preventDefault();
				  alert('제목을 입력하세요');
			});
		}else if($('#loginInfo').val() != $('#writeId').val() ){
			alert('수정권한이 없습니다');
			event.preventDefault();
			$('#title').val(originTitle); 
			$('#content').val(originContent);	
		}
		else{
			f1.submit();
		}
	}

	$('#delBtn').on('click',(event)=>{
		
		location.href = "delete.jsp?boardNo=" + boardNo;
		alert('삭제완료'); 
	})
	
  	$('#replyBtn').on('click',(event)=>{
  		
  		let urlParams = new URLSearchParams("?checkId=test&name=yes&password=no&email=no&address=no");

 	    urlParams.set("writerId", document.getElementById('id').value);
 	    urlParams.set("content", document.getElementById('replyCotent').value);
 	    urlParams.set("boardNo",document.getElementById('password').value);
 	    urlParams.set("email",document.getElementById('email').value);
 	    urlParams.set("address",document.getElementById('address').value);

 	    // ?gil=yes&log=wow&gillog=good
 	    console.log(urlParams);
 		
 	   
  		
  		window.location.href = "reply.jsp";  
  	})
  	
	

</script>
</html>