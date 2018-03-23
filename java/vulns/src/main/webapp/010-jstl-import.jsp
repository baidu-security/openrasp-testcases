<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8" />
    <title>010 - JSTL import 任意文件包含/SSRF</title>
</head>
</html>
<p>正常调用: </p>
<pre>curl <%=request.getRequestURL()%>?url=/</pre>
<br>

<p>不正常调用 - file 协议读取目录: </p>
<pre>curl <%=request.getRequestURL()%>?url=file:///etc/</pre>

<p>不正常调用 - file 协议读取文件: </p>
<pre>curl <%=request.getRequestURL()%>?url=file:///var/log/httpd/error_log</pre>

<p>不正常调用 - http 协议 SSRF: </p>
<pre>curl <%=request.getRequestURL()%>?url=http://192.168.1.1</pre>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String url = request.getParameter("url");
    if(url != null) {
%>
<c:import url="<%= url %>" />   
<% } %>
