<%@page import="
java.io.File,
java.io.PushbackReader,
java.io.StringReader,
java.nio.file.Files,
java.nio.file.Paths,
clojure.lang.Compiler,
clojure.lang.IFn,
clojure.lang.LispReader,
com.almworks.sqlite4java.SQLite,
com.almworks.sqlite4java.SQLiteConnection,
com.almworks.sqlite4java.SQLiteStatement,
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

 //eval CloJure:
 String i=home+"/GitHoster/GitHub/wasserfuhr/DigitalEarth/src/main/webapp/init.clj";
 String script=request.getParameter("p").replaceAll("[^A-Za-z0-9]",""); //easy anti-injection
 String p=home+"/GitHoster/GitHub/wasserfuhr/DigitalEarth/src/main/webapp/"+script+".clj";
 RT.loadResourceScript("hiccup/core.clj");
 RT.loadResourceScript("clojure/data/json.clj");
 request.setAttribute("db",db);
 String f=new String(Files.readAllBytes(Paths.get(i)));
 PushbackReader pr = new PushbackReader(new StringReader(f));
 Object c=LispReader.read( pr, true, null, false);
 request.setAttribute("c",Compiler.eval(c));
 f=new String(Files.readAllBytes(Paths.get(p)));
 pr = new PushbackReader(new StringReader(f));
 c=LispReader.read( pr, true, null, false);
 IFn fn=(IFn) Compiler.eval(c);
%><%=fn.invoke(request,response)%><%}finally{db.dispose();}%>