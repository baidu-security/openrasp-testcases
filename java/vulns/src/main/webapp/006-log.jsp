<%@ page import="java.io.*" %>
<%@ page import="org.apache.log4j.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<html>
<head>	
	<meta charset="UTF-8"/>
	<title>006 - Log4j 打印敏感信息到日志文件</title>
</head>
<body>
	<h1>006 - 日志中包含敏感信息</h1>
	<p>本case展示没有打码的敏感信息，包括身份证和银行卡两种，e.g</p>
	<pre>IdCard=42050319820815801X DepositCard=6222020903001483077 Transaction=1999.22</pre>
	<br>
	<p>目前，OpenRASP 暂时不支持这个类型的安全检测，后面会添加上~</p>
 <%
 try {
 	Logger log = Logger.getLogger("com.mobilefish.demo.test");
	if (log != null) {
 		log.info("身份证 620503198801272195\n");
 		log.warn("IdCard=42050319820815801X DepositCard=6222020903001483077 Transaction=1999.22\n");
	}
} catch (Exception e) {
    out.print(e);
}
 %>
</body>
</html>
