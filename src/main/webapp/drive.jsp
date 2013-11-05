<%@page import="java.security.*"%><%@page import="java.io.*"%><%
 // http://www.mkyong.com/java/how-to-generate-a-file-checksum-value-in-java/
 //String datafile = "C:\\Users\\Tine\\Desktop\\SingularTv\\S117.mp4";
 //String datafile = "C:\\Users\\Tine\\Desktop\\MariaHimmel.jpg";
 //String datafile = "C:\\Users\\Tine\\Desktop\\SingularTv\\wRcH.mp4";
 //String datafile = "C:\\Users\\Tine\\Desktop\\RaWa7733.zip";
 //String datafile = "F:\\Users\\Tine\\Desktop\\RaWa7733.zip";
 String datafile = "C:\\Users\\Tine\\Desktop\\SingularTv\\5JfH.mp4";
 //String datafile = "F:\\TerraDrive\\3ae782ddeaabe719cc5df418faf42b08b7c297c8.js";
 //String datafile = "H:\\EmptyFile.txt";

 MessageDigest md5 = MessageDigest.getInstance("MD5");
 MessageDigest mdSha = MessageDigest.getInstance("SHA1");
 FileInputStream fis = new FileInputStream(datafile);
 byte[] dataBytes = new byte[1024];
 
 int nread = 0; 
 
 while ((nread = fis.read(dataBytes)) != -1) {
      md5.update(dataBytes, 0, nread);
      mdSha.update(dataBytes, 0, nread);
 };
 
 byte[] md5Bytes = md5.digest();
 byte[] mdShaBytes = mdSha.digest();
 
 //convert the byte to hex format
 StringBuffer sb5 = new StringBuffer("");
 for (int i = 0; i < md5Bytes.length; i++) {
   sb5.append(Integer.toString((md5Bytes[i] & 0xff) + 0x100, 16).substring(1));
 }
 StringBuffer sbSha = new StringBuffer("");
 for (int i = 0; i < mdShaBytes.length; i++) {
  sbSha.append(Integer.toString((mdShaBytes[i] & 0xff) + 0x100, 16).substring(1));
 }

%>
<%=datafile%> :
<table>
<tr>
 <th>SHA1</th>
 <th>MD5</th>
</tr>
<tr>
<td>
<%=sbSha.substring(0,8)%>
<%=sbSha.substring(8,16)%>
<%=sbSha.substring(16,24)%>
<%=sbSha.substring(24,32)%>
<%=sbSha.substring(32,40)%>
<%=sbSha.substring(40)%>
</td>
<td>
<%=sb5.substring(0,8)%>
<%=sb5.substring(8,16)%>
<%=sb5.substring(16,24)%>
<%=sb5.substring(24,32)%>
<%=sb5.substring(32)%>
sb5.substring(40)
</td>
</tr>
</table>
