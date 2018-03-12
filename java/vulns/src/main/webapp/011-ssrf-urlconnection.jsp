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
<p>jdk 中的 URL.openConnection 调用方式: </p>
<pre><%=request.getRequestURL()%>?url=http://0x7f.0x0.0x0.0x1:8080</pre>
<pre>说明: 参数 url 为请求的 url</pre>
<%
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
            out.println(content);
        } catch (Exception e) {
            out.println(e.getMessage());
        }
    }
%>
</body>
</html>
