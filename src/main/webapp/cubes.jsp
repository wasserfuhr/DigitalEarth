<%@page import="java.io.*" %><%@page import="com.almworks.sqlite4java.*"%>
var cachedCubes=false;
var UrCube=1;
var cubes={
<%
 //e.g.: 89001:{m:1,c:[88002,94001,95001,99001,100001,100002,101001,102001]},

 SQLiteConnection db = new SQLiteConnection(new File("/home/rawa/tmpsql/cub"));
 db.open(true);

 SQLiteStatement st;
 //st = db.prepare("INSERT INTO cube VALUES (?,?,?)");
 st = db.prepare("SELECT id,material,c000,c001,c010,c011,c100,c101,c110,c111 FROM cube order by CreatedAt");
/**
 st = db.prepare(//"SELECT * FROM cubes WHERE order by LastEditAt");
 //st.executeUpdate(
   "CREATE TABLE cube (key INT,"+
   "c000 INT,"+
   "material BYTE)");
**/
 try {
/*  st.bind(1, 1);
  st.bind(2, 1);
  st.bind(3, 1);
  st.step();*/
  while (st.step()) {
%><%=st.columnLong(0)%>:{m:<%=st.columnInt(1)%><%
   String c="";
   for(int i=2;i<10;i++) {
    if(st.columnNull(i) ){
     c+="0";
    } else {
     c+=st.columnLong(i);
    }
    if( i<9) {
     c+=",";
    }
   }
   if(!"0,0,0,0,0,0,0,0".equals(c)) {
    %>,c:[<%=c%>]<%
   }
   %>},
<%
  }
 } finally {
  st.dispose();
 }
 db.dispose();
%>};