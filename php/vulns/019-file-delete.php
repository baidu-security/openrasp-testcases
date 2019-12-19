<?php
    error_reporting(E_ALL);
    ini_set("display_errors", 1);

	$baseurl   = 'http://' . $_SERVER['HTTP_HOST'] . parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH) ;
	$normalurl = $baseurl . '?file=testfile.txt';
	$badurl    = $baseurl . '?file=../uploads/testfile.txt';
?>

<html>
<head>	
	<meta charset="UTF-8"/>
	<title>019 - 任意文件删除 - unlink 方式</title>
</head>
<body>
<h1>005 - 任意文件删除 - unlink 方式</h1>

	<div style="display: inline-block; color: #721c24; background: #f8d7da; padding: 10px; ">
		若测试用例无法执行，请检查 open_basedir 配置，以及目录是否有写入权限。
	</div>

<p>正常调用：</p>
<pre>curl -g <?php echo $normalurl;?></pre>
<br>

<p>不正常调用：</p>
<pre>curl -g <?php echo $badurl?></pre>

<?php 
	if (isset ($_GET['name']))
	{
		$path = $_GET['name'];
		$status = file_put_contents($path, "test");
		if ($status) {
			echo "文件创建成功: " . htmlentities($path) . "\n<br/>";
			$status = unlink($path);
			if ($status){
				echo "文件删除成功: " . htmlentities($path) . "\n<br/>";
			} else {
				echo "删除失败，文件不存在或权限不足？\n<br/>";
			}
		} else {
			echo "创建文件" . htmlentities($path) . "失败， 目录没有写权限？\n<br/>";
		}
	}
?>
</body>
</html>
