<%@page import="
java.io.File,
java.io.PushbackReader,
java.io.StringReader,
java.nio.file.Files,
java.nio.file.Paths,
clojure.lang.Compiler,
clojure.lang.IFn,
clojure.lang.LispReader,
clojure.lang.RT"%><%
 String home=System.getProperty("user.home");
 //eval CloJure:
 String i=home+"/GitHoster/GitHub/wasserfuhr/DigitalEarth/src/main/webapp/init.clj";
 String s=request.getParameter("p").replaceAll("[^A-Za-z0-9]",""); //easy anti-injection
 String p=home+"/GitHoster/GitHub/wasserfuhr/DigitalEarth/src/main/webapp/"+s+".clj";
 RT.loadResourceScript("hiccup/core.clj");
 RT.loadResourceScript("clojure/data/json.clj");
 RT.loadResourceScript("clojure/java/shell.clj");
 String f=new String(Files.readAllBytes(Paths.get(i)));
 PushbackReader pr=new PushbackReader(new StringReader(f));
 Object c=LispReader.read(pr,true,null,false);
 request.setAttribute("c",Compiler.eval(c));
 f=new String(Files.readAllBytes(Paths.get(p)));
 pr=new PushbackReader(new StringReader(f));
 c=LispReader.read(pr,true,null,false);
 IFn fn=(IFn)Compiler.eval(c);
%><%=fn.invoke(request,response)%>