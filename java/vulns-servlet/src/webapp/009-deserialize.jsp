<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>009 - Transformer 反序列化</title>
</head>
<body>
<h1>009 - 使用 InvokerTransformer 反序列化并执行命令</h1>
<%
    String url = new String(request.getRequestURL());
    String baseUrl = url.substring(0, url.lastIndexOf("/"));
    String linux_querystring = "/deserialization?id=whoami";
    String windows_querystring = "/deserialization?id=calc";
%>
<p>Linux 测试</p>
<p>curl '<a href="<%=baseUrl+linux_querystring%>" target="_blank"><%=baseUrl + linux_querystring%>
</a>'</p>

<p>Windows 测试</p>
<p>curl '<a href="<%=baseUrl+windows_querystring%>" target="_blank"><%=baseUrl + windows_querystring%>
</a>'</p>
</body>
</html>
