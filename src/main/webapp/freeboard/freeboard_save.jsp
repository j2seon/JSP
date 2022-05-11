<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
 <%@ page import ="java.sql.*, java.util.*,java.text.*"  %> 
 <% request.setCharacterEncoding("EUC-KR"); %>  <!-- �ѱ� ó�� --> 
 <%@ include file = "dbconn_oracle.jsp" %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>form �� ���� �޾Ƽ� DataBase�� ���� �־��ִ� ���� </title>
</head>
<body>


<% 
	//������ �ѱ� ���� �޾Ƽ� �� ������ �����Ѵ�.
	String na = request.getParameter("name");
	String em = request.getParameter("email");
	String sub = request.getParameter("subject");
	String cont = request.getParameter("content");
	String pw = request.getParameter("password");
	
	int id = 1; //DB�� id �÷��� ������ ��.
	int pos = 0;  //cont �� ���� ���ö� 
	if(cont.length() == 1 ) {
		cont = cont + " ";
     }
	
	//content(Text Area)�� ���͸� ó��������Ѵ�. Oracle DB�� ����ÿ� ���Ϳ� ���� ����
	while((pos = cont.indexOf("\'" , pos))!=-1){
		String left = cont.substring(0,pos);
		String right = cont.substring(pos , cont.length());
		cont = left + "\'" + right;
		pos += 2;
	}

	//������ ��¥�� ó���ϴ� �Լ� 
	java.util.Date yymmdd = new java.util.Date(); //java.util.Date today = new java.util.Date();
	SimpleDateFormat myformat = new SimpleDateFormat("yy-MM-d h:mm a ");
	String ymd = myformat.format(yymmdd); //myformat.format(today);
	
	String sql = null;
	Statement st = null;
	ResultSet rs = null;
	int cnt = 0; // insert �� �� �Ǿ����� �ƴ��� Ȯ�� �ϴ� ���� 
	
 	try{
         
 		//���� �����ϱ� ���� �ֽ� �۹�ȣ (max(id))�� �����ͼ� +1�� �����Ѵ�.
 		//conn(Connection) : Auto commit;�� �۵��ȴ�
 			//commit�� ������� �ʾƵ� insert , update, delete ������ �ڵ� Ŀ���� �ȴ�/
 		st = conn.createStatement();
 		sql = "select max (id) from freeboard";
 		rs = st.executeQuery(sql);
 		
 		if(!(rs.next())){ //rs�� ���� ������� ��
 			id = 1 ;
 		}else{	//rs�� ���� �����Ҷ�
 			id = rs.getInt(1) + 1; //�ִ밪 + 1
 		}
 		
         sql = "Insert into freeboard (id, name, password, email, subject, ";
         sql = sql + "content, inputdate, masterid, readcount, replaynum , step)";
         sql = sql + " values (" + id + ",'"  + na + "','" + pw + "', '" + em ;
         sql = sql + "','" + sub + "','" + cont + "','" + ymd + "'," + id + ",";
         sql = sql + "0,0,0)";
         
         
      	cnt = st.executeUpdate(sql); //cnt>0 : insert ����  st.executeUpdate(sql)�� ���� ���� ��ȯ��.
      	
      	if(cnt > 0){
      		out.println("�����Ͱ� ���������� �ԷµǾ����ϴ�");
      	}else{
      		out.println("�����Ͱ� �Էµ��� �ʾҽ��ϴ�");
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