<%@page import="java.io.*" %><%@page import="com.almworks.sqlite4java.*"%><%
 if ("9dqbbv8ammsq116efid5k0alk".equals(request.getSession().getId())) {
  long cube=new Long(request.getParameter("cube"));
  //operation:
  String op=request.getParameter("op");

  String materialS=request.getParameter("material");
  String child=request.getParameter("child");

  SQLiteConnection db = new SQLiteConnection(new File("/home/rawa/tmpsql/cub"));
  db.open(true);
 
  SQLiteStatement st;

  if ("add".equals(op)) {
   int material=new Integer(materialS);
   st = db.prepare("INSERT INTO cube (BotOp,CreatedAt,CreatedBy, materialcube (VALUES (?,?,?)");
  }

  if ("bot".equals(op)) {
  int material=new Integer(materialS);
   st = db.prepare("INSERT INTO BotOp (BotOp,CreatedAt,CreatedBy, materialcube (VALUES (?,?,?)");
  }
 //4x4x4 matrix
 //MatTree
 //{c000:1,c001:{c000:1},}
  if ("set".equals(op)) {
   int material=new Integer(materialS);
   st = db.prepare("update cube set material= (materialcube (VALUES (?,?,?)");
   st.bind(1, material);
  }

 st = db.prepare("SELECT id,material,c000,c001,c010,c011,c100,c101,c110,c111 FROM cube order by CreatedAt");
/**
 st = db.prepare(//"SELECT * FROM cubes WHERE order by LastEditAt");
 //st.executeUpdate(
   "CREATE TABLE cube (key INT,"+
   "c000 INT,"+
   "material BYTE)");
**/

%>
hi RaWa: <%=cube%> <%=material%>
<%}%>