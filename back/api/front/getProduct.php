<?php
    header('Access-Control-Allow-Origin:*');

    include "DBHelper.php";

    $goodId = isset($_POST['goodId']) ? $_POST['goodId'] : "1";

    $state = isset($_POST['state']) ? $_POST['state'] : "";
    $sql;

    if($state == 'select'){
      $sql = "select * from product,productimg
      WHERE product.goodId = '$goodId'
      and product.goodId = productimg.goodId";
      $result = query_oop($sql);
      if($result){
        echo json_encode($result, JSON_UNESCAPED_UNICODE);
      } else {
        echo 'fail';
      }
    }
?>
