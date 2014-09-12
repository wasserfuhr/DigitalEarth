<%@page import="java.security.*"%><%@page import="java.io.*"%>
<html>
 <head>
  <title>TerraDrive</title>
 </head>
 <body>
  <h1>TerraDrive</h1>
  <pre>
<%
 for (int i=0; i<256; i++) {
  MessageDigest mdSha = MessageDigest.getInstance("SHA1");
  byte[] bytes = new byte[1];
  bytes[0]=(byte)i;
  mdSha.update(bytes, 0, 1);
  byte[] mdShaBytes = mdSha.digest();
 
  //convert the byte to hex format
  StringBuffer sb = new StringBuffer("");
  for (int j=0; j<mdShaBytes.length; j++) {
   sb.append(Integer.toString((mdShaBytes[j] & 0xff) + 0x100, 16).substring(1));
  }
%><%=sb%> 1
<%}%>
</pre>
</html>
