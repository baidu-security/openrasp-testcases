<html>
<head>	
	<meta charset="UTF-8"/>
	<title>004 - 命令执行 （无回显）</title>
</head>
<body>
	<h1>004 - 命令执行 (exec 方式，无回显)</h1>

	<p>Linux 触发: </p>
	<pre>curl <?php echo '"http://'.$_SERVER['HTTP_HOST'].$_SERVER['PHP_SELF'].'?cmd=cp+/etc/passwd+/tmp/"'?> </pre>
	<p>然后检查 /tmp 是否存在 passwd 这个文件</p>
	<br>

	<p>Windows 触发: </p>
	<a href="<?= 'http://'.$_SERVER['HTTP_HOST'].$_SERVER['PHP_SELF'].'?cmd=calc' ?>" target="_blank">点击这里执行 calc</a>

<?php 
	if (isset ($_GET['cmd']))
	{
		exec ($_GET['cmd']);
	}
?>
</body>
</html>