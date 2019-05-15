<%@page contentType="text/html; charset=UTF-8" %>
<%
    String url = new String(request.getRequestURL());
    String baseUrl = url.substring(0, url.lastIndexOf("/"));
    String normal_querystring = "/readFile?file=example.pdf";
    String linux_querystring = "/readFile?file=../../../../../../../../../../../../../../../etc/passwd";
    String windows_querystring = "/readFile?file=../../../conf/tomcat-users.xml";
%>

<html>
<head>
    <meta charset="UTF-8"/>
    <title>002 任意文件下载/读取漏洞</title>
</head>
<body>
<h1>002 - 任意文件下载/读取漏洞（路径拼接）</h1>
<p>正常调用: </p>
<p>curl '<a href="<%=baseUrl+normal_querystring%>" target="_blank"><%=baseUrl + normal_querystring%>
</a>'</p>
<p>不正常调用: </p>
<p>curl '<a href="<%=baseUrl+linux_querystring%>" target="_blank"><%=baseUrl + linux_querystring%>
</a>'</p>
<p>不正常调用: </p>
<p>curl '<a href="<%=baseUrl+windows_querystring%>" target="_blank"><%=baseUrl + windows_querystring%>
</a>'</p>
<p>读取内容</p>
</body>
</html>
