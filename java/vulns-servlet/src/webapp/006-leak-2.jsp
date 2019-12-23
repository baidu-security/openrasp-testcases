<%@ page contentType="text/html; charset=UTF-8" %>

<html>
<head>
    <meta charset="UTF-8"/>
    <title>006 - 检查 Log4j 打印的日志里是否有敏感信息</title>
</head>
<body>
<h1>006 - 检查 Log4j 打印的日志里是否有敏感信息</h1>
<p>本case展示没有打码的敏感信息，包括身份证和银行卡两种，e.g</p>
<pre>IdCard=42050319820815801X DepositCard=6225750103374126 Transaction=1999.22</pre>
<br>
<p>目前，OpenRASP 暂时不支持这个类型的安全检测，后面会添加上~</p>
</body>
</html>
