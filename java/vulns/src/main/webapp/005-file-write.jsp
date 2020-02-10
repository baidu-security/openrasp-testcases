<%@page import="java.io.*" %>
<%@page contentType="text/html; charset=UTF-8" %>

<html>
<head>	
	<meta charset="UTF-8"/>
	<title>005 任意文件写入</title>
</head>
<body>
<%
String normal_querystring = "?filename=123.txt&amp;filedata=some-report-data";
String linux_querystring = "?filename=reports/../123.jsp&amp;filedata=some-webshell-data";
String bytes = request.getParameter("filedata");
String fname = request.getParameter("filename");
if (fname == null || bytes == null) {
%>
<p>注意: 由于可能产生误报，所以目前官方插件不会拦截这种使用 FileOutputStream 写文件的后门，我们会尽快解决</p>
<%
} 
else {
	try {
		String path;
		String serverInfo = application.getServerInfo();
		if (serverInfo != null && serverInfo.toLowerCase().contains("weblogic")) {
			path = application.getResource("/").getPath() + "/" + fname;
		} else {
			path = application.getRealPath("/") + "/" + fname;
		}
	   	FileOutputStream os = new FileOutputStream(path);
		PrintWriter writer = new PrintWriter(os);
		writer.print(bytes);
		writer.close();
		out.println("==>" + path);
	} catch (Exception e) {
        out.print(e);
	}
}
%>
<p>正常调用</p>
<p>curl '<a href="<%=request.getRequestURL()+normal_querystring%>" target="_blank"><%=request.getRequestURL()+normal_querystring%></a>'</p>
<p>不正常调用</p>
<p>curl '<a href="<%=request.getRequestURL()+linux_querystring%>" target="_blank"><%=request.getRequestURL()+linux_querystring%></a>'</p>
</body>
</html>
