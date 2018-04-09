<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Fastjson 反序列化漏洞测试</title>
  </head>
  <body>
    <p>由于我们使用 com.sun.org.apache.xalan.internal.xsltc.trax.TemplatesImpl 作为 payload，在某些 JDK 下面，反序列化可能不会成功。</p>
    <p>点击这个链接进行测试，会直接尝试命令执行 <a href="/fastjson/fastjson">/fastjson/fastjson</a> </p>
  </body>
</html>
