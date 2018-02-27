<?php
    header('Access-Control-Allow-Origin:*');

    include "DBHelper.php";

    $userId = isset($_POST['userId']) ? $_POST['userId'] : "";
    $state = isset($_POST['state']) ? $_POST['state'] : "";
    $orderId = isset($_POST['orderId']) ? $_POST['orderId'] : "";
    $goodsId = isset($_POST['goodsId']) ? $_POST['goodsId'] : "";
    $leaveword = isset($_POST['leaveword']) ? $_POST['leaveword'] : "";
    $sql;

    if($state == 'selectaddress'){
        $sql = "SELECT * from address WHERE userId ='$userId'";
        $result = query_oop($sql);

        if($result){
            echo json_encode($result, JSON_UNESCAPED_UNICODE);
        }else{
            echo "fail";
        }
    } else if($state == 'selectproduct'){
        $sql = "SELECT * from car,product,productimg
        where userId = '$userId' and checkedstatus = 'true'
        and product.goodId = car.goodId and product.goodId = productimg.goodId";
        $result = query_oop($sql);

        if($result){
           echo json_encode($result, JSON_UNESCAPED_UNICODE);
        }else{
           echo "fail";
        }
    } else if( $state == 'inserproduct'){
      $sql = "insert into `order` (orderid,userid,leavewords) values ('$orderId','$userId','$leaveword')";
      $result = excute_oop($sql);
        if($result){
          for($i=0;$i<count($goodsId);$i++){
            // echo $goodsId[$i];
            $item = $goodsId[$i];
            $sql = "insert into ordergoods (orderId,goodId) values('$orderId','$item')";
            $result = excute_oop($sql);
            if($result){
              echo 'seccese';
            }else{
              echo "fail";
            }
          }
          // echo json_encode($goodsId);
        }else{
          echo "fail";
        }
    } else if( $state == "deleteproduct"){
      $sql = "DELETE FROM car where checkedstatus = 'true' and userId = '$userId'";
      $result = excute_oop($sql);
      if($result){
        echo 'seccese';
      }else{
        echo "fail";
      }
    }
    // else if($state == 'delProduct'){
    //   $sql = "delete from car where userId = '$userId' and goodId ='$goodId'";
    //   $result = excute_oop($sql);
    //   if($result){
    //     echo 'seccese';
    //   }else{
    //     echo "fail";
    //   }
    // } else if( $state  == 'changestate'){
    //   if($changestate == 'false'){
    //     $sql = "UPDATE car set checkedstatus = 'false'   where userId='$userId' and goodId = '$goodId'";
    //     $result = excute_oop($sql);
    //     if($result){
    //       echo 'seccese';
    //     }else{
    //       echo "fail";
    //     }
    //   } else {
    //     $sql = "UPDATE car set checkedstatus = 'true'   where userId='$userId' and goodId = '$goodId'";
    //     $result = excute_oop($sql);
    //     if($result){
    //       echo 'seccese';
    //     }else{
    //       echo "fail";
    //     }
    //   }

    // } else if ( $state == 'emptycart') {
    //   $sql = "delete from car where userId = '$userId'";
    //   $result = excute_oop($sql);
    //   if($result){
    //     echo 'seccese';
    //   }else{
    //     echo "fail";
    //   }
    // } else if( $state == "selectproduct"){

    //   $sql = "SELECT * from product,car,productimg WHERE car.userId = 1 and car.goodId = product.goodId and product.goodId = productimg.goodId";

    //   $result = query_oop($sql);
    //   echo json_encode($result, JSON_UNESCAPED_UNICODE);

    // } else if( $state == 'addProduct'){

    //   $sql ="";
    //   $sql = "select * from car where userId='$userId' and goodId ='$goodId'";
    //   $result = query_oop($sql);
    //   // echo count($result);

    //   // var_dump($result);

    //   if(count($result)>0){
    //     $sql = "UPDATE car set count = count+1  where userId='$userId' and goodId = '$goodId'";
    //     $result = excute_oop($sql);
    //     if($result){
    //       echo 'seccese';
    //     }else{
    //       echo "fail";
    //     }
    //   }else{
    //     $sql = "insert into car(userId,goodId) values ('$userId','$goodId')";
    //     $result = excute_oop($sql);
    //     if($result){
    //       echo 'seccese';
    //     }else{
    //       echo "fail";
    //     }
    //   }

    // } else if( $state == 'selectprdCount'){
    //   $sql = "select sum(count) as totle, SUM(product.Price*count) AS Price from car,product where userId ='$userId' and car.goodId = product.goodId";
    //   $result = query_oop($sql);
    //   echo json_encode($result, JSON_UNESCAPED_UNICODE);
    // }

?>
