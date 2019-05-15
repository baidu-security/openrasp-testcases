<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>011 - SSRF - commons.httpclient 方式</title>
</head>
<body>
<%
    String url = new String(request.getRequestURL());
    String baseUrl = url.substring(0, url.lastIndexOf("/"));
    String linux_querystring = "/commonClient?url=http://0x7f000001";
%>
<p>commons-httpclient 调用方式: </p>
<p>curl '<a href="<%=baseUrl+linux_querystring%>" target="_blank"><%=baseUrl+linux_querystring%></a>'</p>
<pre>说明: 参数 url 为请求的 url</pre>
</body>
</html>
