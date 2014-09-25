<%@page import="java.io.*" %><%@page import="com.almworks.sqlite4java.*,
clojure.lang.Compiler,
clojure.lang.IFn,
clojure.lang.LispReader,
clojure.lang.RT"%>
<%
 Cookie c=new Cookie("UnCookie","1");
 c.setMaxAge(60*60*24*30); 
 response.addCookie(c);
 SQLite.setLibraryPath("/home/rawa/DigitalEarth/target/lib");
 SQLiteConnection db = new SQLiteConnection(new File("/home/rawa/UrBase"));
 db.open(true);
 SQLiteStatement st = db.prepare("SELECT * FROM HashChain where IsRoot order by CreatedAt");
 st.step();
 //... eval CloJure
 st.dispose();
 db.dispose();

 //http://stackoverflow.com/questions/326390/how-to-create-a-java-string-from-the-contents-of-a-file
 String code=new String(java.nio.file.Files.readAllBytes(
  java.nio.file.Paths.get("/home/rawa/DigitalEarth/boot.clj")));
 //"(fn [q s] \"HelloCubes\")";
 
  RT.loadResourceScript("hiccup/core.clj");
  PushbackReader pr = new PushbackReader(new StringReader(code));
 Object rootHandlerExpr=LispReader.read( pr, true, null, false);
 IFn rootHandlerFn=(IFn) Compiler.eval( rootHandlerExpr);
//  application.setAttribute("RootHandlerFn", rootHandlerFn);
 // memCache.put("RootHandlerFn", rootHandlerFn);
%><%=rootHandlerFn.invoke(request,response)%>