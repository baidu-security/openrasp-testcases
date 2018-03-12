<html>
<head>	
	<meta charset="UTF-8"/>
	<title>005 - 任意文件写入 - file_put_contents 方式</title>
</head>
<body>
<h1>005 - 任意文件写入 - file_put_contents 方式</h1>

<p>正常调用：</p>
<pre>curl <?php echo 'http://'.$_SERVER['HTTP_HOST'].$_SERVER['PHP_SELF'].' -d "path=user.txt&data=123"'?></pre>
<br>

<p>不正常调用：</p>
<pre>curl <?php echo 'http://'.$_SERVER['HTTP_HOST'].$_SERVER['PHP_SELF'].' -d "path=1.php&data=&lt;?php phpinfo(); ?>"'?></pre>

<?php 
	if (isset ($_POST['path']) && isset ($_POST['data']))
	{
		file_put_contents($_POST['path'], $_POST['data']);
	}
?>
</body>
</html>