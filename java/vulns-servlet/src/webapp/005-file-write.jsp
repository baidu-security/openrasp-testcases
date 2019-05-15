<%@page contentType="text/html; charset=UTF-8" %>

<html>
<head>
    <meta charset="UTF-8"/>
    <title>005 任意文件写入</title>
</head>
<body>
<%
    String url = new String(request.getRequestURL());
    String baseUrl = url.substring(0, url.lastIndexOf("/"));
    String normal_querystring = "/writeFile?filename=123.txt&amp;filedata=some-report-data";
    String linux_querystring = "/writeFile?filename=123.jsp&amp;filedata=some-webshell-data";
%>
<p>正常调用</p>
<p>curl '<a href="<%=baseUrl+normal_querystring%>" target="_blank"><%=baseUrl + normal_querystring%>
</a>'</p>
<p>不正常调用</p>
<p>curl '<a href="<%=baseUrl+linux_querystring%>" target="_blank"><%=baseUrl + linux_querystring%>
</a>'</p>
</body>
</html>
