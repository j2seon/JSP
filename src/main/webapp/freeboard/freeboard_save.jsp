<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*, java.text.*" %>
<!-- 한글 처리 -->
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Form의 값을 받아서 DB에 값을 Create</title>
</head>
<body>
	<%@ include file = "dbconn_oracle.jsp"%>
	<%
	// form에서 받은 값을 변수로 저장
	String na = request.getParameter("name");
	String em = request.getParameter("email");
	String sub = request.getParameter("subject");
	String cont = request.getParameter("content");
	String pw = request.getParameter("password");
	
	// DB id컬럼에 저장할 값
	int id = 1;
	
	int pos = 0;
	if (cont.length() == 1) {
		cont = cont + " ";
	}
	
	// content (Text Area)에 엔터(줄바꿈)를 처리 : Oracle DB 저장 시, 엔터의 값을 바꿔 저장
	while ((pos = cont.indexOf("\'", pos)) != -1) {
		String left = cont.substring (0,pos);
		String right = cont.substring (pos,cont.length());
		cont = left + "\'" + right;
		pos += 2;
	}
	
	// 오늘 날짜 처리 함수
	java.util.Date yymmdd = new java.util.Date();
	SimpleDateFormat myformat = new SimpleDateFormat("yy-MM-d h:mm a");
	String ymd = myformat.format(yymmdd);
	
	String sql = null;
	Statement st = null;
	ResultSet rs = null;
	
	int cnt = 0;				// insert 잘되었는지 확인하는 변수
	
	try {
		// 값을 저장하기 전에 최신 글번호(max(id))를 가져와 + 1을 적용한다.
		sql = "SELECT max(id) FROM freeboard";
		
		st = conn.createStatement();				// Connection 객체는 auto commit(DML에)이 적용된다.
		rs = st.executeQuery(sql);
		if (!(rs.next())) {							// rs의 값이 비어있을 때, 즉 글이 하나도 없을 때
			id = 1;
		} else {
			id = rs.getInt(1) + 1;					// 괄호안 1은 첫번째 값을 의미한다.
		}
		rs.close();
		
		sql = "INSERT INTO freeboard (id, name, password, email, subject,";	
		sql = sql + "content, inputdate, masterid, readcount, replaynum, step)";
		sql = sql + " VALUES (" + id + ", '" + na + "', '" + pw + "', '" + em + "', ";
		sql = sql + "'" + sub + "', '" + cont + "', '" + ymd + "', " + id + ", ";
		sql = sql + "0, 0, 0)";
		
		cnt = st.executeUpdate(sql);				// cnt > 0 면 insert 성공, executeUpdate()는 반영된 레코드 수를 반환한다. delete, drop은 -1 반환
		
		if (cnt > 0) {
			out.println("데이터가 성공적으로 입력되었습니다.");
		} else {
			out.println("데이터가 입력에 실패하였습니다.");
		}
		
		
		
		// sql 확인
		// out.println(sql);
	} catch (Exception e) {
		out.println(e.getMessage());
	} finally {
		if (st != null) {
			st.close();
		}
		if (rs != null) {
			rs.close();
		}
		if (conn != null) {
			conn.close();
		}
	}
	
	%>
	
	<jsp:forward page = "freeboard_list.jsp" />
	
	<!-- 페이지를 이동
	jsp:forwrad
		서버단에서 페이지를 이동
		클라이언트의 URL이 이동하는 페이지 URL로 바뀌지 않는다.
		list.jsp 로 이동하더라도 save.jsp URL로 남아있음
	response.sendRedirect
		클라이언트에서 페이지를 재요청하여 이동
		클라이언트의 URL이 이동하는 페이지로 URL 정보가 바뀐다.
	
	
	 -->
	
</body>
</html>