<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
   <%@page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> MySQL DB Connection</title>
</head>
<body>
<%


	//변수초기화
	 Connection conn = null;		//DB를 연결하는 객체
	 String driver ="com.mysql.jdbc.Driver";
	 String url = "jdbc:mysql://localhost:3306/mydb"; //Oracle Driver 접속
	 Boolean connect = false; //접속이 잘되는지 확인 하는 변수
	 
	 try{
		 Class.forName(driver); //오라클 드라이버 로드.
		 conn = DriverManager.getConnection(url,"root","1234");
		 
		 connect = true;
		 
	 }catch(Exception e){
		 connect=false;
		 e.printStackTrace();
	 }
%>

<% 

	if(connect == true){
		out.println("MySQL DB에 잘 연결되었습니다.");
	}else{
		out.println("MySQL DB연결에 실패하였습니다.");
	}


%>
	
	

</body>
</html>