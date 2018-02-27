<?php
    // 订单状态：0，待付款；1，待收货；2，待评价；3，已完成；4，已取消

    include 'DBHelper.php';
    $state = isset($_GET['state']) ? $_GET['state'] : "";
    $data = isset($_GET['data']) ? $_GET['data'] : "";
    $qty = isset($_GET['qty']) ? $_GET['qty'] : "";
    $pageNo = isset($_GET['pageNo']) ? $_GET['pageNo'] : "";
    $page=($pageNo-1)*$qty;
    if($state == 'search'&&$qty&&$pageNo){
        $sql = "select `order`.orderId,`user`.phone,`order`.`status`,`order`.time from `order` INNER JOIN `user` on `user`.userId = `order`.userId WHERE `order`.orderId LIKE '%$data%' or `user`.phone like '%$data%' or `order`.`status` like '%$data%' limit $page,$qty";
        $sql.=";select FOUND_ROWS() as totalQty";  
        $result =multi_query_oop($sql);
        if($result){
            echo json_encode($result,JSON_UNESCAPED_UNICODE);
        }else{
            echo 'false';
        }
    }else{
        $sql = "select `order`.orderId,`user`.phone,`order`.`status`,`order`.time from `order` INNER JOIN `user` on `user`.userId = `order`.userId ";
        $sql.=";select FOUND_ROWS() as totalQty";
        $sql.= ";select `order`.orderId,`user`.phone,`order`.`status`,`order`.time from `order` INNER JOIN `user` on `user`.userId = `order`.userId limit $page,$qty";
        $result = multi_query_oop($sql);
        if($result){
            echo json_encode($result,JSON_UNESCAPED_UNICODE);
        }else{
            echo 'false';
        }
    }
?>