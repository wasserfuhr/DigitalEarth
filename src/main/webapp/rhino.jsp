0;136;0c<%@ page import="
java.io.*,
javax.script.ScriptEngine,
javax.script.ScriptEngineManager
"%><%

 String script = System.getProperty("user.home")+"/DigitalEarth/src/main/webapp/crunch.js";
 String iscript = System.getProperty("user.home")+"/DigitalEarth/src/main/webapp/DigitalPlanetOne.js";

 // http://stackoverflow.com/questions/326390/how-to-create-a-java-string-from-the-contents-of-a-file
 BufferedReader reader = new BufferedReader( new FileReader(script));
 BufferedReader ireader = new BufferedReader( new FileReader(iscript));
 String line = null;
 StringBuilder sb = new StringBuilder();
 String ls = System.getProperty("line.separator");

 while( ( line = ireader.readLine() ) != null ) {
  sb.append(line);
  sb.append(ls);
 }
 while( ( line = reader.readLine() ) != null ) {
  sb.append(line);
  sb.append(ls);
 }

// experimental JavaScript evaluation:
ScriptEngineManager mgr = new ScriptEngineManager();
ScriptEngine engine = mgr.getEngineByName("JavaScript");
engine.put("request", request);
engine.put("response", response);
String s=(String) engine.eval(sb.toString());
%><%=s%><br/>
<%=script%>
<br/><%=sb%>
<br/><%=s%>
