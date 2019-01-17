<?php
	$baseurl = 'http://' . $_SERVER['HTTP_HOST'] . $_SERVER['PHP_SELF'] ;
	$url1  = $baseurl . '?input=' . urlencode('<script>alert(12345)</script>');
	$url2  = $baseurl . '?input2=' . urlencode('233<img src=1 onerror=alert("xss12345")>');
?>

<html>
<head>
    <meta charset="UTF-8"/>
    <title>001 - 列目录操作</title>
</head>
<body>

    <h1>017 - 反射型XSS</h1>

<p>ECHO方式: </p>
<p>curl '<a href="<?php echo $url1 ?>" target="_blank"><?php echo $url1 ?></a>'</p>

<br>
<p>用户输入反射至页面: </p>
<p>curl '<a href="<?php echo $url2 ?>" target="_blank"><?php echo ($url2) ?></a>'</p>


<br>
<?php 

    if(isset($_GET['input'])) {
        header('X-XSS-Protection: 0');
        echo $_GET['input'];
    }
    else if(isset($_GET['input2'])) {
        header('X-XSS-Protection: 0');
        $content = "<p>" . trim($_GET['input2']) . "</p>"; 
        echo $content;
    }
?>
</body>
</html>