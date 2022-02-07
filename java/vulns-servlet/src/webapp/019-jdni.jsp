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
    <title>019 JDNI</title>
</head>
<body>
<h1>019 - JDNI </h1>
<%
    String url = new String(request.getRequestURL());
    String baseUrl = url.substring(0, url.lastIndexOf("/"));
%>
<a href="<%=baseUrl+"/JDNI?option=start"%>" target="_blank">正常注册JDNI服务</a><br/>
<a href="<%=baseUrl+"/JDNI?option=call"%>" target="_blank">正常调用JDNI服务</a><br/>
<a href="<%=baseUrl+"/JDNI?option=asyncCallJDNI"%>" target="_blank">正常异步调用JDNI服务</a><br/>

<a href="<%=baseUrl+"/JDNI?option=startBad"%>">不正常注册JDNI服务</a><br/>
<a href="<%=baseUrl+"/JDNI?option=callBad"%>">不正常调用JDNI服务</a><br/>
<a href="<%=baseUrl+"/JDNI?option=asyncCallBadJDNI"%>">不正常异步调用JDNI服务</a><br/><br/>
</body>
</html>
