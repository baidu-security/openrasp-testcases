<html>
<head>
    <meta charset="UTF-8"/>
    <title>012 - SSRF</title>
</head>
<body>
	<h1>012 - SSRF - CURL 方式</h1>

	<p>不正常调用:</p>
	<pre>curl <?php echo 'http://'.$_SERVER['HTTP_HOST'].$_SERVER['PHP_SELF'].'?url=http://0/'?></pre>
	<pre>说明: 参数 url 为请求的 url</pre>

	<br>
	<p>响应内容</p>
<?php 
	$url = @$_GET['url'];
	if(!empty($url)){
		$ch = curl_init($url);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($ch, CURLOPT_NOSIGNAL, 1);
		curl_setopt($ch, CURLOPT_NOBODY, FALSE); 
		curl_setopt($ch, CURLOPT_TIMEOUT_MS, 200);
		$data = curl_exec($ch);
		if(!empty($data)){
			if (curl_getinfo($ch, CURLINFO_HTTP_CODE) == '200') {
				$headerSize = curl_getinfo($ch, CURLINFO_HEADER_SIZE);
				$header = substr($data, 0, $headerSize);
				$body = substr($data, $headerSize);
				echo $body;
			}
		}
		
	}
?>
</body>
</html>