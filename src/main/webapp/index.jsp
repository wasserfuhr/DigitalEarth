<%@page import="
java.io.File,
java.io.FileInputStream,
java.io.InputStream,
java.io.InputStreamReader,
java.io.PushbackReader,
java.io.StringReader,
clojure.lang.Compiler,
clojure.lang.IFn,
clojure.lang.LispReader,
clojure.lang.RT
"%><%
 /* Basically delegates to /home/rawa/SemperBase/0
 */
 //String code="(fn [request response] \"HelloWorld\")";
 //PushbackReader pr = new PushbackReader(new StringReader(code));
 //InputStream lis=RT.baseLoader().getResourceAsStream("mind/loader.clj");
 InputStream lis=new FileInputStream(new File("/home/rawa/DigitalEarth/src/main/webapp/2"));
 PushbackReader pr = new PushbackReader(new InputStreamReader(lis));
 Object rootHandlerExpr=LispReader.read( pr, true, null, false);
 IFn rootHandlerFn=(IFn) Compiler.eval( rootHandlerExpr);
%><%=rootHandlerFn.invoke(request,response)%>