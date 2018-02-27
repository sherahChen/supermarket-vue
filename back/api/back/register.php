<?php
    header('Access-Control-Allow-Origin:*');
    include "DBHelper.php";
    $email = isset($_POST['email']) ? $_POST['email'] : "";
    $user = isset($_POST['user']) ? $_POST['user'] : "";
    $password = isset($_POST['password']) ? $_POST['password'] : "";
    $checkEmail=isset($_GET['email']) ? $_GET['email'] : "";
    $checkUser=isset($_GET['user']) ? $_GET['user'] : "";
    if($email&&$user&&$password){
        $sql="insert into admin(email,user,password) values('$email','$user','$password')";
        $result = multi_query_oop($sql);
        if($result){
            // 插入成功
            echo "true";
        }else{
            echo "false";
        }
    }
    else if($checkEmail){
        $sql="select * from admin where email= '$checkEmail' ";
        $result = query_oop($sql);
        if (!empty($result)){
            echo 'false';//已存在
        }
        else{
            echo 'true';//不存在,可添加
        }
    }
    else if($checkUser){
        $sql="select * from admin where user='$checkUser'";
        $result = query_oop($sql);
        if (!empty($result)){
            echo 'false';//已存在
        }
        else{
            echo 'true';//不存在,可添加
        }
  
    }
    
   
?>