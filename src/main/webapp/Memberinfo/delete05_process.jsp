<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*" %>
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
 
<%@ include file = "dbconn_oracle.jsp" %>
<% 
	request.setCharacterEncoding("EUC-KR"); //form에서 넘긴 한글처리하기 위함.
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name =request.getParameter("name");
	String email = request.getParameter("email");
	
	
	
	PreparedStatement pstmt =null;	//Statment 객체 : SQL쿼리 구문을 담아서 실행하는 객체
	ResultSet re = null; //select한 결과를 담는 객체 select한 레코드셋을 담고있다.
	String sql = null; 
	
	try{
		//form에서 넘긴 ID와 Password가 같으면 레코드 삭제 id(primary key)
		sql = "SELECT id, password FROM mbTbl where id = ?";
		pstmt =conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, password);
		pstmt.setString(3, name);
		pstmt.setString(4, email);
		
		
		re=pstmt.executeQuery(sql);
		
		if(re.next()){ //id가 존재할때 
			//re의 결과 레코드를 변수에 할당함.
			String rId = re.getString("id");
			String rPass= re.getString("password");
			
			//패스워드가 일치하는지 확인.
			if(password.equals(rPass)){
				sql = "delete from mbTbl where id= ?";
				pstmt.setString(1, id);
				pstmt.setString(2, password);
				pstmt.setString(3, name);
				pstmt.setString(4, email);
				pstmt.executeUpdate();
				out.println("해당계정이 삭제되었습니다.");

			}else{ //패스워드가 일치하지 않을 때
				out.println("패스워드가 틀립니다.");
			}
			
		}else{
			out.println(id + "해당 아이디가 존재하지 않습니다.");
		}
		
		
		
	}catch(Exception e){
		out.println(e.getMessage());

	}finally{
		if(conn !=null)
			conn.close();
		if(pstmt!=null)
			pstmt.close();
		if(re!=null)
			re.close();
	}
	
	//드라이버 로드 -> 드라이버 인스턴스가 메모리에 올라감 -> 
	//연결 실행 후 연결이 완료되면 객체의 결과를 정상적으로 con 변수에 반환함 -> 연결된 객체를 베이스로하여 Statement st 인스턴스 생성 (st 인스턴스 : 사용자의 쿼리를 수행함) -> 
	//st.executeQuery(sql)을 통해 쿼리를 실행하면 서버쪽에서는 결과(레코드) 집합이 만들어지고, 
	//서버에서는 사용자에게 레코드 한줄 씩 반환할 작업을 ResultSet에 담아 완료한다. 
	//(결과를 하나씩 반환하기 위해 Before of File부터 End of File까지 결과를 가르키는 커서가 있는데, 
	//레코드를 가르키는 포인터 또는 커서라고 함) -> 즉, ResultSet에 값을 받았다는 것은, 쿼리를 실행한 결과를 전부 가져왔다라는 
	//의미가아닌 한줄씩 결과를 이용할 수 있는 상태가 된 것 -> 그런 하나의 자료를 이용하기 위해서는 빈 그릇을 만들어야 하는데 
	//그 빈그릇을 통해 가져오는 명령문(패치)이 rs.next();이다. -> 자료를 가져온 뒤 rs.getString("title")과 같은 
	//명령어를 통해 Java 코드에 담아서 사용한다.
	
	
%>

<p><p>
<%= id %> <p>
<%=password %> <p>
<%=name %> <p>
<%=email %><p>
<%=sql %> <p> <p>
<%out.println(sql); %>

<!--
<%=sql %> <p> <p> html 블락에서 출력할떄 
<%out.println(sql); %> jsp 블락에서 출력할 때 
-->

</body>
</html>