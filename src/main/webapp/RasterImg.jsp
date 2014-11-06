<%@ page pageEncoding="UTF-8"%><%@page import="
java.io.File,
java.awt.image.BufferedImage,
java.awt.Color,
javax.imageio.ImageIO"%>
<html>
 <head>
  <meta http-equiv="refresh" content="4; URL=http://sl4.eu/buy">
 </head>
 <body>
 <div style="text-align:center">
 </div>
  <h2 style="position:absolute;z-index:2;color:#aaa;top:10px;font-family:helvetica;left:20px;font-size:12pt">RainerWasserfuhr EtAlii</h2>
  <h1 style="position:absolute;z-index:2;color:red;top:220px;font-family:helvetica;left:60px;font-size:32pt">»NooSphere«</h1>
  <h3 style="position:absolute;z-index:2;text-align:right;color:#fff;top:320px;font-family:helvetica;left:98px;font-weight:normal;font-size:12pt">
   Wie @tineroyal ihren<br/>
   TraumMann fand und wir fast alle<br/>
   UnSterblich werden</h3>
  <h2 style="position:absolute;z-index:2;color:#000;top:470px;font-family:helvetica;left:20px;font-size:12pt">EditionPieschen</h2>
  <canvas height="512" id="c" style="position:absolute;z-index:1;top:20px;" width="386"></canvas>
<script>
 var c=[
<%
 BufferedImage img=ImageIO.read(new File(
  "/home/rawa/TerraDrive/82b93e5763022cceedf0a99b5760c2c8088a706b.jpg"));
 int t[][]=new int[48][64];
 int ct[][]=new int[48][64];
 for (int i=0; i<img.getWidth(); i++) {
  for (int j=0; j<img.getHeight(); j++) {
   Color c=new Color(img.getRGB(i,j));
   t[i*2/71][j*2/71]+=c.getRed()+c.getGreen()+c.getBlue();
   ct[i*2/71][j*2/71]+=3;
  }
 }
 for (int j=0; j<64; j++) {
  %> "<%
  for (int i=0; i<48; i++) {
   %><%=String.format("%01x",t[i][j]/ct[i][j]/16)%><%
  }
  %>",
<%
 }
%>];
 ctx=document.getElementById('c').getContext('2d');
 var b=8;
 for(var i=0;i<64;i++) {
  for(var j=0;j<48;j++) {
   var cc=c[i].charAt(j);;
   ctx.fillStyle="#"+cc+cc+cc;
   ctx.fillRect(j*b,i*b,b,b);
  }
 }
</script>
<a href="http://sl4.eu/sl4"><code>sl++</code></a></html>