<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>001 任意目录读取</title>
</head>
<body>
<h1>017 - 反射型XSS </h1>
<%
    String url = new String(request.getRequestURL());
    String baseUrl = url.substring(0, url.lastIndexOf("/"));
    String normal_querystring = "/xss?input=reports";
    String xss_querystring = "/xss?input=%3cscript%3ealert(1)%3c%2fscript%3e";
%>
<p>正常输入: </p>
<p>curl '<a href="<%=baseUrl+normal_querystring%>" target="_blank"><%=baseUrl + normal_querystring%>
</a>'</p>

<p>不正常输入: </p>
<p>curl '<a href="<%=baseUrl+xss_querystring%>" target="_blank"><%=baseUrl + xss_querystring%>
</a>'</p>
</body>
</html>
