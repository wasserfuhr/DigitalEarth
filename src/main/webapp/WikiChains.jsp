<%@page import="
java.io.PushbackReader,
java.io.StringReader,
java.nio.file.Files,
java.nio.file.Paths,
clojure.lang.Compiler,
clojure.lang.IFn,
clojure.lang.LispReader,
clojure.lang.RT"%><%
 //eval CloJure:
 String home=System.getProperty("user.home");
 RT.loadResourceScript("hiccup/core.clj");
 String c=new String(Files.readAllBytes(Paths.get(home+"/GitHoster/GitHub/wasserfuhr/DigitalEarth/src/main/webapp/WikiChains.clj")));
 PushbackReader pr = new PushbackReader(new StringReader(c));
 Object rootHandlerExpr=LispReader.read( pr, true, null, false);
 IFn rootHandlerFn=(IFn) Compiler.eval( rootHandlerExpr);
%><%=rootHandlerFn.invoke(request,response)%>