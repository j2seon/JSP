<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%@ page import ="java.sql.*, java.util.*,java.text.*"  %> 
 <% request.setCharacterEncoding("UTF-8"); %>  <!-- 한글 처리 --> 
 <%@ include file = "dbconn_oracle.jsp" %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>form 의 값을 받아서 DataBase에 값을 넣어주는 파일 </title>
</head>
<body>


<% 
	//폼에서 넘긴 값을 받아서 각 변수에 저장한다.
	String na = request.getParameter("name");
	String em = request.getParameter("email");
	String sub = request.getParameter("subject");
	String cont = request.getParameter("content");
	String pw = request.getParameter("password");
	
	int id = 1; //DB에 id 컬럼에 저장할 값.
	int pos = 0;  //cont 에 값이 들어올때 
	if(cont.length() == 1 ) {
		cont = cont + " ";
     }
	
	//content(Text Area)에 엔터를 처리해줘야한다. Oracle DB에 저장시에 엔터에 관한 내용
	while((pos = cont.indexOf("\'" , pos))!=-1){
		String left = cont.substring(0,pos);
		String right = cont.substring(pos , cont.length());
		cont = left + "\'" + right;
		pos += 2;
	}

	//오늘의 날짜를 처리하는 함수 
	java.util.Date yymmdd = new java.util.Date(); //java.util.Date today = new java.util.Date();
	SimpleDateFormat myformat = new SimpleDateFormat("yy-MM-d h:mm a ");
	String ymd = myformat.format(yymmdd); //myformat.format(today);
	
	String sql = null;
	Statement st = null;
	ResultSet rs = null;
	int cnt = 0; // insert 가 잘 되었는지 아닌지 확인 하는 변수 
	
 	try{
         
 		//값을 저장하기 전에 최신 글번호 (max(id))를 가져와서 +1을 적용한다.
 		//conn(Connection) : Auto commit;이 작동된다
 			//commit을 명시하지 않아도 insert , update, delete 구문에 자동 커밋이 된다/
 		st = conn.createStatement();
 		sql = "select max (id) from freeboard";
 		rs = st.executeQuery(sql);
 		
 		if(!(rs.next())){ //rs의 값이 비어있을 때
 			id = 1 ;
 		}else{	//rs의 값이 존재할때
 			id = rs.getInt(1) + 1; //최대값 + 1
 		}
 		
         sql = "Insert into freeboard (id, name, password, email, subject, ";
         sql = sql + "content, inputdate, masterid, readcount, replaynum , step)";
         sql = sql + " values (" + id + ",'"  + na + "','" + pw + "', '" + em ;
         sql = sql + "','" + sub + "','" + cont + "','" + ymd + "'," + id + ",";
         sql = sql + "0,0,0)";
         
         
      	cnt = st.executeUpdate(sql); //cnt>0 : insert 성공  st.executeUpdate(sql)이 정수 값을 반환함.
      	
      	if(cnt > 0){
      		out.println("데이터가 성공적으로 입력되었습니다");
      	}else{
      		out.println("데이터가 입력되지 않았습니다");
      	}
      	
      }catch (Exception e){out.println(e.getMessage());
      }finally{
    	  if(conn !=null)
    		  conn.close();    	  
    	  if(st != null)
    		  st.close();
    	  if(rs != null)
        	rs.close();
      }
%>


<jsp:forward page = "freeboard_list.jsp" />



</body>
</html>