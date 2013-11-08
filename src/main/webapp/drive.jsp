sachen gibt's: "vermögensschadenhaftpflichtversicherung"...: http://www.cash-online.de/berater/2013/infinus-hans-john-vsh/154421

[8 [1 [1 1]] [8 [1 0] [8 [1 [6 [5 [0 15] [4 0 6]] [0 28] [9 2 [[0 2] [4 0 6] [[0 29] [7 [0 14] [8 [1 0] [8 [1 [6 [5 [0 14] [0 6]] [0 15] [9 2 [[0 2] [4 0 6] [0 14] [4 0 15]]]]] [9 2 0 1]]]]] [0 15]]]]] [9 2 0 1]]]] 

<%@page import="java.security.*"%><%@page import="java.io.*"%><%
 String[] files= {
   "C:\\Users\\Tine\\Desktop\\CAM04735.mp4",
   "C:\\Users\\Tine\\Desktop\\SingularTv\\gC6H.mp4",
   "C:\\Users\\Tine\\Desktop\\EmptyFile.txt"
/*   "C:\\Users\\Tine\\Desktop\\SingularTv\\5JfH.mp4",
   "C:\\Users\\Tine\\Desktop\\SingularTv\\S117.mp4",
   "C:\\Users\\Tine\\Desktop\\SingularTv\\wRcH.mp4",
   "C:\\Users\\Tine\\Desktop\\MariaHimmel.jpg",
   "C:\\Users\\Tine\\Desktop\\AlCa2464.zip",
    //https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-prn2/1451473_752295568119400_1927228529_n.jpg #MaHi
   "C:\\Users\\Tine\\Desktop\\RaWa7733.zip",
   "C:\\Users\\Tine\\Desktop\\LockButt.png"
    //https://fbcdn-creative-a.akamaihd.net/hads-ak-frc3/s110x80/1354185_6011484827454_288814682_n.png*/
  };
 //String datafile = "F:\\TerraDrive\\3ae782ddeaabe719cc5df418faf42b08b7c297c8.js";

 MessageDigest md5 = MessageDigest.getInstance("MD5");
 MessageDigest mdSha = MessageDigest.getInstance("SHA1");
 byte[] dataBytes = new byte[1024];
%>
<html>
 <head>
  <title>TerraDrive</title>
 </head>
 <body>
  <h1>TerraDrive</h1>
  <table>
  <tr>
   <th>SHA1</th>
   <th>MD5</th>
   <th>File</th>
</tr>
<%!
  public String split(String s) {
   String ret="";
   while (s.length()>8) {
    ret +=s.substring(0,8)+" ";
    s=s.substring(8);
   }
   return ret;
  }
%> 
<%
 for (int fi=0; fi<files.length; fi++) {
  String datafile=files[fi];
  // http://www.mkyong.com/java/how-to-generate-a-file-checksum-value-in-java/
  long pre=System.currentTimeMillis();
  FileInputStream fis = new FileInputStream(datafile);
  int nread = 0;
  int readCt=0;
  while ((nread = fis.read(dataBytes)) != -1) {
   readCt+=nread;
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
  long post=System.currentTimeMillis();
%>
 <tr>
  <td><code><%=split(sbSha.toString())%></code><sub><%=post-pre%>msec</sub></td>
  <td><code><%=split(sb5.toString())%></code></td>
  <td><%=datafile%></td>
  <td><%=readCt%></td>
 </tr>
<%}%>
</table>
</html>
