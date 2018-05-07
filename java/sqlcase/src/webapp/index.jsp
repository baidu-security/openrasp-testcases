<%--
  Created by IntelliJ IDEA.
  User: lxk
  Date: 6/28/17
  Time: 7:52 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>$Title$</title>
  </head>
  <body>
  <p>sql测试demo: http://ip:port/sqlcase/(mysql|mssql|oracle|pg|sqlite|db2)?customField=XXX&prepared=true </p>
  <p>执行的sql语句为： select * from testtable where customField = 'XXX' </p>
  <p>prepared参数为true使用PreparedStatement执行sql，false使用Statement执行sql </p>
  <p>数据库相关配置可以通过修改sqlcase/sqlcase.properties，具体参数如下(以mysql为例)：</p>
  <p>mysqlurl=jdbc:mysql://127.0.0.1:3306</p>
  <p>mysqldb=test</p>
  <p>mysqluser=rasp</p>
  <p>mysqlpassword=xxxxxx</p>
  <p>mysqltable=person</p>
  <p>mysqlcheckfield=last</p>
  <p>mysqlstringresult=first,last</p>
  <p>mysqlintresult=id,age</p>
  <p>备注：result仅展示String字段与int字段</p>
  </body>
</html>
