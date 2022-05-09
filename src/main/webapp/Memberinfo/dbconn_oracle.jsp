<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>

<%@page import = "java.sql.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	Connection conn = null;		//DB를 연결하는 객체 connection
	String driver ="oracle.jdbc.driver.OracleDriver"; 
	//Web App Libraries >>> ojdbc6.jar >>>oracle.jdbc.driver.OracleDriver 

	String url = "jdbc:oracle:thin:@localhost:1521:XE"; //Oracle Driver 접속
	
	Class.forName(driver); //오라클 드라이버 로드.
	// forName메서드를 통해 OracleDriver 클래스를 인스턴스화 하는 것이 드라이버 로드이다.
	// 드라이버를 로드하면 해당 인스턴스가 메모리에 잡히게 된다.
	
	conn = DriverManager.getConnection(url,"hr","hr"); // 드라이버 로드가 완료됐다면 연결 객체를 얻는다.(url,접속아이디,비번)

%>
</body>
</html>


<!-- 지시어는 jsp 파일의 속성을 기술하는 요소로 jsp 컴테이너에 해당 페이지를 어떻게 처리해야하는 지 전달하는 내용을 가지고 있다.
1. page
	- 서블릿으로 변한하는데 필요한 속성을 기술하기 위해 사용한다.
	- language : 언어를 지정
	- contentType : 파일 형식
	- pageEncoding : 컨테이너가 처리할때 사용하는 캐릭터 인코딩 한글처리를 위해선 UTF-8로 설정한다. 


2.include
	- 다른파일을 포함하기 위한 지시어 


3.taglib

 -->