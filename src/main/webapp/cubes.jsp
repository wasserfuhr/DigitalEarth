<%@page import="
java.sql.Connection,
java.sql.DriverManager,
java.sql.ResultSet,
java.sql.Statement"%>var cachedCubes=true;
var root=1;
var cubes={
<%
 Class.forName("org.apache.derby.jdbc.EmbeddedDriver");
 Connection conn = DriverManager.getConnection("jdbc:derby:/home/rawa/DigitalPlanet");
 Statement s=conn.createStatement();
 try {
  ResultSet rs=s.executeQuery("SELECT * FROM cube");
  while (rs.next()) {
   String c="";
   for (int  i=0;i<8;i++) {
    c+=rs.getLong(i+3)+((i<7)?",":"");
   }
  String cs=c.equals("0,0,0,0,0,0,0,0")?"":(",c:["+c+"]");
%><%=rs.getLong(1)%>:{m:<%=rs.getLong(2)%><%=cs%>},
<%
  }
 } finally {
  conn.close();
 };
%>};