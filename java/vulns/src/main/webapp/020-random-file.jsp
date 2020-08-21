<%@page import="java.io.*" %>
<%@page contentType="text/html; charset=UTF-8" %>

<html>
<head>
	<meta charset="UTF-8"/>
	<title>020 RandomAccessFile 文件读写</title>
</head>
<body>
<%
String read_normal_querystring = "?file=example.pdf";
String read_linux_querystring = "?file=../../../../../../../../../../../../../../../etc/passwd";
String read_windows_querystring = "?file=../../../conf/tomcat-users.xml";


String normal_querystring = "?filename=123.txt&amp;filedata=some-report-data";
String linux_querystring = "?filename=reports/../123.jsp&amp;filedata=some-webshell-data";
String bytes = request.getParameter("filedata");
String fname = request.getParameter("filename");
%>
<p>正常写入文件调用</p>
<p>curl '<a href="<%=request.getRequestURL()+normal_querystring%>" target="_blank"><%=request.getRequestURL()+normal_querystring%></a>'</p>
<p>不正常写入文件调用</p>
<p>curl '<a href="<%=request.getRequestURL()+linux_querystring%>" target="_blank"><%=request.getRequestURL()+linux_querystring%></a>'</p>
<p>正常读取调用</p>
<p>curl '<a href="<%=request.getRequestURL()+read_normal_querystring%>" target="_blank"><%=request.getRequestURL()+read_normal_querystring%></a>'</p>

<p>不正常读取调用 - Linux</p>
<p>curl '<a href="<%=request.getRequestURL()+read_linux_querystring%>" target="_blank"><%=request.getRequestURL()+read_linux_querystring%></a>'</p>

<p>不正常读取调用 - Windows</p>
<p>curl '<a href="<%=request.getRequestURL()+read_windows_querystring%>" target="_blank"><%=request.getRequestURL()+read_windows_querystring%></a>'</p>

<%
if (fname == null || bytes == null) {
    String reportName = request.getParameter("file");
    if (reportName != null) {
        try {
            String fileName;
            String serverInfo = application.getServerInfo();
            if (serverInfo != null && serverInfo.toLowerCase().contains("weblogic")) {
                fileName = application.getResource("/").getPath() + "/reports/" + reportName;
            } else {
                fileName = application.getRealPath("/") + "/reports/" + reportName;
            }

            RandomAccessFile random = new RandomAccessFile(fileName, "r");
            String outputStr = "";

            byte[] outputByte = new byte[4096];
            while(random.read(outputByte, 0, 4096) != -1) {
                String s = new String(outputByte, "UTF-8");
                outputStr += s;
            }
            random.close();
            out.print(outputStr);
            out.flush();
        } catch (Exception e) {
            out.print(e);
        }
    }
%>
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

        RandomAccessFile random = new RandomAccessFile(path, "rw");
        random.writeUTF(bytes);
        random.close();
        out.println("==>" + path);
        out.flush();
	} catch (Exception e) {
        out.print(e);
	}
}
%>

</body>
</html>
