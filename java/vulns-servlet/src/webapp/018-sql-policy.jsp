<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>018 - sql policy</title>
</head>
<body>
<h1>018 - sql access</h1>

<%
    String url = new String(request.getRequestURL());
    String baseUrl = url.substring(0, url.lastIndexOf("/"));
%>
<p>触发: </p>
<p>curl '<a href="<%=baseUrl+"/sqlPolicy"%>" target="_blank"><%=baseUrl + "/sqlPolicy"%></a>'</p>
</body>
</html>
