<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
    <title>Title</title>
</head>
<body>

<h1>011-ssrf-okhttp3</h1>
<%
    String url = new String(request.getRequestURL());
    String baseUrl = url.substring(0, url.lastIndexOf("/"));
    String linux_querystring = "/okHttp3?url=http://0x7f000001";
%>
<p>okhttp 调用方式: </p>
<p>curl '<a href="<%=baseUrl+linux_querystring%>" target="_blank"><%=baseUrl+linux_querystring%></a>'</p>
</body>
</html>
