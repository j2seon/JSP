<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>form 에서 넘겨받은 값을 DB에 저장하는 파일</title>
</head>
<body>

<!-- 참조할 파일은 include를 이용해서 가져온다.
include를 통해 해당 파일을 가져와서 이 안의 값들이 메모리에 로드된다.
그러면 HttpServletRequest로 서블릿에 정보를 전달할 수 있다.

 -->
	<%@ include file="dbconn_oracle.jsp"%> 
	<% 
	request.setCharacterEncoding("EUC-KR"); //form에서 넘긴 한글처리하기 위함.
	String eno = request.getParameter("eno");
	String ename = request.getParameter("ename");
	String job =request.getParameter("job");
	String manager = request.getParameter("manager");
	String hiredate =request.getParameter("hiredate");
	String salary = request.getParameter("salary");
	String commission = request.getParameter("commission");
	String dno = request.getParameter("dno");

	Statement stmt =null;	//Statment 객체 : SQL쿼리 구문을 담아서 실행하는 객체
	
	try{
		String sql ="INSERT INTO emp_copy ( eno, ename, job, manager, hiredate,salary,commission, dno) Values ('"+ eno + "','"+ename + "','" + job+"','" + manager + "','"+hiredate + "','" +salary + "','" +commission + "','"+ dno + "')";
		
		stmt = conn.createStatement(); //connection 객체를 통해서 statement 객체 생성
		stmt.executeUpdate(sql); //statement 객체를 통해서 sql을 살행함.
			//stmt.executeUpdate(sql): Sql <==insert,update, delete문이 온다.
			//stmt.executeQuery(sql) : sql<== select문이 오면서 결과를 Resultset 객체로 반환
		out.println("테이블 삽입에 성공했습니다.");
		
	}catch(Exception e){
		out.println("mbTbl 테이블 삽입을 실패했습니다.");
		out.println(e.getMessage());
	}finally{
		if(stmt !=null)
			stmt.close();
		if(conn!=null)
			conn.close();
	}
	
%>

	<p>
	<p>
		<%= eno %>
		<%=ename %>
		<%=job %>
		<%=manager %>
		<%=hiredate %>
		<%=salary %>
		<%=commission %>
		<%=dno %>
</body>
</html>