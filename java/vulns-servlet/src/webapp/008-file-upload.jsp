<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
	<meta charset="UTF-8" />
	<title>008 - 任意文件上传漏洞 - commons.io 方式</title>
</head>
<body>
<%
	String url = new String(request.getRequestURL());
	String baseUrl = url.substring(0, url.lastIndexOf("/"));
%>
	<h1>008 - 任意文件上传漏洞 - commons.io 方式</h1>
	<p>使用java最常用的文件上传处理库，struts、spring都用这个</p>
	<p>请求方式:</p>
	<pre>curl '<%=baseUrl+"/fileUpload"%>' -F 'file=@/path/to/a.jsp'</pre>
	<p>目前，官方插件只检查脚本文件上传的情况，比如 aaa.php, bbb.jsp，其他后缀不会拦截</p>

	<form method="post" enctype="multipart/form-data" action="<%=baseUrl+"/fileUpload"%>">
		<input type="file" name="file">
		<input type="submit">
	</form>
</body>
</html>
