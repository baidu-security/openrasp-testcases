<%@page import="java.io.*" %>
<%@page contentType="text/html; charset=UTF-8" %>

<html>
<head>	
	<meta charset="UTF-8"/>
	<title>019 任意文件删除</title>
</head>
<body>
<h1>019 - 任意文件删除</h1>
<%
String normal_querystring = "?filename=testfile.txt";
String linux_querystring = "?filename=reports/../testfile.txt";
String fname = request.getParameter("filename");
if (fname != null) {
	String path;
	String serverInfo = application.getServerInfo();
	if (serverInfo != null && serverInfo.toLowerCase().contains("weblogic")) {
		path = application.getResource("/").getPath() + "/" + fname;
	} else {
		path = application.getRealPath("/") + "/" + fname;
	}

	try {
	   	FileOutputStream os = new FileOutputStream("openrasp.test");
		PrintWriter writer = new PrintWriter(os);
		writer.close();
		File f = new File("openrasp.test");
		f.renameTo(new File(path));
		out.println("文件已创建:" + path + "\n<br/>");
	} catch (Exception e) {
        out.print(e);
	}

	try{
		File file = new File(path);
		if(file.delete()){
			out.println( "文件 " + file.getName() + " 删除成功！" + "\n<br/>");
		}else{
			out.println("文件删除失败！");
		}
	}catch(Exception e){
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
