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
<h3>음오아예</h3>
<h2>회원 목록</h2>
<c:forEach var="item" items="${test}">
    아이디: ${item.userId} <br>
    이름: ${item.userName} <br>
    비밀번호: ${item.password} <br>
    <hr>
</c:forEach>

 <ul id="list"></ul>


</body>
<script>
const ctx = '<%= request.getContextPath() %>'; // 예: /practice

fetch(`${ctx}/api/members`)
  .then(res => res.json())
  .then(data => {
    const ul = document.getElementById('list');
    ul.innerHTML = data.map(m =>
      `<li><b>${m.userId}</b> - ${m.userName} / ${m.password}</li>`
    ).join('');
  })
  .catch(err => {
    console.error(err);
    document.getElementById('list').innerHTML = '<li>로드 실패</li>';
  });
</script>
</html>
