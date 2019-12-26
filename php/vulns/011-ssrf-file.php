<?php
    error_reporting(E_ALL);
    ini_set("display_errors", 1);
    
    $baseurl  = 'http://' . $_SERVER['HTTP_HOST'] . parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH) . '?url=';
    $url      = isset($_GET['url']) ? $_GET['url'] : "http://127.0.0.1";
    $function = isset($_GET['function']) ? $_GET['function'] : false;

?>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>011 - SSRF - php文件读取方式</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
</head>
<body>
    <div class="container-fluid" style="margin-top: 50px;">
        <div class="row">
            <div class="col-xs-8 col-xs-offset-2">
                <h4>011 - SSRF - php文件读取方式</h4>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-8 col-xs-offset-2">
                <br>
                <form action="<?php echo parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH) ?>" method="get">
                    <div class="form-group">
                        <label>测试函数</label>
                        <select name="function">
                            <option value="file">file</option>
                            <option value="readfile">readfile</option>
                            <option value="fopen">fopen</option>
                            <option value="include">include</option>
                            <option value="copy">copy</option>
                            <option value="file_get_contents">file_get_contents</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>测试URL</label>
                        <input class="form-control" name="url" value="<?php echo $url ?>" autofocus>
                    </div>

                    <button type="submit" class="btn btn-primary">提交查询</button>                    
                </form>
                <br>
                    <p>响应内容</p>
                <?php 
                    if(in_array($function, array("file", "readfile", "fopen", "include", "copy", "file_get_contents"))) {
                        if ($function == "include" && ini_get("allow_url_include") != "1") {
                            echo 'include方式需要在php.ini设置 allow_url_include=On 后才可以触发!';
                        }
                        else if(ini_get("allow_url_fopen") != "1") {
                            echo '通过文件读取函数访问URL需要在php.ini设置 allow_url_include=On 后才可以触发!';
                        }
                        else {
                            if($function == "copy") {
                                copy($url, "upload/ssrf-result.txt");
                            }
                            else if($function == "fopen") {
                                copy($url, "r");
                            }
                            else {
                                $function($url);
                            }
                        }
                    }
                ?>
            </div>
        </div>
    </div>
</body>
</html>