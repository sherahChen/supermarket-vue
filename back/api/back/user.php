<?php
    include 'DBHelper.php';
    header("Content-Type: text/html;charset=utf-8"); 
    $data = isset($_GET['data']) ? $_GET['data'] : "";
    $qty = isset($_GET['qty']) ? $_GET['qty'] : "";
    $pageNo = isset($_GET['pageNo']) ? $_GET['pageNo'] : "";
    $page=($pageNo-1)*$qty;
    if($data&&$qty&&$pageNo){  
        $sql="select userName,password,phone,headeImg,time from user where userName like '%$data%' or password like '%$data%' or phone like '%$data%' or headeImg like '%$data%' limit $page,$qty";
        $sql.=";select FOUND_ROWS() as totalQty";    
    }
    else{
        $sql="select userName,password,phone,headeImg,time from user";
        $sql.=";select FOUND_ROWS() as totalQty";
        $sql.=";select userName,password,phone,headeImg,time from user limit $page,$qty";
        
        
    }
     $result = multi_query_oop($sql);
     echo json_encode($result,JSON_UNESCAPED_UNICODE);
    
?>