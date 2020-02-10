<%@ page contentType="text/html; charset=UTF-8" %>

<html>
<head>
    <meta charset="UTF-8"/>
    <title>006 - 检查响应里是否有身份证、银行卡等敏感信息泄露</title>
</head>
<body>
<h1>006 - 检查响应里是否有身份证、银行卡等敏感信息泄露</h1>

<p>本case展示没有打码的敏感信息，包括身份证和银行卡两种，e.g</p>
<p>身份证=42050319820815801X</p>
<p>银行卡=4539 6199 2101 4428</p>
<p>手机号=13011223344</p>
<p>订单金额=1999.22</p>

<br>
<p>OpenRASP 在 v1.3 开始增加了这个检测，如果有其他信息需要检测，请自行修改插件</p>
</body>
</html>
