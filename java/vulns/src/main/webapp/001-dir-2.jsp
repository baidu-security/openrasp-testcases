<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>	
	<meta charset="UTF-8"/>
	<title>001 任意目录读取 - 2</title>
</head>
<body>
	<h1>001 - 使用 File.listFiles 遍历目录（无路径拼接）</h1>
<%
String normal_querystring = "?dirname=reports";
String linux_querystring = "?dirname=/var/log/";
String windows_querystring = "?dirname=c:/";
String dirname = request.getParameter("dirname");
if (dirname != null) {
	try {
		File folder = new File(dirname);
		if (folder.isDirectory()) {
			File[] listOfFiles = folder.listFiles();
			for (File file : listOfFiles) {
			    out.println(file.getName());
			}
		}
	} catch (Exception e) {
	   out.print(e);
	}
} else {
%>
<p>正常调用: </p>
<p>curl '<a href="<%=request.getRequestURL()+normal_querystring%>" target="_blank"><%=request.getRequestURL()+normal_querystring%></a>'</p>

<p>不正常调用 - Linux: </p>
<p>curl '<a href="<%=request.getRequestURL()+linux_querystring%>" target="_blank"><%=request.getRequestURL()+linux_querystring%></a>'</p>

<p>不正常调用 - Windows: </p>
<p>curl '<a href="<%=request.getRequestURL()+windows_querystring%>" target="_blank"><%=request.getRequestURL()+windows_querystring%></a>'</p>

<%
	}
%>
</body>
</html>
