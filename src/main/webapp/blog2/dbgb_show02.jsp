<%@page import="javax.print.attribute.HashPrintRequestAttributeSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link href ="filegb.css" rel ="sytlesheet" type = "text/css">
</head>
<body>
	<%@ include file = "dbconn_oracle.jsp" %> 


<% 
	//vector 컬렉션을 생성해서 DB에서 가져온 데이터를 저장하는 
	Vector name = new Vector();
	Vector email = new Vector();
	Vector inputdate = new Vector();
	Vector subject = new Vector();
	Vector content = new Vector();
	
	//페이징처리할 변수 선언
	int where = 1; //현재 위치한 페이지 번호
	int totalgroup = 0;
	int maxpage = 2;	//출력할 페이지 갯수
	int startpage = 1; 	//출력할 페이지의 첫번째 레코드
	int endpage = startpage + maxpage -1;
	int wheregroup = 1; //현재 위치한 페이지그룹 
	
	//get방식으로 페이지를 선택했을 때 go(현재페이지),
	//gogroup(현재페이지 그룹)변수를 받아서 처리를 함.
	if(requset.getParameter("go") !=null){ //현재페이지에 번호가 넘어올때
		where = Integer.parseInt(request.getParameter("go"));
		wheregroup = (where-1)/maxpage+1;
		startpage=(wheregroup -1) *maxpage+1;
		endpage = startpage + maxpage -1;
	}else if(request.getParameter("gogroup") != null){
		wheregroup = Integer.parseInt(request.getParameter("gogroup"));
		startpage = (wheregroup-1) * maxpage+1;
		where =startpage;
		endpage=startpage+maxpage -1;
	}
	
	int nextgroup = wheregroup + 1;//[다음]
	int priorgroup = wheregroup -1; //[이전]
	
	int nextpage = where +1; //다음페이지
	int priorpage = where -1; //이전페이지
	
	int startrow = 0;	//특정페이지에서 시작레코드 번호
	int endrow = 0;		//특정페이지에서 마지막 레코드 번호 
	
	int maxrows = 2; //출력 시 2개의 레코드만
	int totalrow = 0;
	int totalpage = 0;
	
	String sql = null;
	Statement st = null;
	ResultSet rs = null; //Select 한 결과 레코드 셋을 담는 객체 
	
	try{
		sql = "select * from guestboard ofrby inputdate desc";
		st = conn.createStatement();
		rs = st.executeQuery(sql);

		if(!(rs.next())){
			out.println("글이없습니다.");
		}else{
			do{
%>				
			<table width ="600" border = "1">
			<tr><td colspan = "2" align="center"> <h3><%=rs.getString("subject") %></h3></td>			
			<tr><td>글쓴이 : <%=rs.getString("name") %></td>
				<td>글쓴이 : <%=rs.getString("email") %></td> </tr>
				<tr><td colspan = 2> 글쓴날짜 : <%=rs.getString("inputdate")%></td></tr>
				<tr><td colspan = 2 width="600"><%=rs.getString("content") %></td></tr>
				
				<tr height="25"><td colspan="2">&nbsp; </td></tr>
			</table>
				
<% 		}while(rs.next());			
			
			
		}
	
	
	
	
	}catch(Exception ex){
		out.println(ex.getMessage());
	}finally{
		if(st != null)
			st.close();
		if(conn != null)
			conn.close();
		if(rs != null)
			rs.close();
	}
	
%>



</body>
</html>