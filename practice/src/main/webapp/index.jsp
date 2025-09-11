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



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%  
	//인코딩 방식설정 
	request.setCharacterEncoding("UTF-8"); 
    
    //데이터베이스 준비
	String url = "jdbc:mariadb://localhost:3306/test"; // DB 이름 test
	String user = "root";                             // 사용자
	String password = "1234";   // 비밀번호
    Class.forName("org.mariadb.jdbc.Driver");
    Connection conn = DriverManager.getConnection(url, user, password);
    
    //preparedStatement 객체생성 
	PreparedStatement ptmt;
	 
    //실행시킬 sql문 
    String addSql="insert into member(name,id,password,join_date,email,address) values(?,?,?,sysdate(),?,?)"; 
	try {
	    System.out.println("MariaDB 연결 성공!dfsfsdfsdfds");	
	} catch (Exception e) {
		System.out.println("db연결실패...");
	    e.printStackTrace();
	}finally{
	    conn.close();	
	} 	
%>

<h2>회원 가입</h2>
 <ul id="list"></ul>
	<div class="login-wrap">
	  <div class="login-html">
	    <input id="tab-1" type="radio" name="tab" class="sign-in" checked><label for="tab-1" class="tab">Sign In</label>
	    <input id="tab-2" type="radio" name="tab" class="sign-up"><label for="tab-2" class="tab">Sign Up</label>
	    <div class="login-form">
		<form id="myForm" method="post" action="insert.jsp" >
			아이디 : <input type="text" id="id" name="id" required="required"/><br>
			이름  : <input type="text" name="name" required="required"/><br>
			이메일 : <input type="text" id="email" name="email" required="required" onkeyup="validateEmail();"/>
			       <span style="color: red;" id="result"></span><br>
			비밀번호 : <input type="password" id="password" name="password" onkeyup="passwordCheckFunction();"/>
			         <span style="color: red;" id="passwordCheckLength"></span><br>
			비밀번호 확인 :  <input type="password" id="pwcheck" name="pwcheck" onkeyup="passwordCheckFunction();"/>
			             <span style="color: red;" id="passwordCheckMessage"></span><br>	             
			주소 <input type="text" id="address" name="address"/><br>
			우편번호 <input type="text" name="postcode" id="postcode" placeholder="우편번호"><br>
			상세주소 <input type="text" id="detailAddress"  name="detailAddress"><br>
			<button type="button" onclick="execDaumPostcode()" class="btn btn-success">주소찾기</button> 
			<input type="submit" class="button" value="Sign Up">회원가입</input>
		</form>  
	    </div>
	  </div>
	</div>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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
let checkoverlapId=document.getElementById("id").value; 

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
	const form = document.getElementById('myForm');
	console.log(form);
	form.addEventListener('submit', function(event) {
			if(document.getElementById('address').value==null)	{
			   isValid=false; 
			}	
			if (!isValid) {
			   event.preventDefault(); 
			   alert('모든값을 정확하게 입력하시오'); 
			}
	});
	//이메일 유효성검사 
	const pattern = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-za-z0-9\-]+/;
	function emailValidChk(email) {
	    if(pattern.test(email) === false) { return false; }
	    else { return true; }
	}

	function validateEmail() {	
		let emailInput = document.getElementById('email');
		let resultDiv = document.getElementById('result');
	
		console.log(emailInput);
		let email = emailInput.value;
	
		if (emailValidChk(email)) {
			resultDiv.innerHTML = '유효한 이메일 주소입니다.';
			resultDiv.style.color='green'; 
		} else {
			resultDiv.innerHTML = '유효하지 않은 이메일 주소입니다.';
		}
	}	
</script>
</body>
</html>
