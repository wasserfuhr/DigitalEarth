<%
String sc="1";//8m76rqm9orzk1szp5ns7s50st";
//Cookie sec=new Cookie("SemperCookie",sc);
Cookie sec=new Cookie("SemperCookie","1");
sec.setMaxAge(Integer.MAX_VALUE>>1);// ok, PostSingular should be sufficient ;)
response.addCookie(sec);
%> <%=Integer.MAX_VALUE>>1%>