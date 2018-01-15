<html>
<head>	
	<meta charset="UTF-8"/>
	<title>001 - 列目录操作</title>
</head>
<body>
	<h1>001 - 列目录操作 - scandir 方式</h1>

<p>不正常调用: </p>
<pre>curl <?php echo 'http://'.$_SERVER['HTTP_HOST'].$_SERVER['PHP_SELF'].'?dir=/etc/'?></pre>
<br>
<p>windows 不正常调用: </p>
<pre>curl <?php echo 'http://'.$_SERVER['HTTP_HOST'].$_SERVER['PHP_SELF'].'?dir=C:'?></pre>

<br>
<p>目录内容</p>
<?php 

	if (isset($_GET['dir'])) 
	{
		$content = scandir($_GET['dir']);
		foreach (scandir($_GET['dir']) as $item)
		{
			echo "$item<br/>\n";
		}
	}
    
?>
</body>
</html>