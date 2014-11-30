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
 String script=request.getParameter("p").replace(".","").substring(0,10); // easy anti-injection 

%>
<%="ashg_,dd".replaceAll("[^A-Za-z0-9]","")%>

<%
 String p=home+"/GitHoster/GitHub/wasserfuhr/DigitalEarth/src/main/webapp/"+script+".clj";
 RT.loadResourceScript("hiccup/core.clj");
 String c=new String(Files.readAllBytes(Paths.get(p)));
 PushbackReader pr = new PushbackReader(new StringReader(c));
 Object rootHandlerExpr=LispReader.read( pr, true, null, false);
 IFn rootHandlerFn=(IFn) Compiler.eval( rootHandlerExpr);
%><%=rootHandlerFn.invoke(request,response)%>