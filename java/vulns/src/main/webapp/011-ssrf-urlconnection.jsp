<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.URLConnection" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.InputStreamReader" %>

<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>011 - SSRF - URL.openConnection 方式</title>
</head>
<body>
<%
    String linux_querystring = "?url=http://127.0.0.1.xip.io";
    String redirect_string = "?url=http://uee.me/cFas3";
    String urlString = request.getParameter("url");
    if (urlString != null) {
        try {
            URL url = new URL(urlString);
            URLConnection urlConnection = url.openConnection();
            urlConnection.connect();
            InputStream inputStream = urlConnection.getInputStream();
            BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));
            String line = reader.readLine();
            String content = "";
            while (line != null) {
                content += (line + "\n");
                line = reader.readLine();
            }
            content = content.replace("<", "&lt;");
            content = content.replace(">", "&gt;");
            out.println(content);
        } catch (Exception e) {
            out.print(e);
        }
    }
%>
<p>jdk 中的 URL.openConnection 调用方式: </p>
<p>curl '<a href="<%=request.getRequestURL()+linux_querystring%>" target="_blank"><%=request.getRequestURL()+linux_querystring%></a>'</p>
<pre>说明: 参数 url 为请求的 url</pre>

<p>重定向:</p>
<p>curl '<a href="<%=request.getRequestURL()+redirect_string%>" target="_blank"><%=request.getRequestURL()+redirect_string%></a>'</p>
<pre>说明: 此链接源自外网, 若没有跳转，请自行获取能够使用301/302跳转到内网的外网url进行测试</pre>

</body>
</html>
