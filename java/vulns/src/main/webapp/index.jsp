<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>OpenRASP 官方测试用例集合</title>
  <link rel="stylesheet" href="assets/css/bootstrap.min.css" media="screen">
  <script src="assets/js/angular.min.js" charset="utf-8"></script>
  <style media="screen">
    thead tr td {
      background-color: #f1f1f1
    }
  </style>
</head>

<body>
<div ng-app="myapp" ng-controller="main">
  <div class="container" id="main">
    <div class="row">
      <div class="col-xs-12 col-sm-8 col-sm-offset-2">
        <h3 class="text-center">OpenRASP 官方测试用例集合</h3>
        <br/>
        <table class="table table-striped">
          <thead>
          <tr>
            <td>测试用例</td>
            <td>用例路径</td>
          </tr>
          </thead>
          <tbody>
          <tr ng-repeat="a in testcases">
            <td>{{a.name}}</td>
            <td><a target="_blank" ng-href="{{a.path}}">{{a.path}}</a></td>
          </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
    var app = angular.module('myapp', []);

    app.controller('main', ['$scope', '$http',
        function ($scope, $http) {

            $scope.testcases = [
                {"name": "001 - 使用 File.listFiles 遍历目录（有路径拼接）", "path": '001-dir-1.jsp'},
                {"name": "002 - 任意文件下载/读取漏洞（路径拼接）", "path": '002-file-read.jsp'},
                {"name": "004 - 命令执行后门 - 无回显", "path": '004-command-1.jsp'},
                {"name": "004 - 命令执行后门 - 带回显", "path": '004-command-2.jsp'},
                {"name": "005 - 任意文件写入", "path": '005-file-write.jsp'},
                {"name": "006 - 检查响应里是否有身份证、银行卡等敏感信息泄露", "path": '006-leak-1.jsp'},
                {"name": "007 - 通过XXE读取系统文件", "path": '007-xxe.jsp'},
                {"name": "007 - 通过XXE读取系统文件-dom4j", "path": '007-xxe-dom4j.jsp'},
                {"name": "007 - 通过XXE读取系统文件-jdom", "path": '007-xxe-jdom.jsp'},
                {"name": "007 - 通过XXE读取系统文件-sax", "path": '007-xxe-sax.jsp'},
                {"name": "007 - 通过XXE读取系统文件-stax", "path": '007-xxe-stax.jsp'},
                {"name": "008 - 任意文件上传漏洞 - commons.io 方式", "path": '008-file-upload.jsp'},
                {"name": "009 - Transformer 反序列化", "path": '009-deserialize.jsp'},
                {"name": "010 - JSTL import 任意文件包含/SSRF", "path": '010-jstl-import.jsp'},
                {"name": "011 - SSRF - commons.httpclient 方式", "path": '011-ssrf-commons-httpclient.jsp'},
                {"name": "011 - SSRF - HttpClient 方式", "path": '011-ssrf-httpclient.jsp'},
                {"name": "011 - SSRF - URL.openConnection 方式", "path": '011-ssrf-urlconnection.jsp'},
                {"name": "011 - SSRF - OKHTTP 方式", "path": '011-ssrf-okhttp.jsp'},
                {"name": "011 - SSRF - OKHTTP3 方式", "path": '011-ssrf-okhttp3.jsp'},
                {"name": "012 - SQLi - MySQL JDBC executeQuery 方式", "path": '012-jdbc-mysql.jsp'},
                {"name": "012 - SQLi - MySQL8 JDBC executeQuery 方式", "path": '012-jdbc-mysql8.jsp'},
                {"name": "012 - SQLi - HSQLDB JDBC executeQuery 方式", "path": '012-jdbc-hsqldb.jsp'},
                {"name": "012 - SQLi - Mybatis Mysql JDBC", "path": '012-mybatis.jsp'},
                {"name": "012 - SQLi - Hibernate Mysql JDBC", "path": '012-hibernate.jsp'},
                {"name": "013 - SQLi - JDBC multipart 请求格式", "path": '013-multipart-mysql.jsp'},
                {"name": "017 - XSS - 017 - 反射型XSS", "path": '017-xss.jsp'},
                {"name": "018 - loadlibrary", "path": '018-loadlibrary.jsp'},
                {"name": "019 - 任意文件删除", "path": '019-file-delete.jsp'},
                {"name": "020 - RandomAccessFile 文件读写", "path": '020-random-file.jsp'},
                {"name": "021 - NIO 文件操作", "path": '021-nio-file.jsp'},
            ]
        }
    ]);
</script>

</body>
<!-- design, implemented by c0debreak -->
</html>
