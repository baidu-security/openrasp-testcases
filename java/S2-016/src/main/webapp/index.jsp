<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>
      S2-016 漏洞测试环境
    </title>
  </head>
  <body>
    <h1>
      S2-016 漏洞测试环境
    </h1>
    <p>
      漏洞说明:
      <a href="https://struts.apache.org/docs/s2-016.html">
        https://struts.apache.org/docs/s2-016.html
      </a>
    </p>
    <p>
      若要测试漏洞，请使用工具攻击 <a href="default.action"><%=request.getRequestURL()%>default.action</a>
    </p>
  </body>
</html>
