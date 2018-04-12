<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8" />
    <title>010 - JSTL import 任意文件包含/SSRF</title>
</head>
</html>
<%
    String normal_querystring = "?url=/";
    String linux_querystring_dir = "?url=file:///etc/";
    String linux_querystring_file = "?url=file:///var/log/httpd/error_log";
    String linux_querystring_ssrf = "?url=http://192.168.1.1";
%>
<p>正常调用: </p>
<p>curl '<a href="<%=request.getRequestURL()+normal_querystring%>" target="_blank"><%=request.getRequestURL()+normal_querystring%></a>'</p>
<br>

<p>不正常调用 - file 协议读取目录: </p>
<p>curl '<a href="<%=request.getRequestURL()+linux_querystring_dir%>" target="_blank"><%=request.getRequestURL()+linux_querystring_dir%></a>'</p>

<p>不正常调用 - file 协议读取文件: </p>
<p>curl '<a href="<%=request.getRequestURL()+linux_querystring_file%>" target="_blank"><%=request.getRequestURL()+linux_querystring_file%></a>'</p>

<p>不正常调用 - http 协议 SSRF: </p>
<p>curl '<a href="<%=request.getRequestURL()+linux_querystring_ssrf%>" target="_blank"><%=request.getRequestURL()+linux_querystring_ssrf%></a>'</p>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String url = request.getParameter("url");
    if(url != null) {
%>
<c:import url="<%= url %>" />   
<% } %>
