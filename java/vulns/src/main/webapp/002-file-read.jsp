<%@page import="java.io.FileInputStream" %>
<%@ page import="java.io.RandomAccessFile" %>
<%@page contentType="text/html; charset=UTF-8" %>
<%
    String normal_querystring = "?file=example.pdf";
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
<p>curl '<a href="<%=request.getRequestURL()+normal_querystring%>"
            target="_blank"><%=request.getRequestURL() + normal_querystring%>
</a>'</p>

<p>不正常调用: </p>
<p>curl '<a href="<%=request.getRequestURL()+linux_querystring%>"
            target="_blank"><%=request.getRequestURL() + linux_querystring%>
</a>'</p>

<p>不正常调用: </p>
<p>curl '<a href="<%=request.getRequestURL()+windows_querystring%>"
            target="_blank"><%=request.getRequestURL() + windows_querystring%>
</a>'</p>

<br>
<p>读取内容</p>
<pre><%
    String reportName = request.getParameter("file");
    String isRandom = request.getParameter("random");
    if (reportName != null) {
        try {
            String fileName;
            String serverInfo = application.getServerInfo();
            if (serverInfo != null && serverInfo.toLowerCase().contains("weblogic")) {
                fileName = application.getResource("/").getPath() + "/reports/" + reportName;
            } else {
                fileName = application.getRealPath("/") + "/reports/" + reportName;
            }
            if ("true".equals(isRandom)) {
                RandomAccessFile randomAccessFile = new RandomAccessFile(fileName, "rw");
                String outputStr = "";

                byte[] outputByte = new byte[4096];
                while (randomAccessFile.read(outputByte, 0, 4096) != -1) {
                    String s = new String(outputByte, "UTF-8");
                    outputStr += s;
                }

                randomAccessFile.close();
                out.print(outputStr);
            }else{
                FileInputStream fileIn = new FileInputStream(fileName);
                String outputStr = "";

                byte[] outputByte = new byte[4096];
                while (fileIn.read(outputByte, 0, 4096) != -1) {
                    String s = new String(outputByte, "UTF-8");
                    outputStr += s;
                }

                fileIn.close();
                out.print(outputStr);
            }
        } catch (Exception e) {
            out.print(e);
        }
    }
%></pre>
</body>
</html>
