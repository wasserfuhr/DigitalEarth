<%
String sc="13374";//8m76rqm9orzk1szp5ns7s50st";
sc="1";//6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b
//Cookie sec=new Cookie("SemperCookie",sc);
Cookie sec=new Cookie("SemperCookie",sc);
sec.setMaxAge(Integer.MAX_VALUE>>1);// ok, PostSingular should be sufficient ;)
response.addCookie(sec);
%> <%=Integer.MAX_VALUE>>1%>