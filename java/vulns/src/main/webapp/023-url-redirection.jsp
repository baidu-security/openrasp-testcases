<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>	
    <meta charset="UTF-8"/>
    <title>023 - URL重定向漏洞</title>
</head>
<body>

    <h1>023 - URL重定向漏洞</h1>

<%
String normal_querystring = "?url=/vulns/023-url-redirection.jsp";
String xss_querystring = "?url=https://www.baidu.com";
String url = request.getParameter("url");
if (url != null) {
    try {
        response.sendRedirect(url);
		return;
    } catch (Exception e) {
        out.print("<pre>");
        e.printStackTrace(response.getWriter());
        out.print("</pre>");
    }
} 
else {
%>
<p>正常输入: </p>
<p>curl '<a href="<%=request.getRequestURL()+normal_querystring%>" target="_blank"><%=request.getRequestURL() + normal_querystring%></a>'</p>

<p>不正常输入: </p>
<p>curl '<a href="<%=request.getRequestURL()+xss_querystring%>" target="_blank"><%=request.getRequestURL() + xss_querystring%></a>'</p>


<%
}
%>
</body>
</html>