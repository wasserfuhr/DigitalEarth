<%@ page pageEncoding="UTF-8"%><%@page import="
java.io.File,
java.io.IOException,
java.awt.image.BufferedImage,
javax.imageio.ImageIO"%>
<%
 BufferedImage img = null;
 try {
  img = ImageIO.read(new File("/home/rawa/c.png"));
  %><%=img.getWidth()%> <%
  %><%=img.getHeight()%> <%
  for (int i=0; i<48; i++) {
   for (int j=0; j<64; j++) {
   %><%=img.getRGB(i,j)%><%
   }
   %></br><%
  }
 } catch (IOException e) {
 }
%>