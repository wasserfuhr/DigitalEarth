<%@page import="
java.io.File"%>
<html>
 <head>
  <meta http-equiv="refresh" content="2">
 </head>
 <body>
<%
String s[]=new File("/home/rawa/GitHoster/GitHub/wasserfuhr/DigitalEarth/src/main/webapp/BtnWiki/").list();

int r=new java.util.Random().nextInt(s.length);

%>
<%=s[r]%>