<html>
<head>	
	<meta charset="UTF-8"/>
	<title>004 - 命令执行</title>
</head>
<body>
	<h1>004 - 命令执行 - system 方式</h1>

	<p>Linux 触发: </p>
	<pre>curl <?php echo '"http://'.$_SERVER['HTTP_HOST'].$_SERVER['PHP_SELF'].'?cmd=cat+/etc/resolv.conf"'?> </pre>
	<p>然后检查 /tmp 是否存在 passwd 这个文件</p>
	<br>

	<p>Windows 触发: </p>
	<a href="<?= 'http://'.$_SERVER['HTTP_HOST'].$_SERVER['PHP_SELF'].'?cmd=calc' ?>" target="_blank">点击这里执行 calc</a>

	<br><br>
	<p>命令执行结果</p>

<?php 
	if (isset ($_GET['cmd']))
	{
		echo system ($_GET['cmd']);
	}
?>
</body>
</html>