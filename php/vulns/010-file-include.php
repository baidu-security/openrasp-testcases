<?php
	$baseurl = 'http://' . $_SERVER['HTTP_HOST'] . $_SERVER['PHP_SELF'] . '?file=';
	$linux   = $baseurl . 'header.php';
	$windows = $baseurl . '../../../../../../../../../../../../../var/log/httpd/error_log';
?>

<html>
<head>
	<meta charset="UTF-8"/>
	<title>010 - 任意文件包含 - include 拼接方式</title>

</head>

<body>
	<h1>010 - 任意文件包含 - include 拼接方式</h1>

	<p>正常调用: </p>
	<pre>curl '<a href="<?php echo $linux; ?>" target="_blank"><?php echo $linux; ?></a>'</pre>
	<br>
	
	<p>不正常调用</p>
	<pre>curl '<a href="<?php echo $windows; ?>" target="_blank"><?php echo $windows; ?></a>'</pre>

	<br>
	<p>包含内容</p>
<?php 
	if (isset ($_GET['file']))
	{
		include (__DIR__ . '/classes/' . $_GET['file']);
	}
?>
</body>
</html>
