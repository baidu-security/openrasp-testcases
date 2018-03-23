<%@ page import="org.apache.commons.httpclient.HttpClient" %>
<%@ page import="org.apache.commons.httpclient.methods.GetMethod" %>

<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>011 - SSRF - commons.httpclient 方式</title>
</head>
<body>
<p>commons-httpclient 调用方式: </p>
<pre>curl '<%=request.getRequestURL()%>?url=http://0x7f001'</pre>
<pre>说明: 参数 url 为请求的 url</pre>
<%
    String urlString = request.getParameter("url");
    if (urlString != null) {
        try {
            HttpClient httpClient = new HttpClient();
            GetMethod getMethod = new GetMethod(urlString);
            httpClient.executeMethod(getMethod);

            String charSet = getMethod.getResponseCharSet();
            byte[] responseBody = getMethod.getResponseBody();
            out.println("response:\r\n" + new String(responseBody, charSet));
        } catch (Exception e) {
            out.print(e);
        }
    }
%>
</body>
</html>
