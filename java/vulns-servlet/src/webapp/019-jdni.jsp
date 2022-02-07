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
    String defaultHost = "127.0.0.1";
    String normalPort = "1099";
    String normalServiceName = "hello";

    String abnormalPort = "1098";
    String abnormalServiceName = "hello";
%>
<!-- 本地起的服务-->
<a href="<%=baseUrl+"/JDNI?option=start&port=" + normalPort +"&serviceName=" + normalServiceName%>"
   target="_blank">正常注册JDNI服务</a><br/>
<a href="<%=baseUrl+"/JDNI?option=call&port=" + normalPort +"&serviceName=" + normalServiceName%>"
   target="_blank">正常调用JDNI服务</a><br/>

<!-- 不是本地起的服务，请修改defaultHost-->
<a href="<%=baseUrl+"/JDNI?option=asyncCallJDNI&port=" + normalPort +"&serviceName=" + normalServiceName + "&host=" + defaultHost%>"
   target="_blank">正常异步调用JDNI服务</a><br/>

<a href="<%=baseUrl+"/JDNI?option=startBad&port=" + abnormalPort +"&serviceName=" + abnormalServiceName%>"
   target="_blank">不正常注册JDNI服务</a><br/>
<!-- 不是本地起的服务，请修改defaultHost-->
<a href="<%=baseUrl+"/JDNI?option=callBad&port=" + abnormalPort +"&serviceName=" + abnormalServiceName + "&host=" + defaultHost%>"
   target="_blank">不正常调用JDNI服务</a><br/>
<a href="<%=baseUrl+"/JDNI?option=asyncCallBadJDNI&port=" + abnormalPort +"&serviceName=" + abnormalServiceName + "&host=" + defaultHost%>"
   target="_blank">不正常异步调用JDNI服务</a><br/><br/>
</body>
</html>
