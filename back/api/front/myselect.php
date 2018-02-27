<?php
    include 'DBHelper.php';
    $phone = isset($_GET['phone']) ? $_GET['phone'] : "";
    $state = isset($_GET['state']) ? $_GET['state'] : "";
    $goodId = isset($_GET['goodId']) ? $_GET['goodId'] : "";
    if($state != '' && $goodId != ''){
        $sql = "delete from collect where userId = (select userId from `user` where phone = '$phone') and goodId = '$goodId'";
        $result = excute_oop($sql);
        if($result){
            echo "ok";
        }else{
            echo 'false';
        }
    }else{
        $sql = "select product.goodName,product.describe,productimg.ImgUrl,product.size,product.Price,product.originalPrice,product.goodId from product INNER JOIN collect on collect.goodId = product.goodId INNER JOIN productimg on productimg.goodId = product.goodId where collect.userId = (select userId from `user` where phone = '$phone')";
        $result = query_oop($sql);
        if($result){
            echo json_encode($result, JSON_UNESCAPED_UNICODE);
        }else{
            echo 'false';

        }
    }
?>