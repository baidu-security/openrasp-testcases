<%@ page import="org.apache.http.HttpResponse" %>
<%@ page import="org.apache.http.client.HttpClient" %>
<%@ page import="org.apache.http.client.methods.HttpGet" %>
<%@ page import="org.apache.http.impl.client.HttpClients" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.util.Map" %>

<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>011 - SSRF - HttpClient 方式</title>
</head>
<body>
<p>HttpClient 调用方式: </p>
<pre><%=request.getRequestURL()%>?url=http://0x7f.0x0.0x0.0x1:8080</pre>
<pre>说明: 参数 url 为请求的 url</pre>
<%

    String urlString = request.getParameter("url");
    if (urlString != null) {
        try {
            StringBuffer resultBuffer = null;
            HttpClient client = HttpClients.createDefault();
            BufferedReader br = null;
            HttpGet httpGet = new HttpGet(urlString);
            HttpResponse res = client.execute(httpGet);
            // 读取服务器响应数据
            br = new BufferedReader(new InputStreamReader(res.getEntity().getContent()));
            String temp;
            resultBuffer = new StringBuffer();
            while ((temp = br.readLine()) != null) {
                resultBuffer.append(temp);
            }
            out.println(resultBuffer);
        } catch (Exception e) {
            out.println(e.getMessage());
        }
    }

%>
</body>
</html>
