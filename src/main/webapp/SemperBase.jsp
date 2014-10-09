<%@page import="
java.io.File,
java.io.PushbackReader,
java.io.StringReader,
com.almworks.sqlite4java.SQLite,
com.almworks.sqlite4java.SQLiteConnection,
com.almworks.sqlite4java.SQLiteStatement,
clojure.lang.Compiler,
clojure.lang.IFn,
clojure.lang.LispReader,
clojure.lang.RT"%><%
SQLiteConnection db=null;
try {
 //http://stackoverflow.com/questions/585534/what-is-the-best-way-to-find-the-users-home-directory-in-java
 String home=System.getProperty("user.home");
 String sqliteS="/.m2/repository/com/almworks/sqlite4java/";
 String sLib=home+sqliteS+"libsqlite4java-";
 if ("Linux".equals(System.getProperty("os.name"))) {
  sLib+="linux-i386";
 } else {
  sLib+="win32-x86";
 } //ToDo: osx?
 sLib+="/0.282";
 SQLite.setLibraryPath(sLib);
 db = new SQLiteConnection(new File(home+"/UrBase.sqlite"));
 db.open(true);
 db.exec("PRAGMA foreign_keys = ON");
 SQLiteStatement st=db.prepare("SELECT script FROM a2 where tag='BootScript' order by createdAt desc");
 st.step();

 //eval CloJure:
 RT.loadResourceScript("hiccup/core.clj");
 PushbackReader pr = new PushbackReader(new StringReader(st.columnString(0)));
 Object rootHandlerExpr=LispReader.read( pr, true, null, false);
 IFn rootHandlerFn=(IFn) Compiler.eval( rootHandlerExpr);
%><%=rootHandlerFn.invoke(request,response,db)%><%
} finally { db.dispose();}%>