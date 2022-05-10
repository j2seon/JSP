<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form method= "post" action="delete01_process.jsp">
		<p> 아이디 : <input type = "text" name= "id">
		<p> 패스워드 : <input type = "password" name= "password">
		<p> 이름 : <input type = "text" name= "name">
		<p> 이메일 : <input type ="text" name= "email" >
		<p> <input type="submit" value ="전송">	
	</form>	
</body>
</html>


<!--  

	method = "post" 
		-- http 헤더 앞에 값을 넣어서 전송, 보안이 강하다. 전송용량에 제한이 없다.
		
	
	method = "get"
		-- http 헤더 뒤에 붙여서 값을 전송, 보안에 취약하다,전송량의 제한을 가지고 있다.
		 

-->