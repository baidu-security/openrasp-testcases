<%@page import="java.io.*" %>
<html>
<head>	
	<meta charset="UTF-8"/>
	<title>004-1 命令执行，无回显</title>
</head>
<body>
<%
String cmd = request.getParameter("cmd");
if (cmd != null) {
try {
	Runtime.getRuntime().exec(cmd);
} catch (Exception e) {
    if (e.getClass().getName().equals("com.fuxi.javaagent.exception.SecurityException")) {
        response.sendError(400, "Request blocked by OpenRasp");
    }else {	
        out.print(e);
    }
}
}
%>
</body>
</html>
