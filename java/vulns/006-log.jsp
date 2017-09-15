<%@page import="java.io.*" %>
<%@ page import="java.util.logging.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<html>
<head>	
	<meta charset="UTF-8"/>
	<title>006 Log4j 敏感日志信息</title>
</head>
<body>
	<p>本case展示没有打码的敏感信息，包括身份证和银行卡两种</p>
	<p>日志在 logs/localhost.*</p>
 <%
 try {
 	Logger log = Logger.getLogger("com.mobilefish.demo.test");
	if (log != null) {
 		log.info("身份证 620503198801272195\n");
 		log.warn("IdCard=42050319820815801X DepositCard=6222020903001483077 Transaction=1999.22\n");
	}
} catch (Exception e) {
    if (e.getClass().getName().equals("com.fuxi.javaagent.exception.SecurityException")) {
        response.sendError(400, "Request blocked by OpenRasp");
    }else {	
        out.print(e);
    }
}
 %>
</body>
</html>
