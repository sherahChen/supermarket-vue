<?php
    header('Access-Control-Allow-Origin:*');

    include "DBHelper.php";

    $categoryId = isset($_GET['categoryId']) ? $_GET['categoryId'] : "0";
    $Sort = isset($_GET['Sort']) ? $_GET['Sort'] : "";

    $Sort = json_decode($Sort);
    $sql;

    if( $Sort !== ""){
      if($Sort == "DefaultSort"){
        // echo $Sort;
        if($categoryId == '0'){
        // echo $categoryId;

          $sql = "select * from classifysmall,product,productimg where classifysmall.classifySmallId = product.classifySmallId and product.goodId = productimg.goodId";
        } else {
          $sql = "select * from classifysmall,product,productimg where classifysmall.classifySmallId = '$categoryId' and classifysmall.classifySmallId = product.classifySmallId and product.goodId = productimg.goodId";
        }
      } else if( $Sort == 'LowPriceSort'){
        if( $categoryId == '0' ){
          $sql = "select * from classifysmall,product,productimg where classifysmall.classifySmallId = product.classifySmallId and product.goodId = productimg.goodId ORDER BY product.Price asc";
        } else {
          $sql = "select * from classifysmall,product,productimg where classifysmall.classifySmallId = '$categoryId' and classifysmall.classifySmallId = product.classifySmallId and product.goodId = productimg.goodId ORDER BY product.Price asc";
        }
      } else if ( $Sort == 'HighPriceSort'){
        if( $categoryId == '0' ){
          $sql = "select * from classifysmall,product,productimg where classifysmall.classifySmallId = product.classifySmallId and product.goodId = productimg.goodId ORDER BY product.Price desc";
        } else {
          $sql = "select * from classifysmall,product,productimg where classifysmall.classifySmallId = '$categoryId' and classifysmall.classifySmallId = product.classifySmallId and product.goodId = productimg.goodId ORDER BY product.Price desc";
        }
      } else if( $Sort == 'DiscountSort'){
        if( $categoryId == '0' ){
          $sql = "select * from classifysmall,product,productimg
          where classifysmall.classifySmallId = product.classifySmallId
          and product.goodId = productimg.goodId
          ORDER BY product.originalPrice-product.Price DESC";
        } else {
          $sql = "select * from classifysmall,product,productimg
          where classifysmall.classifySmallId = '$categoryId' and classifysmall.classifySmallId = product.classifySmallId
          and product.goodId = productimg.goodId
          ORDER BY product.originalPrice-product.Price DESC";
        }
      } else if( $Sort == 'random') {
        $sql = "SELECT * FROM product,productimg
        WHERE product.goodId = productimg.goodId
         ORDER BY RAND() LIMIT 0,6;";
      }
    }

    // select * from classifysmall,product,productimg where classifysmall.classifySmallId = 'undefined' and classifysmall.classifySmallId = product.classifySmallId and product.goodId = productimg.goodId

    $result = query_oop($sql);

   	echo json_encode($result, JSON_UNESCAPED_UNICODE);
?>
