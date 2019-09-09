<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<%@page import="net.sf.json.*" %>
    
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>	
    <meta charset="UTF-8"/>
    <title>017 - 反射型XSS - chunked</title>
</head>
<body>

    <h1>017 - 反射型XSS - chunked</h1>

<%
out.println("chunked started");
out.flush();
String normal_querystring = "?input=reports";
String xss_querystring = "?input=%3cscript%3ealert(1);alert(1);alert(1);alert(1);alert(1);alert(1);alert(1);alert(1);alert(1);alert(1);alert(1);%3c%2fscript%3e";

String input = request.getParameter("input");

if (input != null) {
    try {
        out.println(input);
    } catch (Exception e) {
        out.print(e);
    }
} 
else {
%>
<p>正常输入: </p>
<p>curl '<a href="<%=request.getRequestURL()+normal_querystring%>" target="_blank"><%=request.getRequestURL() + normal_querystring%></a>'</p>

<p>不正常输入: </p>
<p>curl '<a href="<%=request.getRequestURL()+xss_querystring%>" target="_blank"><%=request.getRequestURL() + xss_querystring%></a>'</p>


<%
}
%>
</body>
</html>
