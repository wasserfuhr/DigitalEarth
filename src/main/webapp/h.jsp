<%@page import="java.security.*"%><%@page import="java.io.*"%>
var h=[
<%
//  FileInputStream fis =
 FileReader fr=new FileReader("/home/rawa/AllHashes/ShaOne.txt"); 
 LineNumberReader lr=new LineNumberReader(fr);
 String l;
 while(null!=(l=lr.readLine())) {
  %>"<%=l%>",
<% }
 fr.close();
%>];