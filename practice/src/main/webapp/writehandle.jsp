<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% 
	    //인코딩 방식 설정  
		request.setCharacterEncoding("UTF-8"); 
	
		//데이터베이스 정보 
		String url = "jdbc:mariadb://localhost:3306/test"; // DB 이름 test
		String user = "root";                             // 사용자
		String password = "1234";   // 비밀번호
		PreparedStatement ptmt; //객체생성 
		
		String userId=(String) session.getAttribute("userId"); 
		
		String addSql="INSERT INTO board (title, member_id, content) values(?, ?, ?)"; 
		
		String fileSql="INSERT INTO file(file_path) VALUES(?)"; 
		
		String fileDetailSql="INSERT INTO file_detail(board_no,file_no,file_name) VALUES(?,?,?)";
		
		
		//form  받아오기 
		String title = request.getParameter("title"); 
		String content = request.getParameter("content");  
		
		String path = application.getRealPath("/files"); //path 
		 
		int size = 1024*1024*100;	//100MB
		
		String filename="";		//첨부파일명
		String orgfilename="";	//첨부파일명 
		
		MultipartRequest multi = new MultipartRequest(
				request,	//원래 request
				path,		//파일 업로드 위치
				size,		//최대 파일 크기
				"UTF-8",	//파일 데이터 인코딩
				new DefaultFileRenamePolicy()
		);

		filename = multi.getFilesystemName("attach");		//파일명(저장된 파일명)
		orgfilename = multi.getOriginalFileName("attach");	//파일명(원본 파일명)
		title=multi.getParameter("title");
		content =multi.getParameter("content"); //내용 
		String filePath=application.getRealPath("/files") + filename ; //파일 업로드 위치
		
		
		
	 try{
		// 데이터접근 생성
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection(url, user, password);
		//어떤 sql을 쓸건지 
		ptmt = conn.prepareStatement(addSql,Statement.RETURN_GENERATED_KEYS);
		//파라미터 값 전달
		ptmt.setString(1,title);
		ptmt.setString(2,userId);
		ptmt.setString(3,content);
		//실행 
		ptmt.executeUpdate(); 
		int boardNo;
		
		
		try (ResultSet keys = ptmt.getGeneratedKeys()) {
		  if (keys.next()) {
		       boardNo = keys.getInt(1);
		    }
		 } 
		

		//파일업로드 file 테이블 
		ptmt=conn.prepareStatement(fileSql);
		ptmt.setString(1,filePath); 
		ptmt.executeUpdate();
		
		int fileNo; 
		try (PreparedStatement ps = conn.prepareStatement(fileSql, Statement.RETURN_GENERATED_KEYS)) {
		    ps.setString(1, filePath);
		    ps.executeUpdate();
		    try (ResultSet keys = ps.getGeneratedKeys()) {
		        if (keys.next()) {
		             fileNo = keys.getInt(1);
		        }
		    } 
		}
		
		//파일디테일 file_detail 테이블 
		ptmt=conn.prepareStatement(fileDetailSql); 
		ptmt.setInt(1,boardNo); 
		ptmt.setInt(2,fileNo); 
		ptmt.setString(3,content); 
		
		ptmt.executeUpdate();
		
		//글 등록후 다시 welcome 페이지 이동 
		response.sendRedirect("welcome.jsp"); 

	 }catch(Exception e){
		     e.printStackTrace();
	    }	
	
	%>
</body>
</html>