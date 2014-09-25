<%@page import="
java.io.File,
java.nio.file.Files,
java.nio.file.Paths,
java.io.PushbackReader,
java.io.StringReader,
com.almworks.sqlite4java.SQLite,
com.almworks.sqlite4java.SQLiteConnection,
clojure.lang.Compiler,
clojure.lang.IFn,
clojure.lang.LispReader,
clojure.lang.RT"%>
<%
SQLiteConnection db=null;
try {
 //Cookie c=new Cookie("UnCookie","1");
 //c.setMaxAge(60*60*24*30); 
 //response.addCookie(c);
 SQLite.setLibraryPath("/home/rawa/DigitalEarth/target/lib");
 db = new SQLiteConnection(new File("/home/rawa/UrBase"));
 db.open(true);
 db.exec("PRAGMA foreign_keys = ON");

 //http://stackoverflow.com/questions/326390/how-to-create-a-java-string-from-the-contents-of-a-file
 String code=new String(java.nio.file.Files.readAllBytes(
  java.nio.file.Paths.get("/home/rawa/DigitalEarth/boot.clj")));
 
 //eval CloJure:
 RT.loadResourceScript("hiccup/core.clj");
 PushbackReader pr = new PushbackReader(new StringReader(code));
 Object rootHandlerExpr=LispReader.read( pr, true, null, false);
 IFn rootHandlerFn=(IFn) Compiler.eval( rootHandlerExpr);
%><%=rootHandlerFn.invoke(request,response,db)%><%
} finally { db.dispose();}%>