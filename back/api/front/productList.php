<?php
    header('Access-Control-Allow-Origin:*');

    include "DBHelper.php";

    $categoryId = isset($_GET['categoryId']) ? $_GET['categoryId'] : "";
    // $categoryId1 = isset($_POST['categoryId']) ? $_POST['categoryId'] : "";
    $state = isset($_GET['state']) ? $_GET['state'] : "";

    $sql;


    if( $state == 'small'){
        $sql = "select * from classifysmall,product,productimg where classifysmall.classifySmallId = '$categoryId' and classifysmall.classifySmallId = product.classifySmallId and product.goodId = productimg.goodId";
        $result = query_oop($sql);

   	    echo json_encode($result, JSON_UNESCAPED_UNICODE);
      // }
    } else if($state == 'bigCategory'){
        $sql = "select * from category,product,productimg
        where category.categoryId = '$categoryId'
        and category.categoryId = product.classifyBigId
        and product.goodId = productimg.goodId";
        $result = query_oop($sql);

       echo json_encode($result, JSON_UNESCAPED_UNICODE);

    }  else if($state == 'search'){

      $sql = "select * from product,productimg WHERE product.goodName  like '%" .$categoryId. "%' and product.goodId = productimg.goodId";
      $result = query_oop($sql);

       echo json_encode($result, JSON_UNESCAPED_UNICODE);
  }
    else {
      $sql = "select * from classifysmall,product,productimg
      where classifysmall.classifySmallId = product.classifySmallId
      and product.goodId = productimg.goodId";
      $result = query_oop($sql);

   	  echo json_encode($result, JSON_UNESCAPED_UNICODE);
    }

?>
