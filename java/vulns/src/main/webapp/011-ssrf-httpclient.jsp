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
<%
    String linux_querystring = "?url=http://127.0.0.1.xip.io";
    String redirect_string = "?url=http://uee.me/cFas3";
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
            String output = resultBuffer.toString();
            output = output.replace("<", "&lt;");
            output = output.replace(">", "&gt;");
            out.println(output);
        } catch (Exception e) {
            out.print(e);
        }
    }

%>
<p>HttpClient 调用方式: </p>
<p>curl '<a href="<%=request.getRequestURL()+linux_querystring%>" target="_blank"><%=request.getRequestURL()+linux_querystring%></a>'</p>
<pre>说明: 参数 url 为请求的 url</pre>

<p>重定向:</p>
<p>curl '<a href="<%=request.getRequestURL()+redirect_string%>" target="_blank"><%=request.getRequestURL()+redirect_string%></a>'</p>
<pre>说明: 此链接源自外网, 若没有跳转，请自行获取能够使用301/302跳转到内网的外网url进行测试</pre>
</body>
</html>
