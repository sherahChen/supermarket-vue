<?php
    header('Access-Control-Allow-Origin:*');
    include "DBHelper.php";
    $phone = isset($_GET['phone']) ? $_GET['phone'] : "";
    $orderId = isset($_GET['orderId']) ? $_GET['orderId'] : "";
    $uid = isset($_GET['uid']) ? $_GET['uid'] : "";
    if($phone != "" && $orderId != ""){
        $sql = "select `order`.orderId,`order`.status,`order`.time,ordergoods.goodId,product.goodName,product.Price,address.linkMan,address.gender,address.phone,productimg.ImgUrl,address.village,address.doorplate from `order` INNER JOIN ordergoods on ordergoods.orderId = `order`.orderId INNER JOIN product on product.goodId = ordergoods.goodId inner JOIN address on address.orderId = ordergoods.orderId inner JOIN productimg on productimg.goodId = ordergoods.goodId WHERE `order`.userId = (SELECT userId from `user` WHERE phone = '$phone') AND `order`.orderId = '$orderId'";

        $result =query_oop($sql);
        if($result){
            echo json_encode($result, JSON_UNESCAPED_UNICODE);
        }else{
            echo 'false';
        }
    } else{
        $sql="select * from address WHERE userId = '$uid' ";
        $result =query_oop($sql);
        echo json_encode($result, JSON_UNESCAPED_UNICODE);
    }

?>
