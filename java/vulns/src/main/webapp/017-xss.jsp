<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<%@page import="net.sf.json.*" %>
    
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>	
    <meta charset="UTF-8"/>
    <title>017 - 反射型XSS</title>
</head>
<body>

    <h1>017 - 反射型XSS</h1>

<%
String normal_querystring = "?input=reports";
String xss_querystring = "?input=%3cscript%3ealert(1)%3c%2fscript%3e";

String input = request.getParameter("input");

if (input != null) {
    try {
        out.println(input);
    } catch (Exception e) {
        out.print("<pre>");
        e.printStackTrace(response.getWriter());
        out.print("</pre>");
    }
} 
else {
%>
<p>正常输入: </p>
<p>curl '<a href="<%=request.getRequestURI()+normal_querystring%>" target="_blank"><%=request.getRequestURI() + normal_querystring%></a>'</p>

<p>不正常输入: </p>
<p>curl '<a href="<%=request.getRequestURI()+xss_querystring%>" target="_blank"><%=request.getRequestURI() + xss_querystring%></a>'</p>


<%
}
%>
</body>
</html>
