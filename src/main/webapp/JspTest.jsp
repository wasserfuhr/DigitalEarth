<html>
 <head><title>JspTest</title></head>
 <body>
  PathInfo: <%=request.getPathInfo()%><br/>
  QueryString: <%=request.getQueryString()%><br/>
  RemoteAddr: <%=request.getRemoteAddr()%><br/>
  RemoteHost: <%=request.getRemoteHost()%><br/>
  RequestURI: <%=request.getRequestURI()%><br/>
  Scheme: <%=request.getScheme()%><br/>
  ServerName: <%=request.getServerName()%><br/>
  ServletPath: <%=request.getServletPath()%><br/>
  UserAgent: <%=request.getHeader("User-Agent")%><br/>
<% //http://stackoverflow.com/questions/12807797/java-get-available-memory : %>
<%=Runtime.getRuntime().totalMemory()%> total<br/>
<%=Runtime.getRuntime().freeMemory()%> free<br/>
<%=Runtime.getRuntime().maxMemory()%> max<br/>
  <br/>
  Cookies:
<%Cookie[] cookies = request.getCookies();
for(Cookie c:cookies){%>
<br/><%=c.getName()%> <%=c.getMaxAge()%> <%=c.getValue()%>
<%}%>
<script>
 var st=<%=new java.util.Date().getTime()%>;
 var stl=new Date().getTime();
 alert('WARNING: your LocalTime is off to AtomicTime by ca. '+ (st-stl)/1000+'sec!');
</script>
 </body>
</html>
