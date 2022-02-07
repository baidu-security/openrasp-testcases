<%--
  Created by IntelliJ IDEA.
  User: litong14
  Date: 2021/12/29
  Time: 1:39 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>020 DNS</title>
</head>
<body>
<h1>020- DNS </h1>
<%
    String url = new String(request.getRequestURL());
    String baseUrl = url.substring(0, url.lastIndexOf("/"));
%>
<a href="<%=baseUrl+"/DNS?option=DNS"%>" target="_blank">DNS good case</a><br/>
<a href="<%=baseUrl+"/DNS?option=DNSBad"%>" target="_blank">DNS bad case</a><br/>
<a href="<%=baseUrl+"/DNS?option=asyncDNS"%>" target="_blank">异步DNS good case</a><br/>
<a href="<%=baseUrl+"/DNS?option=asyncDNSBad"%>" target="_blank">异步 DNS bad case</a><br/><br/>
</body>
</html>