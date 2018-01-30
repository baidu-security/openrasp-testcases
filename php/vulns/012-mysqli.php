<?php
   $server = isset($_GET["server"]) ? $_GET['server']: 'localhost';
   $user   = isset($_GET["user"])   ? $_GET['user']  : 'test';
   $pass   = isset($_GET["pass"])   ? $_GET['pass']  : 'test';
   $db     = isset($_GET["db"])     ? $_GET['db']    : 'test';
   $id     = isset($_GET['id'])     ? $_GET['id']    : '0 and 1=2 union select user(), 1#';

   function query($id)
   {
   		global $server, $user, $pass, $db;

		$data = array();
	    $conn = new mysqli($server, $user, $pass, $db);
	   	if ($conn->connect_error) {
	      echo "Connection failed: " . $conn->connect_error;
	      return;
	   	}

	   	$sql    = "SELECT id, name FROM vuln WHERE id = " . $id;
	   	$result = $conn->query($sql);

	   	if ($result->num_rows > 0) {
	      while($row = $result->fetch_assoc()) {
	      	 $data[] = array("id" => $row["id"], "name" => $row["name"]);
	      }
	   } else {
	      echo "0 results";
	   }
	   $conn->close();

	   return $data;
   }
?>

<html>
<head>
    <meta charset="UTF-8"/>
    <title>SQL 注入测试</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
</head>
<body>
	<div class="container-fluid" style="margin-top: 50px;">
		<div class="row">
			<div class="col-xs-8 col-xs-offset-2">
				<h4>SQL注入 - mysql_query 方式</h4>
				<p>第一步: 请以mysql root账号执行下面的语句创建表</p>
				<pre>DROP DATABASE IF EXISTS test;
CREATE DATABASE test;					
grant all privileges on test.* to 'test'@'%'' identified by 'test';
CREATE TABLE test.vuln (id INT, name text);
INSERT INTO test.vuln values (0, "openrasp");
INSERT INTO test.vuln values (1, "rocks");
</pre>
			</div>
		</div>

		<div class="row">
			<div class="col-xs-8 col-xs-offset-2">
				<p>第二步: 尝试发起SQL注入攻击</p>
				<form action="<?= $_SERVER['PHP_SELF'] ?>" method="get">
					<div class="form-group">
					   <label>服务器地址</label>
					   <input class="form-control" name="server" value="<?= $server ?>">
					</div>
					<div class="form-group">
					   <label>查询条件</label>
					   <input class="form-control" name="id" value="<?= $id ?>" autofocus>
					</div>				 

					<button type="submit" class="btn btn-primary">提交查询</button>	
				</form>
			</div>
		</div>

		<div class="row">
			<div class="col-xs-8 col-xs-offset-2">
				<p>第三步: 检查注入结果</p>
				<?php $result = query($id);	?>
				<table class="table">
					<tbody>
						<?php foreach ($result as $row) {?>
						<tr>
							<td><?= $row["id"] ?></td>
							<td><?= $row["name"] ?></td>
						</tr>
						<?php } ?>
					</tbody>
				</table>
			</div>
		</div>
	</div>


</body>