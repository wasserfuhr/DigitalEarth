<%@page import="
java.io.File,
java.nio.file.Files,
java.nio.file.Paths,
java.util.Arrays,
java.util.Vector"%><%
String dirs[]={
 "GitHub/wasserfuhr/DigitalEarth/src/main/webapp/MindWiki/",
 "GitHub/wasserfuhr/DigitalEarth/src/main/webapp/BtnWiki/",
 "GoogleProjectHosting/ungit.wiki/"};
String exts[]={
 "txt","wiki","wiki"};
String s="/home/rawa/GitHoster/";
String content="";
for (int i=0; i<3; i++) {
 String f=s+dirs[i]+request.getParameter("p")+"."+exts[i];
 if (new File(f).exists()) {
  content=new String(Files.readAllBytes(Paths.get(f)));
 }
}
%><%=content%>.