<%@ page import="org.apache.commons.httpclient.HttpClient" %>
<%@ page import="org.apache.commons.httpclient.methods.GetMethod" %>

<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>011 - SSRF - commons.httpclient 方式</title>
</head>
<body>
<%
    String linux_querystring = "?url=http://127.0.0.1.xip.io";
    String redirect_string = "?url=http://uee.me/cFas3";
    String urlString = request.getParameter("url");
    if (urlString != null) {
        try {
            HttpClient httpClient = new HttpClient();
            GetMethod getMethod = new GetMethod(urlString);
            httpClient.executeMethod(getMethod);

            String charSet = getMethod.getResponseCharSet();
            byte[] responseBody = getMethod.getResponseBody();
            String output = new String(responseBody, charSet);
            output = output.replace("<", "&lt;");
            output = output.replace(">", "&gt;");
            out.println("response:\r\n" + output);
        } catch (Exception e) {
            out.print(e);
        }
    }
%>
<p>commons-httpclient 调用方式: </p>
<p>curl '<a href="<%=request.getRequestURL()+linux_querystring%>" target="_blank"><%=request.getRequestURL()+linux_querystring%></a>'</p>
<pre>说明: 参数 url 为请求的 url</pre>

</body>
</html>
