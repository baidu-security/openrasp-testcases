<%@ page import="okhttp3.OkHttpClient" %>
<%@ page import="okhttp3.Request" %>
<%@ page import="okhttp3.Response" %>
<%--
  Created by IntelliJ IDEA.
  User: anyang
  Date: 2018/10/9
  Time: 上午10:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<h1>011-ssrf-okhttp3</h1>
<%!
    public String httpGet(String url) {
        String result = "";
        OkHttpClient client = new OkHttpClient();
        Request request = new Request.Builder().url(url).build();
        try {
            Response response = client.newCall(request).execute();
            result = response.body().string();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
%>
<%
    String linux_querystring = "?url=http://127.0.0.1.xip.io";
    String urlString = request.getParameter("url");
    if (urlString != null) {
        String result = httpGet(urlString);
        result = result.replace("<", "&lt;");
        result = result.replace(">", "&gt;");
        out.println(result);
    }
%>
<p>okhttp 调用方式: </p>
<p>curl '<a href="<%=request.getRequestURL()+linux_querystring%>" target="_blank"><%=request.getRequestURL()+linux_querystring%></a>'</p>
</body>
</html>
