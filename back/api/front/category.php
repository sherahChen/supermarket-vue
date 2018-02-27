<?php
    header('Access-Control-Allow-Origin:*');

    include "DBHelper.php";

    $cateSamll = isset($_GET['cateSamll']) ? $_GET['cateSamll'] : "";
    $sql;

    if( $cateSamll !==''){
      $sql = "select * from category,classifysmall  where category.categoryId= '$cateSamll' and category.categoryId = classifysmall.classifyBigId";
    }else {
      $sql = "select * from category,classifysmall  where category.categoryId = classifysmall.classifyBigId";
    }

    $result = query_oop($sql);

   	echo json_encode($result, JSON_UNESCAPED_UNICODE);
?>
