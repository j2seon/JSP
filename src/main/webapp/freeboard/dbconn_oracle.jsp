<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
	Connection conn = null;		//DB를 연결하는 객체
	String driver ="oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE"; //Oracle Driver 접속
	
	Class.forName(driver); //오라클 드라이버 로드.
	conn = DriverManager.getConnection(url,"HR2","1234");



%>
</body>
</html>