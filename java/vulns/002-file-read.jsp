<%@page import="java.io.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<html>
<head>	
	<meta charset="UTF-8"/>
	<title>002 任意文件下载/读取漏洞</title>
</head>
<body>
<%
String reportName = request.getParameter("file");;
if (reportName != null) {
	try {
	    String fileName = application.getRealPath("/") + "/reports/" + reportName;

	    FileInputStream fileIn = new FileInputStream(fileName);
	    OutputStream outStream = response.getOutputStream();

	    byte[] outputByte = new byte[4096];
	    while(fileIn.read(outputByte, 0, 4096) != -1) {
	    	outStream.write(outputByte, 0, 4096);
	    }

	    fileIn.close();
	} catch (Exception e) {
        if (e.getClass().getName().equals("com.fuxi.javaagent.exception.SecurityException")) {
            response.sendError(400, "Request blocked by OpenRasp");
        }else {	
            out.print(e);
        }
	}
} else {
%>
<p>正常调用: </p>
<pre>curl <%=request.getRequestURL()%>?file=report.pdf</pre>
<p>不正常调用: </p>
<pre>curl <%=request.getRequestURL()%>?file=../../../../../../../../../../../../../../../etc/passwd</pre>
<%
	}
%>
</body>
</html>
