<?php
    header('Access-Control-Allow-Origin:*');
    include 'DBHelper.php';
     $sql = "select * from category";
        // 输出结果
       $result = query($sql);
    echo json_encode($result,JSON_UNESCAPED_UNICODE);

 ?>