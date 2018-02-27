<?php
    include 'DBHelper.php';
    $phone = isset($_GET['phone']) ? $_GET['phone'] : "";
    $userName = isset($_GET['userName']) ? $_GET['userName'] : "";
    $headeImg = isset($_GET['headeImg']) ? $_GET['headeImg'] : "";

    if($userName != "" || $headeImg != ""){
        $sql = "update user set userName = '$userName',headeImg = '$headeImg' where phone = $phone";
        $result = excute_oop($sql);
        if($result){
            echo 'true';
        }else{
            echo 'false';
        }
    }else{
        // 加密
        $sql = "select * from user where phone = '$phone'";
        $result = query_oop($sql);
        $result[0]["password"] = "";
        // 输出结果
        if($result){
            echo json_encode($result,JSON_UNESCAPED_UNICODE);
        }else{
            echo 'false';
        }
    }
    // 关闭连接
    // $conn->close();

?>