<%@ page import="com.squareup.okhttp.OkHttpClient"%>
<%@ page import="com.squareup.okhttp.Request"%>
<%@ page import="com.squareup.okhttp.Response"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="org.apache.commons.lang.exception.ExceptionUtils" %>
<%--
  Created by IntelliJ IDEA.
  User: anyang
  Date: 2018/11/26
  Time: 上午11:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<h1>011-ssrf-okhttp</h1>
<%!
    public String httpGet(String url) {
        String result = "";
        OkHttpClient client = new OkHttpClient();
        Request request = new Request.Builder().url(url).build();
        try {
            Response response = client.newCall(request).execute();
            result = response.body().string();
        } catch (Exception e) {
            String[] rootCauseStackTrace = ExceptionUtils.getRootCauseStackTrace(e);
            result = StringUtils.join(rootCauseStackTrace,System.lineSeparator());
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
        out.println("<pre>" +result+ "</pre>");
    }
%>
<p>okhttp 调用方式: </p>
<p>curl '<a href="<%=request.getRequestURI()+linux_querystring%>" target="_blank"><%=request.getRequestURI()+linux_querystring%></a>'</p>
</body>
</html>
