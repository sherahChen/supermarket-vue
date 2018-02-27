<?php
    // 订单状态：0，待付款；1，待收货；2，待评价；3，已完成；4，已取消
    header('Access-Control-Allow-Origin:*');
    include 'DBHelper.php';
    $phone = isset($_GET['phone']) ? $_GET['phone'] : "";
    $status = isset($_GET['status']) ? $_GET['status'] : "";
    $state = isset($_GET['state']) ? $_GET['state'] : "";
    $orderId = isset($_GET['orderId']) ? $_GET['orderId'] : "";
    $goodId = isset($_GET['goodId']) ? $_GET['goodId'] : "";
    $userId = isset($_GET['userId']) ? $_GET['userId'] : "";
    
    if($state == 'get' && $userId != ""){
        $sql = "SELECT product.goodId,`order`.orderId,`order`.`status`,product.goodName,product.Price,productimg.ImgUrl,`order`.time FROM product INNER JOIN ordergoods on product.goodId = ordergoods.goodId INNER JOIN `order` on ordergoods.orderId = `order`.orderId INNER JOIN productimg on productimg.goodId = product.goodId WHERE `order`.userId = '$userId'";
        if($status != ""){
            $sql .= " and `order`.status = '$status'";
        }
        if($orderId != ""){
            $sql .= " and `order`.orderId = '$orderId'";
        }
        $result = query_oop($sql);
        if($result){
            echo json_encode($result,JSON_UNESCAPED_UNICODE);
        }else{
            echo 'false';
        }
    }else if($state == 'update' && $phone != "" && $status != ""){
        // 更新订单状态
        $sql = "UPDATE `order` SET `order`.`status` = '$status' WHERE `order`.userId = (SELECT userId from `user` WHERE phone = '$phone') and `order`.orderId = '$orderId'";
        $result = excute_oop($sql);
        if($result){
            echo 'ok';
        }else{
            echo 'false';
        }
    }else if($state == 'del' && $phone != ""){
        $sql = "DELETE FROM `order` WHERE userId = (SELECT userId from `user` WHERE phone = '$phone') and orderId = '$orderId'";
        $result = excute_oop($sql);
        $sql1 = "DELETE FROM ordergoods WHERE orderId = '$orderId'";
        $result1 = excute_oop($sql1);
        if($result){
            echo 'ok';
        }else{
            echo 'false';
        }
    }else if($userId != ""){
        $sql = "select * from `order` where userId = '$userId'";
        $result = query_oop($sql);
        if($result){
            echo json_encode($result,JSON_UNESCAPED_UNICODE);
        }else{
            echo 'false';
        }
    }
?>