<?php
    error_reporting(E_ALL);
    ini_set("display_errors", 1);

    $server = isset($_GET["server"]) ? $_GET['server']: 'mongodb://127.0.0.1:27017';
    $id = isset($_GET['id']) ? $_GET['id'] : '1';
    $id2 = isset($_GET['id2']) ? $_GET['id2'] : '1';

    function query($id) {
        $manager = new MongoDB\Driver\Manager("mongodb://127.0.0.1:27017");
        
        $filter = ['id' => $id];
        $options = [
            'projection' => ['_id' => 0],
        ];
        $query = new MongoDB\Driver\Query($filter, $options);
        $cursor = $manager->executeQuery('test.col', $query)->toArray();
        return $cursor; 
    }

    function query2($id) {
        $manager = new \MongoDB\Driver\Manager("mongodb://127.0.0.1:27017");
        $query_body =array(
            '$where'=>"
                function q() {
                    if (this.id == \"$id\") {
                        return true;
                    } else {
                        return false;
                    }
                }
            ");
        $query = new MongoDB\Driver\Query($query_body);
        $cursor = $manager->executeQuery('test.col', $query)->toArray();
        return $cursor;
    }

?>

<html>
<head>
    <meta charset="UTF-8"/>
    <title>020 - mongodb 注入测试 - MongoDB driver扩展</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
</head>
<body>

    <div class="container-fluid" style="margin-top: 50px;">
        <div class="row">
            <div class="col-xs-8 col-xs-offset-2">
            <h4>mongodb 注入 - MongoDB driver扩展</h4>
            <p>第一步: 请使用mongo shell执行下面的语句创建表</p>
            <pre>db.col.insert({id:"1", name:"openrasp"})
db.col.insert({id:"2", name:"user"})
db.col.insert({id:"3", name:"jack"})
</pre>
            </div>
        </div>

        <div class="row">
            <div class="col-xs-8 col-xs-offset-2">
                <p>第二步: 尝试发起mongo注入攻击</p>
                <p>php数组方式（id[$ne]=123）</p>
                <form action="<?php echo parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH) ?>" method="get">
                    <div class="form-group">
                        <label>服务器地址</label>
                        <input class="form-control" name="server" value="<?php echo $server ?>">
                    </div>
                    <div class="form-group">
                        <label>查询条件</label>
                        <input class="form-control" name="id" value="<?php echo $id ?>" autofocus>
                    </div>

                    <button type="submit" class="btn btn-primary">提交查询</button>                    
                </form>

                <p>js注入方式 (id=" || "1)</p>
                <form action="<?php echo parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH) ?>" method="get">
                    <div class="form-group">
                        <label>服务器地址</label>
                        <input class="form-control" name="server" value="<?php echo $server ?>">
                    </div>
                    <div class="form-group">
                        <label>查询条件</label>
                        <input class="form-control" name="id2" value="<?php echo htmlspecialchars($id2) ?>" autofocus>
                    </div>

                    <button type="submit" class="btn btn-primary">提交查询</button>                    
                </form>
            </div>
        </div>

        <div class="row">
            <div class="col-xs-8 col-xs-offset-2">
            <p>第三步: 检查注入结果</p>
            <?php 
                if (isset($_GET['id'])) {
                    $result = query($_GET['id']);
                } else if (isset($_GET['id2'])) {
                    $result = query2($_GET['id2']);
                }
            ?>
            <table class="table">
                <tbody>
                    <?php if (isset ($result)) foreach ($result as $row) {?>
                    <tr>
                        <td><?php echo $row->id; ?></td>
                        <td><?php echo $row->name; ?></td>
                    </tr>
                    <?php } ?>
                </tbody>
            </table>
            </div>
        </div>
    </div>
</body>
