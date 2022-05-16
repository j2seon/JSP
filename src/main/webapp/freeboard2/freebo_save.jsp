<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*, java.text.*" %>
    <% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>form 의 값을 받아서 db에 값을 저장하는 파일</title>
</head>
<body>
	<%@ include file = "db_connection_oracle1.jsp" %>
	
	<%
	// form의 값을 변수 선언 
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	String password = request.getParameter("password");
	
	int id = 1;
	int pos = 0;
	if(content.length() == 1){
		content = content +" ";
	}
	// content (Text Area)에 엔터(줄바꿈)를 처리 : Oracle DB 저장 시, 엔터의 값을 바꿔 저장
	while ((pos = content.indexOf("\'", pos)) != -1) {
		String left = content.substring (0,pos);
		String right = content.substring (pos,content.length());
		content = left + "\'" + right;
		pos += 2;
	}
	
	//날짜 처리
	java.util.Date today = new java.util.Date();
	SimpleDateFormat format = new SimpleDateFormat("yy-MM-dd h:mm a");
	String day = format.format(today);
	
	//sql 값!
	String sql = null;
	Statement st = null;
	ResultSet rs = null;
	
	int cnt = 0;
	
	try{
		sql = "select max(id) from freebo";
		st = conn.createStatement();
		rs = st.executeQuery(sql);
		
		if(!(rs.next())){
			id = 1;
		}else{
			id = rs.getInt(1)+1;
		}
		rs.close();
		
		sql = "INSERT INTO freebo (id, name, password, email, subject,";	
		sql = sql + "content, inputdate, masterid, readcount, replaynum, step)";
		sql = sql + " VALUES (" + id + ", '" + name + "', '" + password + "', '" + email + "', ";
		sql = sql + "'" + subject + "', '" + content + "', '" + day + "', " + id + ", ";
		sql = sql + "0, 0, 0)";
		
		cnt = st.executeUpdate(sql);
		
		if (cnt > 0) {
			out.println("데이터가 성공적으로 입력되었습니다.");
		} else {
			out.println("데이터가 입력에 실패하였습니다.");
		}
		
		out.println(sql);
	}catch(Exception e){
		
	}
	
	%>
	
	<jsp:forward page = "freebo_list.jsp"/>




</body>
</html>