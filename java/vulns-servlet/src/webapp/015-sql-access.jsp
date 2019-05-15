<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>015 - sql access</title>
</head>
<body>
<h1>015 - sql access</h1>

<%
    String url = new String(request.getRequestURL());
    String baseUrl = url.substring(0, url.lastIndexOf("/"));
%>
<p>触发: </p>
<p>curl '<a href="<%=baseUrl+"/sqlAccess"%>" target="_blank"><%=baseUrl + "/sqlAccess"%></a>'</p>
</body>
</html>
