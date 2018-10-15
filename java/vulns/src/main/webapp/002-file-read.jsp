<%@page import="java.io.*" %>
<%@page contentType="text/html; charset=UTF-8" %>
<%
String normal_querystring = "?file=report.pdf";
String linux_querystring = "?file=../../../../../../../../../../../../../../../etc/passwd";
String windows_querystring = "?file=../../../conf/tomcat-users.xml";
%>

<html>
<head>	
	<meta charset="UTF-8"/>
	<title>002 任意文件下载/读取漏洞</title>
</head>
<body>
	<h1>002 - 任意文件下载/读取漏洞（路径拼接）</h1>
	<p>正常调用: </p>
	<p>curl '<a href="<%=request.getRequestURL()+normal_querystring%>" target="_blank"><%=request.getRequestURL()+normal_querystring%></a>'</p>
	
	<p>不正常调用: </p>
	<p>curl '<a href="<%=request.getRequestURL()+linux_querystring%>" target="_blank"><%=request.getRequestURL()+linux_querystring%></a>'</p>
	
	<p>不正常调用: </p>
	<p>curl '<a href="<%=request.getRequestURL()+windows_querystring%>" target="_blank"><%=request.getRequestURL()+windows_querystring%></a>'</p>
	
	<br>
	<p>读取内容</p>
	<pre><%
String reportName = request.getParameter("file");
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
        out.print(e);
	}
}
%></pre>
</body>
</html>
