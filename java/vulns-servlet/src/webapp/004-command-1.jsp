<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>004 - 命令执行后门（无回显，无拼接）</title>
</head>
<body>
<h1>004 - 命令执行后门（无回显，无拼接）</h1>

<%
    String url = new String(request.getRequestURL());
    String baseUrl = url.substring(0, url.lastIndexOf("/"));
    String linux_querystring = "/command?cmd=cp+/etc/passwd+/tmp/";
    String windows_querystring = "/command?cmd=cmd+/c+calc";
%>
<p>Linux 触发: </p>
<p>curl '<a href="<%=baseUrl+linux_querystring%>" target="_blank"><%=baseUrl + linux_querystring%>
</a>'</p>
<p>然后检查 /tmp 是否存在 passwd 这个文件</p>
<br>

<p>Windows 触发: </p>
<p>curl '<a href="<%=baseUrl+windows_querystring%>" target="_blank"><%=baseUrl + windows_querystring%>
</a>'</p>
<p>点击这里执行 calc.exe</p>
</body>
</html>
