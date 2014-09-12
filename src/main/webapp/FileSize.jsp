<%@page import="java.io.*"%>
 var fileSize={
<%
 FileReader fr = new FileReader("/home/rawa/AllHashes/ShaOne.txt");
 LineNumberReader lnr = new LineNumberReader(fr);

 String str;
 while((str=lnr.readLine())!=null) {
  String spl[]=str.split(" ");
  %>"<%=spl[0]%>":<%=spl[1]%>,
<%}
%>"ffffffffffffffffffffffffffffffffffffffff":42 /*joke*/}