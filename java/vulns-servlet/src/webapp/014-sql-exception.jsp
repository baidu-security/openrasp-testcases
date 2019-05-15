<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>014 - sql exception</title>
</head>
<body>
<h1>014 - sql exception</h1>

<%
    String url = new String(request.getRequestURL());
    String baseUrl = url.substring(0, url.lastIndexOf("/"));
%>
<p>触发: </p>
<p>curl '<a href="<%=baseUrl+"/sqlException"%>" target="_blank"><%=baseUrl + "/sqlException"%></a>'</p>
</body>
</html>
