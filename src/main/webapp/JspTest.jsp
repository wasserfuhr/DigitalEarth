PathInfo: <%=request.getPathInfo()%><br/>
QueryString: <%=request.getQueryString()%><br/>
RequestURI: <%=request.getRequestURI()%><br/>
<script>
 var st=<%=new java.util.Date().getTime()%>;
 var stl=new Date().getTime();
 alert('WARNING: your LocalTime is off by ca. '+ (st-stl)/1000+'sec!');
</script>