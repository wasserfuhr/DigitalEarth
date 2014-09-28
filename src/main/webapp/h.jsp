<%@page import="java.security.*"%><%@page import="java.io.*"%>
var h=[
<% //CAUTION: used by http://singularacademy.appspot.com/SingularMatrix !
//  FileInputStream fis =
 FileReader fr=new FileReader("/home/rawa/GitHoster/GitHub/wasserfuhr/AllHashes/ShaOne.txt"); 
 LineNumberReader lr=new LineNumberReader(fr);
 String l;
 while(null!=(l=lr.readLine())) {
  %>"<%=l%>",
<% }
 fr.close();
%>];