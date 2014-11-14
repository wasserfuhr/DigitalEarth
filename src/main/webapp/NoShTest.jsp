<%@page import="
java.io.File,
java.io.PushbackReader,
java.io.RandomAccessFile,
java.io.StringReader,
java.nio.file.Files,
java.nio.file.Paths,
clojure.lang.Compiler,
clojure.lang.IFn,
clojure.lang.LispReader,
clojure.lang.RT"%><%
 String home=System.getProperty("user.home");
 String sep=System.getProperty("file.separator");
 RandomAccessFile raf=new RandomAccessFile(home+sep+"NoSh.base","rws");
 File lock=new File(home+sep+"NoSh.lock");
 while(!lock.createNewFile()) {}
 raf.writeLong(0L);
 lock.delete();
%>