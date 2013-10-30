<%
    long cube=new Long(request.getParameter("cube"));
    //operation:
    String op=request.getParameter("op");
    int material=new Integer(request.getParameter("material"));
    String child=request.getParameter("child");%>
<%=cube%> <%=material%>
