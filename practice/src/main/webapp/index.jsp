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
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
<title>Insert title here</title>
<style>
	.input-form {
  		display: flex;
 		 flex-direction: column; 
	}

	.input-form div {
	  display: flex;
	  align-items: center; 
	  margin-bottom: 10px;
	}

	.input-form label {
	  margin-right: 10px; 
	  width: 80px; 
	}
	
	.login-wrap {
	  display: flex;
	  justify-content: center; /* 수평 중앙 정렬 */
	  align-items: center;    /* 수직 중앙 정렬 */
	  min-height: 100vh; /* 화면 높이 전체를 사용하게 함 */
	}

	 

</style>
</head>
<body >
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
    
    String id=null;
    
	 
    //실행시킬 sql문 
    String addSql="insert into member(name,id,password,join_date,email,address) values(?,?,?,sysdate(),?,?)"; 
	try {
	    System.out.println("MariaDB 연결 성공!");	
	} catch (Exception e) {
		System.out.println("db연결실패...");
	    e.printStackTrace();
	}finally{
	    conn.close();	
	} 	
	
	String overlap=(String)session.getAttribute("overlap");  
	
	//페이지에 처음접속하면 overlap 기본상태값을 'noCheck' 로 두기
	session.setAttribute("overlap", "noCheck"); 
	
	String pw=(String)session.getAttribute("pw"); 
	String writeId=(String)session.getAttribute("writeId");
	String name=(String)session.getAttribute("name"); 
	String email=(String)session.getAttribute("email"); 
	String address=(String)session.getAttribute("address"); 
	
	
%>

 <ul id="list"></ul>
	<div class="login-wrap">
	  <div class="login-html">
	<h2>회원 가입</h2>
		<input  type="hidden" value=<%=overlap %> id="overlap" name="overlap" /> 
	    <div class="login-form">
		<form  class="input-form" id="myForm" method="post" action="insert.jsp" >
			<div>
				<label>	아이디 :</label>
				<c:choose>
					<c:when test="${writeId != null }">
						<input type="text" id="id" name="id" value="<%=writeId %>" onkeyup="validateId();" />
						<br><span style="color: red;" id="resultId"></span>
					</c:when>
					<c:when test="${writeId == null }">
						<input type="text" id="id" name="id"  required="required" />
					</c:when>
					<c:otherwise>
						<p> </p>
					</c:otherwise>
				</c:choose> 	
					<button type="button" onClick="overlapCheck()" class="btn btn-info">
						중복확인
				     </button>
				<c:choose>
				       <c:when test="${overlap == 'overlap'}">
				      		<p style="color : red;" >중복된값입니다</p>
				      </c:when> 
				      <c:when test="${overlap == 'no'}">
				      		<p style="color: green;"> 사용가능한 아이디입니다 </p>
				      </c:when>
				      <c:otherwise>
				      		<p><%=overlap %> </p>	
				      </c:otherwise> 
				</c:choose> 
			</div>
			<div>
				<label>이름  :</label>
				<c:choose>
					  <c:when test="${name != null }">	
						<input type="text" id="name" name="name" value="<%=name %>" />
					  </c:when>
					   <c:when test="${name == null}">
						<input type="text" id="name" name="name" value=" "/>
					   </c:when>
				</c:choose> 				
			</div>
			<div>
				<label>이메일 :</label> 
				<c:choose>
					  <c:when test="${email != null }">	
						<input type="text" id="email" name="email" value="<%=email %>" onkeyup="validateEmail();"/>
					  </c:when>
					  <c:when test="${email == null }">	
						<input type="text" id="email" name="email"  onkeyup="validateEmail();" />
					  </c:when>
				</c:choose>
			  	<span style="color: red;" id="result"></span>
			</div>
			<div>
				<label>비밀번호 : </label>
				<c:choose>
			       <c:when test="${pw != null }">	
						<input type="password" id="password" name="password" value="<%=pw %>" onkeyup="passwordCheckFunction();"/>
			       </c:when>
				   <c:when test="${pw == null }">	
						<input type="password" id="password" name="password" value=" " onkeyup="passwordCheckFunction();"/>
			       </c:when>
			    </c:choose>
			    <span style="color: red;" id="passwordCheckLength"></span>
			</div>
			<div>
				<label>비번확인 :</label>
			  	<input type="password" id="pwcheck" name="pwcheck" onkeyup="passwordCheckFunction();"/>
			    <span style="color: red;" id="passwordCheckMessage"></span>
			</div>
			<div>	             
				<label>주소</label>
				<c:choose>
					<c:when test="${address eq null}">
						<input type="text" id="address" name="address" value=" " ></input>
					</c:when>
					<c:otherwise>
						<input type="text" id="address" name="address" value=<%=address%> />
					</c:otherwise>
				</c:choose>
				<button type="button" onclick="execDaumPostcode()" class="btn btn-success">주소찾기</button> 
			</div>
			<div>
				<label>우편번호</label>
				<input type="text" name="postcode" id="postcode" />
			</div>
			<div>	
				<label>상세주소</label>
				<input type="text" id="detailAddress" name="detailAddress">
			</div>
			<input type="submit" class="btn btn-success" onClick="handleSubmit(event)" value="회원가입" style="width:282px; align:center;"/>
		</form>  
	    </div>
	  </div>
	</div>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
		let emailVal; //이메일유효성 
		let pwVal; //비밀번호 유효성 비번작성조건,일치 불일치 모두 통과해야함
		let idVal; //아이디 유효성
	 
		
		function execDaumPostcode() {
		    new daum.Postcode({
		        oncomplete: function(data) {
		            document.getElementById('postcode').value = data.zonecode; 
		            document.getElementById('address').value = data.roadAddress; 
		        }
		    }).open();
		}
		
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
				emailVal='yes' 
				resultDiv.innerHTML = '유효한 이메일 주소입니다.';
				resultDiv.style.color='green'; 
			} else {
				emailVal='no';
				resultDiv.innerHTML = '유효하지 않은 이메일 주소입니다.';
				resultDiv.style.color='red'; 
			}
		}	
	// id 중복체크 
	let checkoverlapId=document.getElementById("id").value; 
	
	//비밀번호 유효성체크 
	function passwordCheckFunction(){
			// 변수 userPassword1, 2에 폼에 입력한 id를 통해 값을 실시간으로 받아와 저장
			let  userPassword1 = document.getElementById('password').value; 
			let  userPassword2 = document.getElementById('pwcheck').value;
	
			//비밀번호 유효성검사 
			let reg = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[~?!@#$%^&*_-]).{8,}$/

	
	        // 패스워드 체크하기 위한 패스워드랑 패스워드확인이랑 같은지
	        if(!reg.test(userPassword1)){
	        	document.getElementById('passwordCheckLength').innerHTML='대,소문자 특수문자 포함하여 8자이상 쓰시오';
	        	document.getElementById('passwordCheckLength').color='red';
	        	pwVal='no'; 
	        }else if(reg.test(userPassword1)){
	        	document.getElementById('passwordCheckLength').innerHTML='비밀번호 가능';
	        	document.getElementById('passwordCheckLength').style.color='green';
	        	//pwVal='yes';
	        }
	        
			if(userPassword1 != userPassword2 && userPassword2.length>0){
				document.getElementById('passwordCheckMessage').innerHTML='비밀번호가 서로 일치하지 않습니다';
				document.getElementById('passwordCheckMessage').style.color='red';
				pwVal='no';
				
			}else if(userPassword1 == userPassword2 &&userPassword2.length>0) {
				document.getElementById('passwordCheckMessage').innerHTML='비밀번호가 일치합니다';
				document.getElementById('passwordCheckMessage').style.color='green';	
			}
			
			// 비번 일치 x,   
			if(!reg.test(userPassword1) && userPassword1 == userPassword2){
				document.getElementById('passwordCheckLength').color='red';
				pwVal='no'; 
			}
			
			//비번 조건
			if(reg.test(userPassword1) && userPassword1 == userPassword2  ){
				pwVal = 'yes';    
			}
			
		}
		
	function handleSubmit(event){
		//form 제출
		const form = document.getElementById('myForm');			 
		
		let id = document.getElementById('id').value;
		

		if(id.length<1){
			  event.preventDefault();
			  alert('아이디를 입력하세요');
			  return;
		}else if(idVal=='no'){
			event.preventDefault();
			alert('아이디를 올바르게 입력해주시오');
			return;
		}
		
	
		
		if(emailVal=='no' || document.getElementById('email').value.length <1 ){
			event.preventDefault(); 
			alert('이메일 형식을 다시 확인해주세요');
			return;
		}
		if(document.getElementById('overlap').value != 'no'){ //세션정보
			event.preventDefault(); 
			alert('아이디 값 중복확인 해주세요');
			return;
		}
		if(document.getElementById('name').value.length<1){
			event.preventDefault();
			alert('이름을 입력해주세요');
			return;
		}
		if(pwVal != 'yes'){
			event.preventDefault(); 
			alert('비밀번호를 다시 확인 해주세요'); 
			return;
		}
		
		
	}

	function overlapCheck(){
		
		//파라미터 아이디,이름,비밀번호 자바스크립트안에서 넘기기  
	    let urlParams = new URLSearchParams("?checkId=test&name=yes&password=no&email=no&address=no");

	    urlParams.set("checkId", document.getElementById('id').value);
	    urlParams.set("name", document.getElementById('name').value);
	    urlParams.set("password",document.getElementById('password').value);
	    urlParams.set("email",document.getElementById('email').value);
	    urlParams.set("address",document.getElementById('address').value);

	    // ?gil=yes&log=wow&gillog=good
	    console.log(urlParams);
	
	    window.location.href = "overlap.jsp?" + urlParams; //안넘어간 이유 -> form 형태로 넘긴게 아니라 파라미터 한개 값만 전달함 parameter여러값 전 
	    
	}  
	
	function validateId(){
		let idInput = document.getElementById('id').value;
		let resultDiv = document.getElementById('resultId');
		
		//아이디가 유효한 경우 
		//아이디는 소문자,숫자 포함하여 5자이상  
		let reg = /^(?=.*?[a-z])(?=.*?[0-9]).{5,}$/; 

		//아이디가 유효하지 않은경우 
		if(!reg.test(idInput)){
			resultDiv.innerHTML='소문자,숫자 포함하여 6자이상 작성해주세요';
			idVal='no'; 
		}else if(reg.test(idInput)){
			idVal='yes';
			resultDiv.innerHTML=''; 
		}

	}
	
</script>
</body>
</html>
