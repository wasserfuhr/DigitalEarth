<%@page import="
java.io.File,
java.nio.file.Files,
java.nio.file.Paths"%><%
String s="/home/rawa/GitHoster/";
String gh="GitHub/wasserfuhr/DigitalEarth/src/main/webapp/";
String dirs[]={
 gh+"MindWiki",
 gh+"BtnWiki",
 "GoogleProjectHosting/ungit.wiki"};
String exts[]={
 "txt","wiki","wiki"};
String content="";
for (int i=0; i<3; i++) {
 String f=s+dirs[i]+"/"+request.getParameter("p")+"."+exts[i];
 if (new File(f).exists()) {
  content=new String(Files.readAllBytes(Paths.get(f)));
 }
}
%><%=content%>