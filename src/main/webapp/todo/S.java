import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.File;
import    java.io.FileInputStream;
import java.io.InputStream;
import   java.io.InputStreamReader;
import    java.io.PushbackReader;
import    java.io.StringReader;
import    clojure.lang.Compiler;
import    clojure.lang.IFn;
import    clojure.lang.LispReader;
import    clojure.lang.RT;

// Extend HttpServlet class
public class S extends HttpServlet {
 public void init() throws ServletException {
  //message = "Hello World";
 }

 public void doGet(HttpServletRequest request, HttpServletResponse response)
  throws ServletException, IOException {
// Set response content type
     InputStream lis=new FileInputStream(new File("/home/rawa/DigitalEarth/src/main/webapp/4"));
     PushbackReader pr = new PushbackReader(new InputStreamReader(lis));
     Object rootHandlerExpr=LispReader.read( pr, true, null, false);
     IFn rootHandlerFn=(IFn) Compiler.eval( rootHandlerExpr);
response.setContentType("text/html");
// Actual logic goes here.
PrintWriter out = response.getWriter();
//out.println("<h1>" + message + "</h1>");
out.println(rootHandlerFn.invoke(request,response));
 }

 public void destroy() {
 }
}