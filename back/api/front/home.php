<?php
    header('Access-Control-Allow-Origin:*');
    header("Content-Type: text/html;charset=utf-8"); 
    include "DBHelper.php";
    $allType=isset($_GET['allType'])?$_GET['allType']:'';
    $uid=isset($_GET['uid'])?$_GET['uid']:'';
    $sql1='';
    if($uid){
        $sql="select * from car c,product p where c.userId=$uid and c.goodId=p.goodId;";
        $result =query_oop($sql);
    }
   else if($allType){
       $sql="";
       $typeArr=explode(',',$allType);
       foreach($typeArr as $val){
            $sql.="select * from product,productimg where  product.goodId=productimg.goodId and product.classifySmallId in (select classifySmallId from classifysmall  where classifyBigId=(select categoryId from category where categoryName='$val') );";
         }
        $result =multi_query_oop($sql);
        
    }
    else{
        $sql="select * from category";
        $result =query_oop($sql); 
    }
    // // arr->obj
    // function array2object($array) {
    // if (is_array($array)) {
    //     $obj = new StdClass();
    //     foreach ($array as $key => $val){
    //     $obj->$key = $val;
    //     }
    // }
    // else { $obj = $array; }
    // return $obj;
    // }
    // // obj->arr
    // function object2array($object) {
    // if (is_object($object)) {
    //     foreach ($object as $key => $value) {
    //     $array[$key] = $value;
    //     }
    // }
    // else {
    //     $array = $object;
    // }
    // return $array;
    // }  
      echo json_encode($result, JSON_UNESCAPED_UNICODE);     
?>