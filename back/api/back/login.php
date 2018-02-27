<?php
    header('Access-Control-Allow-Origin:*');
    include "DBHelper.php";
    
    $user = isset($_GET['user']) ? $_GET['user'] : "";
    $password = isset($_GET['password']) ? $_GET['password'] : "";
    $sql="select * from admin where password='$password' and (user='$user'or email='$user')";
    $result = query_oop($sql);
    if (!empty($result)){
        echo 'true';
    }
    else{
        echo 'false';
    }
?>