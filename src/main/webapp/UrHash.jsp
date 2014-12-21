<%@page import="
java.io.File,
java.util.Vector,
java.security.MessageDigest,
com.almworks.sqlite4java.SQLite,
com.almworks.sqlite4java.SQLiteConnection,
com.almworks.sqlite4java.SQLiteStatement"%><%
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
 SQLiteStatement st=db.prepare("SELECT id FROM a2 order by createdAt desc");
 Vector v=new Vector();
 while( st.step()) {
  v.add(st.columnBlob(0));
 }
 int l=v.size();
 byte[] c = new byte[32*l];
 for (int i=0;i<l;i++) {
  System.arraycopy((byte[])v.get(i), 0, c, i*32, 32);
 }
 MessageDigest hash=MessageDigest.getInstance("SHA-256");
 hash.update(c); 
%><%=c.length+"+#"+javax.xml.bind.DatatypeConverter.printHexBinary(hash.digest()).toLowerCase()%><%
} finally { db.dispose();}%>