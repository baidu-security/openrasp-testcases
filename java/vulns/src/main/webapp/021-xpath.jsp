<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileInputStream" %>

<%@ page import="javax.xml.parsers.DocumentBuilder" %>
<%@ page import="javax.xml.parsers.DocumentBuilderFactory" %>
<%@ page import="javax.xml.xpath.XPath" %>
<%@ page import="javax.xml.xpath.XPathConstants" %>
<%@ page import="javax.xml.xpath.XPathFactory" %>

<%@ page import="org.w3c.dom.Document" %>
<%@ page import="org.w3c.dom.Node" %>

<html>
<head>
    <meta charset="UTF-8"/>
    <title>021 - XPATH注入</title>
</head>
<body>
<%
    


    String xpath_query = "?xpath=(/openrasp/*[id=1])[1]";
    String expression = request.getParameter("xpath");
    if (expression != null) {
        try {
            DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
            dbf.setValidating(false);
            DocumentBuilder db = dbf.newDocumentBuilder();

            String path;
			String serverInfo = application.getServerInfo();
			if (serverInfo != null && serverInfo.toLowerCase().contains("weblogic")) {
				path = application.getResource("/").getPath() + "/reports/test.xml";
			} else {
				path = application.getRealPath("/") + "/reports/test.xml";
			}

            Document doc = db.parse(new FileInputStream(new File(path)));

            XPathFactory factory = XPathFactory.newInstance();

            XPath xpath = factory.newXPath();

            Node node = (Node) xpath.evaluate(expression, doc, XPathConstants.NODE);

            String output = node.getNodeName();
            output = output.replace("<", "&lt;");
            output = output.replace(">", "&gt;");
            out.println(output);
        } catch (Exception e) {
            out.print(e);
        }
    }

%>
<p>XPATH 查询: </p>
<p>curl '<a href="<%=request.getRequestURL()+xpath_query%>" target="_blank"><%=request.getRequestURL()+xpath_query%></a>'</p>
<pre>说明: 参数 xpath 为查询使用的xpath</pre>

</body>
</html>
