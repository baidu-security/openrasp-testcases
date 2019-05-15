<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>016 - ognl</title>
</head>
<body>
<h1>016 - ognl</h1>

<%
    String url = new String(request.getRequestURL());
    String baseUrl = url.substring(0, url.lastIndexOf("/"));
%>
<p>触发: </p>
<p>curl '<a href="<%=baseUrl+"/ognl"%>" target="_blank"><%=baseUrl + "/ognl"%></a>'</p>
</body>
</html>
