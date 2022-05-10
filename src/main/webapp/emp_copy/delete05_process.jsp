<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>delete 파일</title>
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

	PreparedStatement pstmt = null;	
	ResultSet re = null; //select 값
	String sql = null; //sql문
	
	try{
		sql = "select eno from emp_copy where eno = ?" ;		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, eno);	
		re = pstmt.executeQuery();
		
		if(re.next()){ //사원번호가 맞으면 수정.위의 조건에서 해당사원번호를 입력했으니까 사원번호가 있는 것임.
			sql= "delete from emp_copy where eno = ?"  ;
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, eno);	
			pstmt.executeUpdate();
			out.println("해당계정이 삭제되었습니다.");
		//String sql2 =  String.format("insert into emp_copy(eno,ename,job,manager ,hiredate,salary,commission,dno) values('%s','%s','%s','%s','%s','%s','%s','%s')", eno,ename,job,manager,hiredate,salary,commission, dno);
			
		}else{
			out.println(eno + " : 사원번호가 존재하지 않습니다.");
		}
		
	}catch(Exception e){
		out.print(e.getMessage());
	}finally{
		if(conn !=null)
			conn.close();
		if(pstmt!=null)
			pstmt.close();
		if(re!=null)
			re.close();
	}
	
%>


</body>
</html>