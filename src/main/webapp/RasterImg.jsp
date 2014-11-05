<%@ page pageEncoding="UTF-8"%><%@page import="
java.io.File,
java.awt.image.BufferedImage,
java.awt.Color,
javax.imageio.ImageIO"%>
<table style="border-collapse:collapse" border="0">
<%
 //BufferedImage img=ImageIO.read(new File("/home/rawa/c.png"));
 BufferedImage img=ImageIO.read(new File("/home/rawa/DSCN7595.JPG"));
 int t[][]=new int[48][64];
 int ct[][]=new int[48][64];
 for (int i=0; i<img.getWidth(); i++) {
  for (int j=0; j<img.getHeight(); j++) {
  Color c=new Color(img.getRGB(i,j));
  t[i*2/71][j*2/71]+=c.getRed()+c.getGreen()+c.getBlue();///(img.getRGB(i,j)&255;
//   t[i*2/71][j*2/71]+=(img.getRGB(i,j)>>8)&255;
  // t[i*2/71][j*2/71]+=(img.getRGB(i,j)>>16)&255;
   ct[i*2/71][j*2/71]+=3;
  }
 }
 for (int j=0; j<64; j++) {
  %><tr><%
  for (int i=0; i<48; i++) {
   String c=String.format("%01x",t[i][j]/ct[i][j]/16);
  %>
 <td style="width:6px;height:8px;background:#<%=c+c+c%>"></td><%
  }
  %></tr><%
 }
%></table>