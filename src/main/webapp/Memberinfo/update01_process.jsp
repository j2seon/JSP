<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file = "dbconn_oracle.jsp" %>

<%
	//form에서 request 개겣의 getParmeter로 변수의 값을 받는다.
	
	request.setCharacterEncoding("UTF-8");
	
	String id = request.getParameter("id");
	String password= request.getParameter("password");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	
	Statement stmt = null; 
	ResultSet re = null; //select한 결과를 담는 객체 select한 레코드셋을 담고있다.
	String sql =null;
	//폼에서 넘겨받은 id와 패스워드를 dB에서 가져온 정보를 확인해서 같으면 업데이트 구문을 시행하고
	// 다르면 업데이트 하지 않는다. 
	try{
		//폼에서 넘겨받은 아이디를 조건으로 DB의 값을 select 해온다.
		sql = "SELECT id, password FROM mbTbl where id = '"+ id +"'";
		stmt =conn.createStatement(); //stmt의 객체를 활성화한다.
		re = stmt.executeQuery(sql); //SELECT문인 경우 executeQuery를 사용한다.
		
		if(re.next()){//DB에 해당아이디가 존재하면 ==>폼에서 넘긴 패스워드와 db의 패스워드가 일치하는 지 확인
			out.println(id+" : 해당 아이디가 존재합니다");
			//DB에서 값을 가지고 온 ID와 password를 변수에 할당.
			String rId = re.getString("id");
			String rPass =re.getString("password");
			
			//form 에서 넘겨준 값과 db에서 가져온 값이 일치하는지 확인 // 아이디는 이미 확인 ㅇㅇ 패스워드확인하자
			if(id.equals(rId) && password.equals(rPass)){
				//db에서 가져온 패스워드와 form에서 넘긴 패스워드가 일치할때 update
				sql= "update mbtbl set name = '"+name+"', email = '"+email+"' where id = '"+id+"'";
				//stmt= conn.createStatement();
				stmt.executeUpdate(sql);
				out.println("테이블의 내용이 잘 수정되었습니다.");
				
			}else{ //패스워드가 일치하지 않을 때 
				out.println(" 패스워드가 일치하지 않습니다. ");
			}
			
			
		}else{//아니면 false
			out.println(id+" : 해당 아이디가 데이터 베이스에 존재하지 않습니다.");
		}
		
		
	}catch(Exception e){out.println(e.getMessage());
	}finally{
		if(conn !=null)
			conn.close();
		if(stmt!=null)
			stmt.close();
		if(re!=null)
			re.close();
	}
	


%>
</body>
</html>