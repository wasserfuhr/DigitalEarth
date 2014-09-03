<!DOCTYPE html><%@page import="java.io.*"%>
<html>
 <head>
  <title>TsDiff</title>
 </head>
 <body>
  <h1>TsDiff</h1>
  <h2>find oldest timestamps on 2 TerraDrive dirs</h2>
  <table id="t">
   <tr>
    <th>hash</th>
   </tr>
  </table>
  <script>
<%
 //e.g. call 
 // http://planet.sl4.eu/tsDiff.jsp?p1=/home/rawa/TerraDrive/&p2=/home/rawa/tDn/
 String p1=request.getParameter("p1");
 String p2=request.getParameter("p2");
 File dir1=new File(p1);
 File dir2=new File(p2);
%>
 var h={};
<%
 String[] files1=dir1.list();
 String[] files2=dir2.list();
 String pn[]={p1,p2};
 String files[][]={files1,files2};
 for (int i=0;i<2;i++) {
  for (int fi=0; fi<files[i].length; fi++) {
   String hash=files[i][fi].substring(0,40);
   String datafile=pn[i]+files[i][fi];
   long len=new File(datafile).lastModified();
%>if (!h["<%=hash%>"])h["<%=hash%>"]={};h["<%=hash%>"].p<%=i+1%>=<%=len%>;
<%}
 }%>
 var table=document.getElementById("t");
 var hs=Object.keys(h).sort();
 for(var t in hs) {
  var row = table.insertRow(table.rows.length);
  var cell0 = row.insertCell(0);
  cell0.innerHTML=hs[t];
  var cell1 = row.insertCell(1);
  cell1.innerHTML=""+h[hs[t]].p1;
  var cell2 = row.insertCell(2);
  cell2.innerHTML=""+h[hs[t]].p2;
 }
  </script>
 </body>
</html>
