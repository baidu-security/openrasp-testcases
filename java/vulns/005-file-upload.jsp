<%@page import="java.io.*" %>
<%@page contentType="text/html; charset=UTF-8" %>

<html>
<head>	
	<meta charset="UTF-8"/>
	<title>005 任意文件上传</title>
</head>
<body>
<%
String bytes = request.getParameter("filedata");
String fname = request.getParameter("filename");
if (bytes == null) {
%>
<p>正常调用</p>
<pre>curl <%=request.getRequestURL()%> -d 'filename=123.txt&amp;filedata=some report data'</pre>
<p>不正常调用</p>
<pre>curl <%=request.getRequestURL()%> -d 'filename=123.jsp&amp;filedata=some webshell data'</pre>
<%
} 
else {
	try {
		String path = request.getRealPath("/") + "/" + fname;
	   	FileOutputStream os = new FileOutputStream(path);
		PrintWriter writer = new PrintWriter(os);
		writer.print(bytes);
		writer.close();
		out.println("==>" + path);
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
