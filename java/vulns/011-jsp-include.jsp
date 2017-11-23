<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8" />
    <title>011 jsp include 任意文件包含</title>
</head>
</html>
<p>正常调用: </p>
<pre>curl <%=request.getRequestURL()%>?url=/</pre>
<p>不正常调用: </p>
<pre>curl <%=request.getRequestURL()%>?url=011-jsp-include.jsp</pre>

<%
    String url = request.getParameter("url");
    if(url == null) {
        url = "/";
    }
%>
<jsp:include page="<%= url %>" />