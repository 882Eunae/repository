<%@page import="ch.qos.logback.core.recovery.ResilientSyslogOutputStream"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.Context"%>

<%@page import="javax.naming.InitialContext"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="org.apache.tomcat.dbcp.dbcp2.DriverManagerConnectionFactory"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>


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

String sql="SELECT * FROM member"; //쿼리문
String addSql="insert into member(name,id,password,join_date,email,address) values(?,?,?,sysdate(),?,?)"; 


ArrayList<String> arr = new ArrayList<String>(); //결과 담을 변수
int count = 1;

//form 태그 안에서 파라미터 받아오기  
String name=request.getParameter("name"); 
String id=request.getParameter("id"); 
String pw=request.getParameter("password");
String email=request.getParameter("email"); 
String address=request.getParameter("address");



try {
    // JDBC Driver 로드 (신버전은 생략 가능)
    Class.forName("org.mariadb.jdbc.Driver");
    Connection conn = DriverManager.getConnection(url, user, password);
    System.out.println("MariaDB 연결 성공!dfsfsdfsdfds");
    	
	ptmt = conn.prepareStatement(addSql);
	ptmt.setString(1, name);
	ptmt.setString(2,id);
	ptmt.setString(3,pw);
	ptmt.setString(4, email);
	ptmt.setString(5,address);
	
	ptmt.executeUpdate(); //실행 
	System.out.println("실행성공");
	//ResultSet rs = ptmt.executeQuery();

	//while(rs.next()){			
	//	arr.add(""+count+" : "+rs.getString(1)+", "+rs.getString(2));
	//	count++;
	//}
    

    conn.close();
} catch (Exception e) {
	System.out.println("db연결실패...");
    e.printStackTrace();
}finally{
	

} 




		
%>

<h2>회원 목록</h2>
 <ul id="list"></ul>
 
 <table border="1">
  <tr><th>ID</th><th>Name</th><th>Email</th></tr>
  <c:forEach var="r" items="${rows.rows}">
    <tr>
      <td>${r.id}</td>
      <td>${r.name}</td>
      <td>${r.email}</td>
    </tr>
  </c:forEach>
</table>

<div class="login-wrap">

  <div class="login-html">
    <input id="tab-1" type="radio" name="tab" class="sign-in" checked><label for="tab-1" class="tab">Sign In</label>
    <input id="tab-2" type="radio" name="tab" class="sign-up"><label for="tab-2" class="tab">Sign Up</label>
    <div class="login-form">
      <!--   <div class="sign-in-htm">
        <div class="group">
          <label for="user" class="label">Username</label>
          <input id="user" type="text" class="input">
        </div>
        <div class="group">
          <label for="pass" class="label">Password</label>
          <input id="pass" type="password" class="input" data-type="password">
        </div>
        <div class="group">
          <input id="check" type="checkbox" class="check" checked>
          <label for="check"><span class="icon"></span> Keep me Signed in</label>
        </div>
        <div class="group">
          <input type="submit" class="button" value="Sign In">
        </div>
        <div class="hr"></div>
        <div class="foot-lnk">
          <a href="#forgot">Forgot Password?</a>
        </div>
      </div> -->
    <!--    <div class="sign-up-htm">
        <div class="group">
          <label for="name" class="label">name</label>
          <input id="name" name="name" type="text" class="input">
        </div>
        <div class="group">
          <label for="id" class="label">id</label>
          <input id="id" name="id" type="text" class="input">
        </div>
        <div class="group">
          <label for="password" class="label">Password</label>
          <input id="password" name="password" type="password" class="input" data-type="password">
        </div>
        
        <div class="group">
          <label for="email" class="label">Email Address</label>
          <input id="email" name="email" type="text" class="input">
        </div>
          <div class="form-group">
        <label for="address">주소</label>
        <input type="text" id="address" name="address" class="form-control" name="address"  id="address" placeholder="주소" required="">
    </div> 
      <div class="form-group">
        <label for="detailAddress">상세주소</label>
        <input type="text" class="form-control" name="detailAddress"  id="detailAddress" placeholder="주소" required="">
    </div> 
    <div class="form-group">
  	    <label for="postcode">우편번호</label>
        <input type="text" name="postcode" id="postcode" placeholder="우편번호">
    </div>
    <button type="button" onclick="execDaumPostcode()" class="btn btn-success">주소찾기</button> 
        <div class="group">
          <input type="submit" class="button" value="Sign Up">
        </div>
        <div class="hr"></div>  
      </div>
    </div>
  </div>-->
  
	<form method="post" action="login.jsp">
		아이디 : <input type="text" id="id" name="id"/><br>
		이름  : <input type="text" name="name"/><br>
		이메일 : <input type="text" name="email"/><br>
		비밀번호 : <input type="password" id="password" name="password"/><br>
		주소 <input type="text" id="address" name="address"/><br>
		상세주소 <input type="text" id="detailAddress"  name="detailAddress"><br>
		우편번호 <input type="text" name="postcode" id="postcode" placeholder="우편번호"><br>
		<button type="button" onclick="execDaumPostcode()" class="btn btn-success">주소찾기</button> 
		<input type="submit" class="button" value="Sign Up">
	</form>  
  
</div>


 
 
</body>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            document.getElementById('postcode').value = data.zonecode; 
            document.getElementById('address').value = data.roadAddress; 
        }
    }).open();
}

// id 중복체크 
let checkoverlapId=document.getElementById("id").value; //내가 입력한 아이디값
for(let i=0; i<result.length; i++){
			
		
	
}



</script>
</html>
