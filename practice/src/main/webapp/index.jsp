<%@page import="ch.qos.logback.core.net.SyslogOutputStream"%>
<%@page import="java.beans.Statement"%>
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
	 System.out.println("setString");
	ptmt.setString(2,id);
	ptmt.setString(3,pw);
	ptmt.setString(4, email);
	ptmt.setString(5,address);
	
	ptmt.executeUpdate(); //실행 
	System.out.println("실행성공");
	ResultSet rs = ptmt.executeQuery();

	while(rs.next()){			
		arr.add(""+count+" : "+rs.getString(1)+", "+rs.getString(2));
		count++;
	}
    

    conn.close();
} catch (Exception e) {
	System.out.println("db연결실패...");
    e.printStackTrace();
}finally{
	
	System.out.println("id값"+id);

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
    
	<form method="post">
		아이디 : <input type="text" name="id"/><br>
		이름  : <input type="text" name="name"/><br>
		이메일 : <input type="text" name="email"/><br>
		비밀번호 : <input type="password" id="password" name="password" onkeyup="passwordCheckFunction();"/>
		         <span style="color: red;" id="passwordCheckLength"></span>                                                   <br>
		비밀번호 확인 :  <input type="password" id="pwcheck" name="pwcheck" onkeyup="passwordCheckFunction();"/>
		             <span style="color: red;" id="passwordCheckMessage"></span><br>
		             
		주소 <input type="text" id="address" name="address"/><br>
		상세주소 <input type="text" id="detailAddress"  name="detailAddress"><br>
		우편번호 <input type="text" name="postcode" id="postcode" placeholder="우편번호"><br>
		<button type="button" onclick="execDaumPostcode()" class="btn btn-success">주소찾기</button> 
		<input type="submit" class="button" value="Sign Up">
	</form>  
  
</div>


 
 


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

let frm=document.frm_zip; 
let isEqual=false; 

// id 중복체크 
let checkoverlapId=document.getElementById("id").value; //내가 입력한 아이디값



//비밀번호 유효성체크 
function passwordCheckFunction(){

		// 변수 userPassword1, 2에 폼에 입력한 id를 통해 값을 실시간으로 받아와 저장

		let  userPassword1 = document.getElementById('password').value; 

		let  userPassword2 = document.getElementById('pwcheck').value;

                // 패스워드 체크하기 위한 패스워드랑 패스워드확인이랑 같은지
                
        if(userPassword1.length<6){
        	document.getElementById('passwordCheckLength').innerHTML='비밀번호를 6자 이상 쓰시오';
        }else{
        	document.getElementById('passwordCheckLength').innerHTML='';
        }
                

		if(userPassword1 != userPassword2){

			document.getElementById('passwordCheckMessage').innerHTML='비밀번호가 서로 일치하지 않습니다';


		} else {
			// 정상적이면 어떠한 메시지도 출력되지 않도록 빈칸
			document.getElementById('passwordCheckMessage').innerHTML='';	
		}

	}



</script>
</body>
</html>
