<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
   <%@page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title> Orcle DB Connection</title>
</head>
<body>
<%


	//�����ʱ�ȭ
	 Connection conn = null;		//DB�� �����ϴ� ��ü
	 String driver ="oracle.jdbc.driver.OracleDriver";
	 String url = "jdbc:oracle:thin:@localhost:1521:XE"; //Oracle Driver ����
	 Boolean connect = false; //������ �ߵǴ��� Ȯ�� �ϴ� ����
	 
	 try{
		 Class.forName(driver); //����Ŭ ����̹� �ε�.
		 conn = DriverManager.getConnection(url,"HR2","1234");
		 
		 connect = true;
		 
	 }catch(Exception e){
		 connect=false;
		 e.printStackTrace();
	 }
%>

<% 

	if(connect == true){
		out.println("����Ŭ DB�� �� ����Ǿ����ϴ�.");
	}else{
		out.println("����Ŭ DB���ῡ �����Ͽ����ϴ�.");
	}


%>
	
	

</body>
</html>