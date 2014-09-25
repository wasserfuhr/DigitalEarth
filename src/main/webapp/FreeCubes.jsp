<%@page import="java.io.*" %><%@page import="com.almworks.sqlite4java.*,
clojure.lang.Compiler,
clojure.lang.IFn,
clojure.lang.LispReader,
clojure.lang.RT"%>
<%
 SQLite.setLibraryPath("/home/rawa/DigitalEarth/target/lib");
 SQLiteConnection db = new SQLiteConnection(new File("/home/rawa/UrBase"));
 db.open(true);
 SQLiteStatement st = db.prepare("SELECT * FROM HashChain where IsRoot order by CreatedAt");
 st.step();
 //... eval CloJure
 st.dispose();
 db.dispose();

 String code="(fn [q s] \"HelloCubes\")";
 PushbackReader pr = new PushbackReader(new StringReader(code));
 Object rootHandlerExpr=LispReader.read( pr, true, null, false);
 IFn rootHandlerFn=(IFn) Compiler.eval( rootHandlerExpr);
//  application.setAttribute("RootHandlerFn", rootHandlerFn);
 // memCache.put("RootHandlerFn", rootHandlerFn);
%><%=rootHandlerFn.invoke(request,response)%>