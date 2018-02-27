<?php
    include 'DBHelper.php';
    $phone = isset($_GET['phone']) ? $_GET['phone'] : "";
    $password = isset($_GET['password']) ? $_GET['password'] : "";
    // 加密
    $password = md5($password);

    $sql = "select * from user where phone = '$phone' and password = '$password'";
    $phone = md5($phone);
    $result = query_oop($sql);
    // $result = $conn->query($sql);
    //使用查询结果集
    // $row = $result->fetch_all(MYSQLI_ASSOC);
    // 输出结果
    if($result){
        $result[0]['password'] = "";
        echo json_encode($result, JSON_UNESCAPED_UNICODE);
    }else{
        echo 'false';
    }
    // 关闭连接
    // $conn->close();

?>