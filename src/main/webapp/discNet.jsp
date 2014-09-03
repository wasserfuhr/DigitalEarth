<%@page import="java.security.*"%><%@page import="java.io.*"%><%
 String dirS="/home/rawa/TerraDrive/";
 File dir=new File(dirS);
 //File dir=new File("C:/DiscNet");
 String[] files=dir.list();
 long lenSum=0;
 for (int fi=0; fi<files.length; fi++) {
  // e.g. "2de1b246dd33ea8d90943c72769eaa846d1da329.jpg"
  String hash=files[fi].substring(0,40);
  String datafile=dirS+files[fi];
  long len=new File(datafile).length();
  lenSum+=len;
%><%=hash%> <%=len%>
<%}%><%=lenSum%>
The goal to create a PlanetaryOperatingSystem forces us to 
navigate us through vast amounts of data.
At the moment we are preparing to deal with 2^64 − 1 bits.