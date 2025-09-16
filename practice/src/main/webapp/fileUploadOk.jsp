<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

	
	request.setCharacterEncoding("UTF-8");
	
	String path = application.getRealPath("/files");
 
	int size = 1024*1024*100;	//100MB
	
	String name="";			//이름
	String age="";			//나이
	String filename="";		//첨부파일명
	String orgfilename="";	//첨부파일명
	 
	
	try {
		MultipartRequest multi = new MultipartRequest(
									request,	//원래 request
									path,		//파일 업로드 위치
									size,		//최대 파일 크기
									"UTF-8",	//파일 데이터 인코딩
									new DefaultFileRenamePolicy()
				);
		
		name = multi.getParameter("name");
		age = multi.getParameter("age");
		
		filename = multi.getFilesystemName("attach");		//파일명(저장된 파일명)
		orgfilename = multi.getOriginalFileName("attach");	//파일명(원본 파일명)
		
		out.println("파일업로드 위치 : "+path);
		out.println("저장된파일 "+ filename); 
		out.println("원본 파일" + orgfilename);	
		
	} catch(Exception e) {
		e.printStackTrace();
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ex16_file_ok</title>
<link rel="stylesheet" href="http://pinnpublic.dothome.co.kr/cdn/example-min.css">
</head>
<body>

	<h1>결과</h1>

	
	<div>
		파일명: <%= filename %>
	</div>
	<div>
		파일명: <%= orgfilename %>
	</div>
	
	<h2>파일 다운로드</h2>
	
	<%-- <div>
		<a href="/jsp/files/<%= filename %>"><%= orgfilename %></a>
	</div> --%> 
	
	<%-- <div>
		<a href="/jsp/files/<%= filename %>" download><%= orgfilename %></a>
	</div>  --%>

	<div>
		<a href="download.jsp?filename=<%= filename %>&orgfilename=<%= orgfilename %>"><%= orgfilename %></a>
	</div>
	
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="http://pinnpublic.dothome.co.kr/cdn/example-min.js"></script>
	
</body>
</html>