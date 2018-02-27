<?php
    header('Access-Control-Allow-Origin:*');

    include "DBHelper.php";

    $userId = isset($_POST['userid']) ? $_POST['userid'] : "1";
    $goodId = isset($_POST['goodId']) ? $_POST['goodId'] : "";
    $Getprd = isset($_POST['Getprd']) ? $_POST['Getprd'] : "";

    $sql;
    if($Getprd !== ""){
      $sql = "SELECT * from product,car,productimg WHERE car.userId = 1 and car.goodId = product.goodId and product.goodId = productimg.goodId";
      $result = query_oop($sql);
      echo json_encode($result, JSON_UNESCAPED_UNICODE);
    } else {

    if($goodId == ''){
      // echo '空的哦';
      $sql = "select sum(count) as totle, SUM(product.Price*count) AS Price from car,product where userId ='$userId' and car.goodId = product.goodId";
      $result = query_oop($sql);
      echo json_encode($result, JSON_UNESCAPED_UNICODE);

    } else {
    // if( $userId !== "" && $goodId !== ''){
      $sql ="";
      $sql = "select * from car where userId='$userId' and goodId ='$goodId'";
      $result = query_oop($sql);
      // echo count($result);

      // var_dump($result);

      if(count($result)>0){
        $sql="";
        // echo "已有";
        $sql = "UPDATE car set count = count+1  where userId='$userId' and goodId = '$goodId'";
        $result = excute_oop($sql);
        if($result){
          $sql1 = "select sum(count) as totle, SUM(product.Price*count) AS Price from car,product where userId ='$userId' and car.goodId = product.goodId";
          $result1 = query_oop($sql1);
          echo json_encode($result1, JSON_UNESCAPED_UNICODE);
        }else{
          echo "fail";
        }
      } else {
        $sql="";
        $sql = "insert into car(userId,goodId) values ('$userId','$goodId')";
        $result1 = excute_oop($sql);
        if($result1){
            // 插入成功
            // echo $userId;
            $sql1 = "select sum(count) as totle, SUM(product.Price*count) AS Price from car,product where userId ='$userId' and car.goodId = product.goodId";
            $result1 = query_oop($sql1);
            echo json_encode($result1, JSON_UNESCAPED_UNICODE);
        }else{
            echo "fail";
        }
      }

    }
    // }
  }


?>
