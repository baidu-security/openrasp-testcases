<?php
	$baseurl = 'http://' . $_SERVER['HTTP_HOST'] . $_SERVER['PHP_SELF'] . '?url=';
	$any     = $baseurl . 'http://requestb.in';
?>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>011 - SSRF - cURL 方式</title>
</head>
<body>
	<h1>011 - SSRF - cURL 方式</h1>

	<p>不正常调用:</p>
	<pre>curl '<a href="<?php echo $any ?>" target="_blank"><?php echo $any ?></a>'</pre>
	<pre>说明: 参数 url 为请求的 url</pre>

	<br>
	<p>响应内容</p>
<?php 
	$url = $_GET['url'];
	if(isset($url))
	{
		$ch = curl_init($url);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($ch, CURLOPT_NOSIGNAL, 1);
		curl_setopt($ch, CURLOPT_NOBODY, FALSE); 
		curl_setopt($ch, CURLOPT_TIMEOUT_MS, 200);
		echo curl_exec($ch);		
	}
?>
</body>
</html>