<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>004-2 命令执行后门（有回显）</title>
</head>
<body>
<h1>004 - 命令执行后门（有回显）</h1>
<%
    String url = new String(request.getRequestURL());
    String baseUrl = url.substring(0, url.lastIndexOf("/"));
    String linux_querystring = "/commandEcho?cmd=ls+-la+/";
    String windows_querystring = "/commandEcho?cmd=cmd+/c+dir";
%>
<div>
    <p>Linux 触发: </p>
    <p>curl '<a href="<%=baseUrl+linux_querystring%>" target="_blank"><%=baseUrl + linux_querystring%>
    </a>'</p>
    <br>
    <p>Windows 触发: </p>
    <p>curl '<a href="<%=baseUrl+windows_querystring%>" target="_blank"><%=baseUrl + windows_querystring%>
    </a>'</p>
</div>
</body>
</html>
