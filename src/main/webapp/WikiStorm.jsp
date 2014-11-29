<%@page import="
java.io.File,
java.util.Arrays,
java.util.Vector"%>
<html>
 <head>
  <title>WikiStorm</title>
 </head>
 <body style="font-family:monospace">
  <script>
function show(p) {
 //document.getElementById("f").src='http://sl4.eu/wiki/'+p;
 document.getElementById("f").src='http://planet.sl4.eu/WikiRaw.jsp?p='+p;
 return false;
}
  </script>
<%
Cookie[] cookies = request.getCookies();
 String sc="";
 if( cookies != null) {
  for (int i = 0; i < cookies.length; i++){
   if ("JSESSIONID".equals( cookies[i].getName())) {
    sc=cookies[i].getValue();
    System.out.println(">"+sc+"<");

   }
  }
 }
Vector l=new Vector();
String dirs[]={
 "GitHoster/GitHub/wasserfuhr/DigitalEarth/src/main/webapp/MindWiki/",
 "GitHoster/GitHub/wasserfuhr/DigitalEarth/src/main/webapp/BtnWiki/",
 "GitHoster/GoogleProjectHosting/ungit.wiki/"};
for (int i=0; i<3; i++) {
 l.addAll( Arrays.asList(new File("/home/rawa/"+dirs[i]).list()));
}%>
  <h1>WikiStorm</h1>
  blowing <%=l.size()%> leaves. Take 64 of them<%=
 "135sqn1a7lbyet4lztju7x62y".equals(sc)||
 "67ywy8tu3wp1ev0qo6plq0yf".equals(sc)
?", RaWa":""%>:
  <table>
   <tr>
    <td>
<%for (int i=0; i<64; i++) {
 int r=new java.util.Random().nextInt(l.size());
 String s=(String)l.get(r);
 String s0=s.substring(0,s.indexOf("."));
%> <a href="#" onclick="show('<%=s0%>')"><%=s0%></a> <%
}%>
    </td>
    <td>
     <iframe id="f" src="http://sl4.eu/wiki/BrainStorm"/>
    </td>
   </tr>
  </table>
 <br/><a href="/flow.jsp">flow!</a>
</html>