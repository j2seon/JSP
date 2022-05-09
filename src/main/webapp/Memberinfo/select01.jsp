<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DB의 내용을 가져와서 출력하기 </title>
</head>
<body>

<!--디비의 값을 가져와서 출력 (table 형식으로!)-->

<%@ include file ="dbconn_oracle.jsp" %>

<table width ="300" border="1"> 
	<tr>
		<th> 아이디 </th>  
		<th> 이름 </th> 
		<th> 비밀번호 </th> 
		<th> email </th> 
		<th> city </th> 
		<th> phone </th>
	</tr>
<%
	ResultSet rs = null; //ResultSEt객체는 DB의 테이블을 Select 해서 나온 결과 레코드셋을 담는 객체 한줄만 있기때문에 next
	
	Statement stmt = null; //SQL 쿼리를 담아서 실행하는 객체
	
	try {
		String sql ="SELECT * FROM mbTbl";
		stmt = conn.createStatement();	//connevtion 객체의 createStatement()로 stmt를 활성화
		rs=stmt.executeQuery(sql);
			//executeQuery(sql) : select한 결과를 ResultSet객체에 저장해야함.
			//executeQuery(sql) : insert, update, delete
			
			
	while(rs.next()){
			String id =rs.getString("id");
			String name = rs.getString("name");
			String pass = rs.getString("password"); 
			String email = rs.getString("name") ;
			String city= rs.getString("city"); 
			String phone = rs.getString("phone") ;
	%>
	
	<tr>
		<td> <%= id %> </td>  
		<td> <%= name %> </td> 
		<td> <%= pass %> </td> 
		<td> <%= email %> </td> 
		<td> <%= city %> </td> 
		<td> <%= phone %> </td>
	</tr>
	
	
	<%
		
	}			
			
		
	}catch(Exception e ){
		out.println("테이블 호출하는데 실패했습니댜.");
		out.println(e.getMessage());
		
	}finally{
		if(stmt !=null)
			rs.close();
		if(stmt !=null)
			stmt.close();
		if(stmt !=null)
			conn.close();
	}
	
	
	%>





</table>

</body>
</html>