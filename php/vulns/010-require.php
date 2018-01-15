<html>
<head>
	<meta charset="UTF-8"/>
	<title>010 - 任意文件包含</title>

</head>

<body>
	<h1>010 - 任意文件包含 - include 方式</h1>

	<p>正常调用: </p>
	<pre>curl <?php echo 'http://'.$_SERVER['HTTP_HOST'].$_SERVER['PHP_SELF'].'?file=header.php'?></pre>
	<br>

	
	<p>不正常调用</p>
	<pre>curl <?php echo 'http://'.$_SERVER['HTTP_HOST'].$_SERVER['PHP_SELF'].'?file=../../../../../../../../../../../../../var/log/nginx/access.log'?></pre>

	<br>
	<p>包含内容</p>
<?php 
	if (isset ($_GET['file']))
	{
		include ('classes/' . $_GET['file']);
	}
?>
</body>
</html>