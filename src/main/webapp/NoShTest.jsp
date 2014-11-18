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
 String h=new String(Files.readAllBytes(Paths.get(home+sep+"GitHoster/GitHub/wasserfuhr/DigitalEarth/bootRaf.clj")));
 // String h=new String(Files.readAllBytes(Paths.get(home+sep+"SemperBase.hilde")));
 RandomAccessFile raf=new RandomAccessFile(home+sep+"SemperBase.base","rws");
 //eval CloJure:
 RT.loadResourceScript("hiccup/core.clj");
 PushbackReader pr = new PushbackReader(new StringReader(h));
 Object rootHandlerExpr=LispReader.read( pr, true, null, false);
 IFn rootHandlerFn=(IFn) Compiler.eval( rootHandlerExpr);
%><%=rootHandlerFn.invoke(request,response,raf)%><%
 while(!lock.createNewFile()) {}
 raf.writeByte(2);
 raf.writeLong(0L);
 lock.delete();
%>