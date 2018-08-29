<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>OpenRASP 官方测试用例集合</title>
  <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" media="screen">
  <script src="https://cdn.bootcss.com/angular.js/1.6.3/angular.min.js" charset="utf-8"></script>
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
      function($scope, $http) {

        $scope.testcases = [
        	{"name": "001 - 使用 File.listFiles 遍历目录（有路径拼接）", "path": '001-dir-1.jsp'},
			{"name": "001 - 使用 File.listFiles 遍历目录（无路径拼接）", "path": '001-dir-2.jsp'},
			{"name": "002 - 任意文件下载/读取漏洞（路径拼接）", "path": '002-file-read.jsp'},
			{"name": "004 - 命令执行后门 - 无回显", "path": '004-command-1.jsp'},
			{"name": "004 - 命令执行后门 - 带回显", "path": '004-command-2.jsp'},
			{"name": "005 - 任意文件写入", "path": '005-file-write.jsp'},
			{"name": "006 - Log4j 打印敏感信息到日志文件", "path": '006-log.jsp'},
			{"name": "007 - 通过XXE读取系统文件", "path": '007-xxe.jsp'},
			{"name": "008 - 任意文件上传漏洞 - commons.io 方式", "path": '008-file-upload.jsp'},
			{"name": "009 - Transformer 反序列化", "path": '009-deserialize.jsp'},
			{"name": "010 - JSTL import 任意文件包含/SSRF", "path": '010-jstl-import.jsp'},
			{"name": "011 - SSRF - commons.httpclient 方式", "path": '011-ssrf-commons-httpclient.jsp'},
			{"name": "011 - SSRF - HttpClient 方式", "path": '011-ssrf-httpclient.jsp'},
			{"name": "011 - SSRF - URL.openConnection 方式", "path": '011-ssrf-urlconnection.jsp'},
			{"name": "012 - SQLi - MySQL JDBC executeQuery 方式", "path": '012-jdbc-mysql.jsp'},
			{"name": "013 - SQLi - JDBC multipart 请求格式", "path": '013-multipart-mysql.jsp'}
        ]


      }
    ]);
  </script>

</body>
<!-- design, implemented by c0debreak -->
</html>
