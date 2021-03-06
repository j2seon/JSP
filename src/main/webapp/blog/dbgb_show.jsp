<%@page import="java.lang.annotation.Retention"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page language="java" import="java.sql.*,java.util.*" %> 
<% request.setCharacterEncoding("UTF-8"); %>  <!-- 한글 처리 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%@ include file = "dbconn_oracle.jsp" %>

<%  //Vector은 : 멀티쓰레드 환경에서 사용한다, 모든 메소드가 동기화 처리 되어있다.
 
 
  Vector name = new Vector(); 	//DB에 Name 값만 저장하는 벡터 
  Vector inputdate = new Vector(); 	 //	
  Vector email = new Vector();
  Vector subject = new Vector();
  Vector rcount = new Vector();
  
  Vector step = new Vector();  //DB의 step컬럼의 값을 저장하는 vector
  Vector keyid = new Vector();  //DB의 ID컬럼의 값을 저장하는 vector
  
  
  //페이징 처리 시작 부분 
  
  int where=1;

  int totalgroup=0;			//출력할 페이징의 그룹핑의 최대 갯수,
  int maxpages=5; 			//최대 페이지 갯수 (화면에 출력되 페이지 갯수!)
  int startpage=1;			//마지막페이지
  int endpage=startpage+maxpages-1;	//마지막페이지
  int wheregroup=1;				//현재 위치하는 그룹
  
  
  
  
	//go : 해당 페이지번호로 이동.
	//freeboard_list.jap?go=3(페이지 번호 )>> get방식
 
	//gogroup : 출력할 페이지의 그룹핑
	//freeboard_list.jap?gogroup=2(maxpage가 5일 때 6,7,8,9,10)
 
  //go변수!(페이지 번호)를 넘겨받아서 wheregroup, statpage ,endpage 정보의 값을 알아낸다.
	if (request.getParameter("go") != null) { // go 변수의 값을 가지고 있을 때
   where = Integer.parseInt(request.getParameter("go"));	//현재 페이지 번호를 담은 변수 
   wheregroup = (where-1)/maxpages + 1; 	//현재 위치한 페이지의 그룹
   startpage=(wheregroup-1) * maxpages+1;  //startpage와endpage는 그룹이 바뀔 때마다 바뀌는 것을 생각하자
   endpage=startpage+maxpages-1; 
   
   
   //gogroup 변수가 넘겨 받아서 startpage, endpage, where(페이지 그룹의 첫번째 페이지를 담는다.) 
  } else if (request.getParameter("gogroup") != null) {
   wheregroup = Integer.parseInt(request.getParameter("gogroup"));
   startpage=(wheregroup-1) * maxpages+1;  
   where = startpage ; //그룹의 첫번째 페이지
  
   endpage=startpage+maxpages-1; 
  }
 
 
  int nextgroup=wheregroup+1; //다음그룹 : 현재 그룹 + 1
  int priorgroup= wheregroup-1; //현재 그룹 -1

  int nextpage=where+1; //다음페이지 :현재 페이지 +1
  int priorpage = where-1; //이전페이지 :현재페이지 -1
  int startrow=0;  // 하나의 page에서 레코드 시작 번호 
  int endrow=0;	   // DataBase에서 Select 한 레코드 마지막 번호
  int maxrows=5; 		//출력할 레코드 수 
  int totalrows=0;		//총 레코드 갯수
  int totalpages=0;		//총 페이지 갯수 
  
  
  //out.println("===== 현재 maxpage : 3 일 때 ====" + "<p>");
 // out.println("현재 페이지 :" + where + "<p>");
 // out.println("현재 페이지 그룹" + wheregroup + "<p>");
 // out.println("시작 페이지 :" + startpage + "<p>");
//  out.println("끝 페이지 :" + endpage + "<p>");
  //if (true) return;
  
  
  
  
  //페이징 처리 마지막 부분 
  

  int id=0;

  String em=null;
  //Connection con= null;
  Statement st =null;
  ResultSet rs =null;


 try {
  st = conn.createStatement();
  String sql = "select * from  order by" ;
  rs = st.executeQuery(sql);
  
  //out.println(sql);
  //if (true) return;  //프로그램 종료 
  

  if (!(rs.next()))  {
   out.println("게시판에 올린 글이 없습니다");
  } else {
   do {
    name.addElement(rs.getString("name"));
    email.addElement(rs.getString("email"));
    String idate = rs.getString("inputdate");
    inputdate.addElement(idate);
    subject.addElement(rs.getString("subject"));
     
   }while(rs.next());
   
   
   
   totalrows = name.size();  //name vector에 저장된 값의 갯수 , 총 레코드 수 
   totalpages = (totalrows-1)/maxrows +1;
   startrow = (where-1) * maxrows;		//현재페이지의 시작 레코드 번호
   endrow = startrow+maxrows-1  ;		//현재 페이지의 마지막 레코드 번호
   
   //out.println("======= max row : 3일때 ======== ");
   //out.println("총 레코드 수 : " + totalrows + "<p>");
   //out.println("현재 페이지 : " + where + "<p>");
   //out.println("시작 레코드 : " + startrow + "<p>");
   //out.println("마지막 레코드 : " + endrow + "<p>");
   
   
   
   if (endrow >= totalrows)		//마지막 row가 
    endrow=totalrows-1;
  
   totalgroup = (totalpages-1)/maxpages +1; //페이지의 그룹핑 
   
   out.println("토탈페이지 그룹 " + totalgroup);
   
   
   if (endpage > totalpages) 
    endpage=totalpages;

   //현재 페이지에서 시작레코드 ,마지막 래코드까지 순환하면서 출력
   for(int j = startrow; j<=endrow; j++) {
    String temp=(String)email.elementAt(j); 	//email vector에서 email 주소를 가지고 온다
    if ((temp == null) || (temp.equals("")) ) 	//메일 주소가 비어있을 때 
     em= (String)name.elementAt(j); //em 변수에 이름만 가저온다
    else //메일 주소를 가지고 있을 때 메일 주소 앞뒤로 링크!
     em = "<A href=mailto:" + temp + ">" + name.elementAt(j) + "</A>";

    id= totalrows-j;
    
    
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
   
   //out.println("J :"+ j + "<p>");
   //out.println("ID"+keyid.elementAt(j)+"<p>");
   //out.println("Subject :" + subject.elementAt(j) + "<p>");
   //out.println("em :" + em + "<p>");
   //if(true) return;
   	
   	
   }//endfor 

	//if(true) return;
   
   
   rs.close();
  }
  out.println("</TABLE>");
  st.close();
  conn.close();
 } catch (java.sql.SQLException e) {
  out.println(e);
 } 

 if (wheregroup > 1) {//현재 나의 그룹이 1 이상일 때는 링크가 걸리고
  out.println("[<A href=freeboard_list.jsp?gogroup=1>처음</A>]"); 
  out.println("[<A href=freeboard_list.jsp?gogroup="+priorgroup +">이전</A>]");
 } else {//1일때 링크없이 적기만함!!
  out.println("[처음]") ;
  out.println("[이전]") ;
 }
 if (name.size() !=0) { 
  for(int jj=startpage; jj<=endpage; jj++) {
   if (jj==where) 
    out.println("["+jj+"]") ; //현제 페이지와 같다면 링크 x 
   else
    out.println("[<A href=freeboard_list.jsp?go="+jj+">" + jj + "</A>]") ; //같지 않다면 링크 
   } 
  }
  if (wheregroup < totalgroup) {
   out.println("[<A href=freeboard_list.jsp?gogroup="+ nextgroup+ ">다음</A>]");
   out.println("[<A href=freeboard_list.jsp?gogroup="+ totalgroup + ">마지막</A>]");
  } else {
   out.println("[다음]");
   out.println("[마지막]");
  }
  out.println ("전체 글수 :"+totalrows); 
 %>
	  		out.println("<table width='600' cellspacing='0' cellpadding='2' align='center'>");
			 out.println("<tr>");
			 out.println("<td height='22'>&nbsp;</td></tr>");
			 out.println("<tr align='center'>");
			 out.println("<td height='1' bgcolor='#1F4F8F'></td>");
			 out.println("</tr>");
			 out.println("<tr align='center' bgcolor='#DFEDFF'>");
			 out.println("<td class='button' bgcolor='#DFEDFF'>"); 
			// out.println("<div align='left'><font size='2'>"+rs.getString("subject") + "</div> </td>");
			 out.println("</tr>");
			 out.println("<tr align='center' bgcolor='#FFFFFF'>");
		  	 out.println("<td align='center' bgcolor='#F4F4F4'>"); 
		  	 out.println("<table width='100%' border='0' cellpadding='0' cellspacing='4' height='1'>");
			 out.println("<tr bgcolor='#F4F4F4'>");
			 out.println("<td width='13%' height='7'></td>");
			// out.println("<td width='51%' height='7'>글쓴이 : "+ em +"</td>");
			 out.println("<td width='25%' height='7'></td>");
			 out.println("<td width='11%' height='7'></td>");
			 out.println("</tr>");
			 out.println("<tr bgcolor='#F4F4F4'>");
			 out.println("<td width='13%'></td>");
			// out.println("<td width='51%'>작성일 : " + rs.getString("inputdate") + "</td>");
			// out.println("<td width='25%'>조회 : "+(rs.getInt("readcount")+1)+"</td>");
			 out.println("<td width='11%'></td>");
			 out.println("</tr>");
			 out.println("</table>");
			 out.println("</td>");
			 out.println("</tr>");
			 out.println("<tr align='center'>");
			 out.println("<td bgcolor='#1F4F8F' height='1'></td>");
			 out.println("</tr>");
			 out.println("<tr align='center'>");
			 out.println("<td style='padding:10 0 0 0'>");
			 out.println("<div align='left'><br>");
			// out.println("<font size='3' color='#333333'><PRE>"+rs.getString("content") + "</PRE></div>");
			 out.println("<br>");
			 out.println("</td>");
			 out.println("</tr>");
			 out.println("<tr align='center'>");
			 out.println("<td class='button' height='1'></td>");
			 out.println("</tr>");
			 out.println("<tr align='center'>");
			 out.println("<td bgcolor='#1F4F8F' height='1'></td>");
			 out.println("</tr>");
			 out.println("</table>");

	  
	 
		  
	  }
%>



		


</body>
</html>