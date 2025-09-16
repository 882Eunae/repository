<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
@import url('https://fonts.googleapis.com/css?family=Poppins:400,500,600,700,800,900');

body{
  margin:0;
  color:#6a6f8c;
 
  font:600 16px/18px 'Open Sans',sans-serif;
}
*,:after,:before{box-sizing:border-box}
.clearfix:after,.clearfix:before{content:'';display:table}
.clearfix:after{clear:both;display:block}
a{color:inherit;text-decoration:none}

.login-wrap{
  width:100%;
  margin:auto;
  max-width:525px;
  min-height:670px;
  position:relative;
 

}
.login-html{
  width:100%;
  height:100%;
  position:absolute;
  padding:90px 70px 50px 70px;
  background:rgb(241 255 240);
}
.login-html .sign-in-htm,
.login-html .sign-up-htm{
  top:0;
  left:0;
  right:0;
  bottom:0;
  position:absolute;
  transform:rotateY(180deg);
  backface-visibility:hidden;
  transition:all .4s linear;
}
.login-html .sign-in,
.login-html .sign-up,
.login-form .group .check{
  display:none;
}
.login-html .tab,
.login-form .group .label,
.login-form .group .button{
  text-transform:uppercase;
}
.login-html .tab{
  font-size:22px;
  margin-right:15px;
  padding-bottom:5px;
  margin:0 15px 10px 0;
  display:inline-block;
  border-bottom:2px solid transparent;
}
.login-html .sign-in:checked + .tab,
.login-html .sign-up:checked + .tab{
  color:#fff;
  
}
.login-form{
  min-height:345px;
  position:relative;
  perspective:1000px;
  transform-style:preserve-3d;
}
.login-form .group{
  margin-bottom:15px;
}
.login-form .group .label,
.login-form .group .input,
.login-form .group .button{
  width:100%;
  color:rgb(48 98 42);
  display:block;
}
.login-form .group .input,
.login-form .group .button{
  border:none;
  padding:15px 20px;
  border-radius:25px;
  background:rgba(255,255,255,.1);
}
.login-form .group input[data-type="password"]{
  text-security:circle;
  -webkit-text-security:circle;
}
.login-form .group .label{
  color:#aaa;
  font-size:12px;
}
.login-form .group .button{
  background:#b8fabe;
}
.login-form .group label .icon{
  width:15px;
  height:15px;
  border-radius:2px;
  position:relative;
  display:inline-block;
  background:rgba(255,255,255,.1);
}
.login-form .group label .icon:before,
.login-form .group label .icon:after{
  content:'';
  width:10px;
  height:2px;
  background:#fff;
  position:absolute;
  transition:all .2s ease-in-out 0s;
}
.login-form .group label .icon:before{
  left:3px;
  width:5px;
  bottom:6px;
  transform:scale(0) rotate(0);
}
.login-form .group label .icon:after{
  top:6px;
  right:0;
  transform:scale(0) rotate(0);
}
.login-form .group .check:checked + label{
  color:#fff;
}
.login-form .group .check:checked + label .icon{
  background:#1161ee;
}
.login-form .group .check:checked + label .icon:before{
  transform:scale(1) rotate(45deg);
}
.login-form .group .check:checked + label .icon:after{
  transform:scale(1) rotate(-45deg);
}
.login-html .sign-in:checked + .tab + .sign-up + .tab + .login-form .sign-in-htm{
  transform:rotate(0);
}
.login-html .sign-up:checked + .tab + .login-form .sign-up-htm{
  transform:rotate(0);
}

.hr{
  height:2px;
  margin:60px 0 50px 0;
  background:rgba(255,255,255,.2);
}
.foot-lnk{
  text-align:center;
}
</style>
</head>
<body>
<%
	//세션에서 로그인 성공/실패 여부확인
	String loginCheck=(String)session.getAttribute("loginCheck"); 
	
	
%>

<div class="login-wrap">
  <div class="login-html" style="margin: 30px 0 0 0;">
    <input id="tab-1" type="radio" name="tab" class="sign-in" checked><label for="tab-1" class="tab" style="color:green;">Sign In</label>
    <input id="tab-2" type="radio" name="tab" class="sign-up"><label for="tab-2" class="tab"></label>
   
    <div class="login-form">
     <form method="post" action="loginprocess.jsp" class="form">
      <div class="sign-in-htm">
        <div class="group">
          <label for="id" class="label" style="color: green" >id</label>
          <input id="idInput" name="id" type="text" class="input" style="background-color:rgb(13 71 26 / 10%)" >
        </div>
        <div class="group">
          <label for="password" class="label" style="color: green" >Password</label>
          <input id="password" name="password"  type="password" class="input" data-type="password"  style="background-color:rgb(13 71 26 / 10%)">
        </div>
        <div class="group">
          <input type="submit" class="button" onClick="handleSubmit(event)" value="Sign In" style="color: green" >
        </div>
         	<a  href='index.jsp' align="center">회원가입하러가기</a>
     	 <c:if test="${loginCheck == 'fail'}"> <!-- if 조건 선언 -->
     		<p  align="center">  로그인정보가 일치하지 않습니다</p>
		 </c:if>
      </div>
      </form>
    </div>
  </div>
</div>

<script>
	function handleSubmit(event){
		if($('#idInput').val().length ==0){
			alert('로그인 정보를 입력해주세요');
			event.preventDefault();
			return;
		}
		
		if($('#password').val().length == 0){
			alert('비밀번호를 입력해주세요'); 
			event.preventDefault(); 
			return;
		}
	}
</script>

	
</body>
</html>