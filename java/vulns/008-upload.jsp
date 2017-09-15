<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="org.apache.commons.fileupload.FileUploadException" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>

<%@ page import="java.util.List" %>
<html>
<head>
	<meta charset="UTF-8" />
	<title>008 Upload File, show content</title>
</head>
<body>
<%
String method = request.getMethod();
if ("POST".equals(method)) {
try {
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	if (isMultipart) {
		DiskFileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		List<FileItem> items = upload.parseRequest(request);
		for (FileItem item: items) { 
			String content = new String(item.get());
		%>
			<div>
				<p>file name: <%= item.getName() %></p>
				<div><%= content %></div>
			</div>
		<%}
	}
} catch (Exception e) {
    if (e.getClass().getName().equals("com.fuxi.javaagent.exception.SecurityException")) {
        response.sendError(400, "Request blocked by OpenRasp");
    }else {	
        out.print(e);
    }
}
} else {
%>
	<p>请求方式:</p>
	<pre>curl -XPOST -F 'file=@/path/to/file' '<%= request.getRequestURL()%>'</pre>
<%}
%>
</body>
</html>
