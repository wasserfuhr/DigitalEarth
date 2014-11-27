<%@page import="
java.io.File,
java.util.Arrays,
java.util.Vector"%>
<html>
 <head>
 </head>
 <body>
<%

Vector l=new Vector();
l.addAll(
 java.util.Arrays.asList(new File("/home/rawa/GitHoster/GitHub/wasserfuhr/DigitalEarth/src/main/webapp/BtnWiki/").list()));
l.addAll(
 java.util.Arrays.asList(new File("/home/rawa/GitHoster/GitHub/wasserfuhr/DigitalEarth/src/main/webapp/MindWiki/").list()));
l.addAll(
 java.util.Arrays.asList(new File("/home/rawa/GitHoster/GoogleProjectHosting/ungit.wiki/").list()));

for (int i=0; i<64; i++) {
 int r=new java.util.Random().nextInt(l.size());
 String s=(String)l.get(r);
String s0=s.substring(0,s.indexOf("."));
%>
 <%=s0%> <%
}
%>