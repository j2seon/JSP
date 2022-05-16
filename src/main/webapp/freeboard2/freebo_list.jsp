<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*,java.util.*" %> 
<% request.setCharacterEncoding("EUC-KR"); %>  <!-- 한글 처리 --> 
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시판</title>
<link href="freeboard.css" rel="stylesheet" type="text/css">
<SCRIPT language="javascript">
 function check(){
  with(document.msgsearch){
   if(sval.value.length == 0){
    alert("검색어를 입력해 주세요!!");
    sval.focus();
    return false;
   }	
   document.msgsearch.submit();
  }
 }
 function rimgchg(p1,p2) {
  if (p2==1) 
   document.images[p1].src= "image/open.gif";
  else
   document.images[p1].src= "image/arrow.gif";
  }

 function imgchg(p1,p2) {
  if (p2==1) 
   document.images[p1].src= "image/open.gif";
  else
   document.images[p1].src= "image/close.gif";
 }
</SCRIPT>
</head>
<body>
	<%@ include file = "db_connection_oracle1.jsp" %>
<P>
<P align=center><FONT color=#0000ff face=굴림 size=3><STRONG>자유 게시판</STRONG></FONT></P> 
<P>
<CENTER>
 <TABLE border=0 width=600 cellpadding=4 cellspacing=0>
  <tr align="center"> 
   <td colspan="5" height="1" bgcolor="#1F4F8F"></td>
  </tr>
  <tr align="center" bgcolor="#87E8FF"> 
   <td width="42" bgcolor="#DFEDFF"><font size="2">번호</font></td>
   <td width="340" bgcolor="#DFEDFF"><font size="2">제목</font></td>
   <td width="84" bgcolor="#DFEDFF"><font size="2">등록자</font></td>
   <td width="78" bgcolor="#DFEDFF"><font size="2">날짜</font></td>
   <td width="49" bgcolor="#DFEDFF"><font size="2">조회</font></td>
  </tr>
  <tr align="center"> 
   <td colspan="5" bgcolor="#1F4F8F" height="1"></td>
  </tr>	


<%
	Vector name = new Vector();
	Vector inputdate = new Vector();
	Vector email = new Vector();
	Vector subject = new Vector();
	Vector rcount = new Vector();
	Vector step = new Vector();
	Vector keyid = new Vector(); 
	
	int where = 1;
	int totalgroup = 0; //출력할 페이징의 그룹핑의 최대 갯수
	int maxpage = 5;	//최대 페이지 갯수 (화면에 출력될 페이지 갯수!)
	int startpage = 1 ; 
	int endpage = startpage + maxpage -1;//마지막페이지
	int wheregroup = 1;
	
	if(request.getParameter("go")!=null){
		where = Integer.parseInt(request.getParameter("go"));
		wheregroup = (where - 1)/maxpage + 1;
		startpage = (wheregroup-1) * maxpage + 1;
		endpage = startpage + maxpage - 1;
		
	}else if(request.getParameter("gogroup") != null){
		wheregroup = Integer.parseInt(request.getParameter("gogroup"));
		startpage = (wheregroup-1) * maxpage + 1;
		where = startpage;
		
		endpage = startpage + maxpage -1;
	}
	
	int nextgroup = wheregroup +1;
	int priorgroup = wheregroup-1;
	
	int nextpage = where + 1;
	int priorpage = where - 1;
	int startrow = 0;
	int endrow = 0;
	int maxrow = 7; 
	int totalrow=0;
	int totalpage=0;
	
	
	 int id=0;
	 
	 String em = null;
	 Statement st = null;
	 ResultSet rs = null;
	 
	 try{
		 st = conn.createStatement();
		  String sql = "select * from freeboard order by" ;
		  sql = sql + " masterid desc, replaynum, step, id" ;
		  rs = st.executeQuery(sql);
		  
	if(!(rs.next())){
		   out.println("게시판에 올린 글이 없습니다");
	}else{
		
		do{
		keyid.addElement(new Integer(rs.getInt("id"))); 
	    		//rs의 id 컬럼의 값을 가져와서 vector에 저장.
	  	name.addElement(rs.getString("name"));
	   	email.addElement(rs.getString("email"));
	    String idate = rs.getString("inputdate");
	    idate = idate.substring(0,8); //0~8자까지만 
	    inputdate.addElement(idate);
	    subject.addElement(rs.getString("subject"));
	    rcount.addElement(new Integer(rs.getInt("readcount")));
	    step.addElement(new Integer(rs.getInt("step")));
		}while(rs.next());
		
		totalrow = name.size();
		totalpage =(totalrow-1)/maxrow + 1;
		startrow = (where-1) * maxrow;
		endrow = startrow + maxrow - 1;
		
		out.println("총 레코드 수 : " + totalrow + "<p>");
		 out.println("현재 페이지 : " + where + "<p>");
		 out.println("시작 레코드 : " + startrow + "<p>");
		  out.println("마지막 레코드 : " + endrow + "<p>");
		
		  if (endrow >= totalrow)		//마지막 row가 
			    endrow=totalrow-1;
			   totalgroup = (totalpage-1)/maxpage +1; //페이지의 그룹핑 
			   out.println("토탈페이지 그룹 " + totalgroup);
		  if (endpage > totalpage) 
  			    endpage = totalpage;
		  
		  for(int j = startrow; j<=endrow; j++){
			  String temp = (String) email.elementAt(j);
			  if ((temp == null) || (temp.equals("")) )
				  em= (String)name.elementAt(j);
			  else
				 em = "<A href=mailto:" + temp + ">" + name.elementAt(j) + "</A>";

			    id = totalrow - j;
				  
			    
			    if(j%2 == 0){ // j가 짝수일 때 
			        out.println("<TR bgcolor='#FFFFFF' onMouseOver=\" bgColor= '#DFEDFF'\" onMouseOut=\"bgColor=''\">");	
			       } else { //j가 홀수 일때 
			        out.println("<TR bgcolor='#F4F4F4' onMouseOver=\" bgColor= '#DFEDFF'\" onMouseOut=\"bgColor='#F4F4F4'\">");
			       // \는 "를 출력할때 앞에 사용한다. 
			       } 
			       out.println("<TD align=center>");
			       out.println(id+"</TD>");
			       out.println("<TD>");
			       
			       int stepi= ((Integer)step.elementAt(j)).intValue();
			       int imgcount = j-startrow;
			       
			       //답변글인 경우
			       if (stepi > 0 ) {
			        for(int count=0; count < stepi; count++) 
			         out.print("&nbsp;&nbsp;"); //답변글인 경우 공백 2칸처리
			        out.println("<IMG name=icon"+imgcount+ " src=image/arrow.gif>");
			        out.print("<A href=freeboard_read.jsp?id=");
			        out.print(keyid.elementAt(j) + "&page=" + where );
			        out.print(" onmouseover=\"rimgchg(" + imgcount + ",1)\"");
			        out.print(" onmouseout=\"rimgchg(" + imgcount + ",2)\">");
			       } else {
			        out.println("<IMG name=icon"+imgcount+ " src=image/close.gif>");
			        out.print("<A href=freeboard_read.jsp?id=");
			        out.print(keyid.elementAt(j) + "&page=" + where );
			        out.print(" onmouseover=\"imgchg(" + imgcount + ",1)\"");
			        out.print(" onmouseout=\"imgchg(" + imgcount + ",2)\">");
			       }
			       out.println(subject.elementAt(j) + "</TD>");
			       out.println("<TD align=center>");
			       out.println(em+ "</TD>");
			       out.println("<TD align=center>");
			       out.println(inputdate.elementAt(j)+ "</TD>");
			       out.println("<TD align=center>");
			       out.println(rcount.elementAt(j)+ "</TD>");
			       out.println("</TR>"); 
		  }
		  
	}
		  
		  
		  
	 }catch(Exception e){}

%>






</body>
</html>