<%@ page pageEncoding="UTF-8"%><%@page import="
java.io.File,
java.awt.image.BufferedImage,
java.awt.Color,
javax.imageio.ImageIO"%>
<html>
 <h1 style="color:red">»NooSphere«</h1>
 <canvas height="256" id="c" style="border:1px solid #aaa;" width="192"></canvas>
<script>
 var c=[
<%
 BufferedImage img=ImageIO.read(new File("/home/rawa/DSCN7595.JPG"));
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
 var b=4;
 for(var i=0;i<64;i++) {
  for(var j=0;j<48;j++) {
   var cc=c[i].charAt(j);;
   ctx.fillStyle="#"+cc+cc+cc;
   ctx.fillRect(j*b,i*b,b,b);
  }
 }
</script>
<code>sl++</code></html>