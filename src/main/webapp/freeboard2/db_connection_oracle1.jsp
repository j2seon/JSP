<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> Orcle DB Connection</title>
</head>
<body>
<%


	//변수초기화
	 Connection conn = null;		//DB를 연결하는 객체
	 String driver ="oracle.jdbc.driver.OracleDriver";
	 String url = "jdbc:oracle:thin:@localhost:1521:XE"; //Oracle Driver 접속
	 Boolean connect = false; //접속이 잘되는지 확인 하는 변수
	
		 Class.forName(driver); //오라클 드라이버 로드.
		 conn = DriverManager.getConnection(url,"HR2","1234");
		 
	
%>

	
	

</body>
</html>