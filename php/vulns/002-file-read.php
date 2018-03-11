<html>
<head>	
	<meta charset="UTF-8"/>
	<title>002 任意文件读取</title>
</head>
<body>
	<h1>002 - 任意文件读取 - file_get_contents</h1>

<p>Linux 不正常调用: </p>
<pre>curl <?php echo 'http://'.$_SERVER['HTTP_HOST'].$_SERVER['PHP_SELF'].'?file=/etc/hosts'?></pre>

<br>
<p>windows 不正常调用: </p>
<pre>curl <?php echo 'http://'.$_SERVER['HTTP_HOST'].$_SERVER['PHP_SELF'].'?file=C:\Windows\System32\drivers\etc\hosts'?></pre>

<br>
<p>文件内容</p>
<?php 
	if (isset ($_GET['file']))
	{
		echo file_get_contents($_GET['file']);
	}
?>
</body>
</html>