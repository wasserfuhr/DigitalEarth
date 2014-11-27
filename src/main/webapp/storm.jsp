B<%@page import="
java.io.File,
java.util.Arrays,
java.util.Vector"%>
<html>
 <head>
 </head>
 <body>
<%
Vector l=new Vector();
String dirs[]={
 "GitHoster/GitHub/wasserfuhr/DigitalEarth/src/main/webapp/MindWiki/",
 "GitHoster/GitHub/wasserfuhr/DigitalEarth/src/main/webapp/BtnWiki/",
 "GitHoster/GoogleProjectHosting/ungit.wiki/"};
for (int i=0; i<3; i++) {
 l.addAll( Arrays.asList(new File("/home/rawa/"+dirs[i]).list()));
}
for (int i=0; i<64; i++) {
 int r=new java.util.Random().nextInt(l.size());
 String s=(String)l.get(r);
 String s0=s.substring(0,s.indexOf("."));
%> <a href="http://sl4.eu/wiki/<%=s0%>"><%=s0%></a> <%
}%>
<br/><a href="/flow.jsp">flow!</a>