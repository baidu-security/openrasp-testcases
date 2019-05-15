<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String url = new String(request.getRequestURL());
    String baseUrl = url.substring(0, url.lastIndexOf("/"));
%>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>013 - SQL 注入测试 - JDBC multipart 请求方式</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
</head>
<body>
  <div class="container-fluid" style="margin-top: 50px;">
    <div class="row">
      <div class="col-xs-8 col-xs-offset-2">
        <h4>SQL注入 - JDBC + multipart 请求格式</h4>
        <p>第一步: 请以mysql root账号执行下面的语句创建表</p>
        <pre>DROP DATABASE IF EXISTS test;
CREATE DATABASE test;         
grant all privileges on test.* to 'test'@'%' identified by 'test';
grant all privileges on test.* to 'test'@'localhost' identified by 'test';
CREATE TABLE test.vuln (id INT, name text);
INSERT INTO test.vuln values (0, "openrasp");
INSERT INTO test.vuln values (1, "rocks");
</pre>
      </div>
    </div>
    <div class="row">
      <div class="col-xs-8 col-xs-offset-2">
        <p>第二步: 尝试发起SQL注入攻击 - 为了保证性能，默认只会检测长度超过15的语句</p>
        <form action="<%= baseUrl+"/multipart"%>" method="post" enctype="multipart/form-data">
          <div class="form-group">
             <label>查询条件</label>
             <input class="form-control" name="id" value="1" autofocus>
          </div>
          <button type="submit" class="btn btn-primary">提交查询</button> 
        </form>
      </div>
    </div>
  </div>
</body>
</html>
