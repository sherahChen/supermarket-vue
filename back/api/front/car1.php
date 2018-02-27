<?php
    header('Access-Control-Allow-Origin:*');

    include "DBHelper.php";

    $userId = isset($_POST['userId']) ? $_POST['userId'] : "";
    $goodId = isset($_POST['goodId']) ? $_POST['goodId'] : "";
    $state = isset($_POST['state']) ? $_POST['state'] : "";
    $changestate = isset($_POST['changestate']) ? $_POST['changestate'] : "";
    $sql;

    if($state == 'addProductTotle'){
      $sql = "UPDATE car set count = count+1  where userId='$userId' and goodId = '$goodId'";
      $result = excute_oop($sql);
      if($result){
        echo 'seccese';
      }else{
        echo "fail";
      }
    } else if($state == 'subProductTotle'){
      $sql = "UPDATE car set count = count-1  where userId='$userId' and goodId = '$goodId'";
      $result = excute_oop($sql);
      if($result){
        echo 'seccese';
      }else{
        echo "fail";
      }
    } else if($state == 'delProduct'){
      $sql = "delete from car where userId = '$userId' and goodId ='$goodId'";
      $result = excute_oop($sql);
      if($result){
        echo 'seccese';
      }else{
        echo "fail";
      }
    } else if( $state  == 'changestate'){
      if($changestate == 'false'){
        $sql = "UPDATE car set checkedstatus = 'false'   where userId='$userId' and goodId = '$goodId'";
        $result = excute_oop($sql);
        if($result){
          echo 'seccese';
        }else{
          echo "fail";
        }
      } else {
        $sql = "UPDATE car set checkedstatus = 'true'   where userId='$userId' and goodId = '$goodId'";
        $result = excute_oop($sql);
        if($result){
          echo 'seccese';
        }else{
          echo "fail";
        }
      }

    } else if ( $state == 'emptycart') {
      $sql = "delete from car where userId = '$userId'";
      $result = excute_oop($sql);
      if($result){
        echo 'seccese';
      }else{
        echo "fail";
      }
    } else if( $state == "selectproduct"){

      $sql = "SELECT * from product,car,productimg WHERE car.userId = '$userId' and car.goodId = product.goodId and product.goodId = productimg.goodId";

      $result = query_oop($sql);
      echo json_encode($result, JSON_UNESCAPED_UNICODE);

    } else if( $state == 'addProduct'){

      $sql ="";
      $sql = "select * from car where userId='$userId' and goodId ='$goodId'";
      $result = query_oop($sql);
      // echo count($result);

      // var_dump($result);

      if(count($result)>0){
        $sql = "UPDATE car set count = count+1  where userId='$userId' and goodId = '$goodId'";
        $result = excute_oop($sql);
        if($result){
          echo 'seccese';
        }else{
          echo "fail";
        }
      }else{
        $sql = "insert into car(userId,goodId) values ('$userId','$goodId')";
        $result = excute_oop($sql);
        if($result){
          echo 'seccese';
        }else{
          echo "fail";
        }
      }

    } else if( $state == 'selectprdCount'){
      $sql = "select sum(count) as totle, SUM(product.Price*count) AS Price from car,product where userId ='$userId' and car.goodId = product.goodId";
      $result = query_oop($sql);
      echo json_encode($result, JSON_UNESCAPED_UNICODE);
    }

?>
