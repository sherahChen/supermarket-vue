<?php
    header('Access-Control-Allow-Origin:*');
    include "DBHelper.php";
    
    $page = isset($_GET['page']) ? $_GET['page'] : "1";
    $limit = isset($_GET['limit']) ? $_GET['limit'] : "6";
    $state = isset($_GET['state']) ? $_GET['state'] : "";
    $data = isset($_GET['data']) ? $_GET['data'] : '';
    $goodId = isset($_GET['goodId']) ? $_GET['goodId'] : '';
    $ImgUrl = isset($_GET['ImgUrl']) ? $_GET['ImgUrl'] : '';
    $Price = isset($_GET['Price']) ? $_GET['Price'] : '';
    $T = isset($_GET['T']) ? $_GET['T'] : '';
    $goodName = isset($_GET['goodName']) ? $_GET['goodName'] : '';
    $originalPrice = isset($_GET['originalPrice']) ? $_GET['originalPrice'] : '';
    $size = isset($_GET['size']) ? $_GET['size'] : '';


    if($state == "add"){
        $sql = "insert INTO product (goodId,Price,T,goodName,originalPrice,size) VALUES ($goodId,$Price,'$T','$goodName',$originalPrice,'$size')";
        $result = excute_oop($sql);
        // var_dump($sql);
        if ($result){
            $sql1 = "INSERT into productimg (goodId,ImgUrl) VALUES ($goodId,'$ImgUrl')";
            $result1 = excute_oop($sql1);
            if ($result1){
                echo 'ok';
            }
            else{
                echo 'false';
            }
        }
        else{
            echo 'false';
        }
    }else if($state == "del"){
        $sql = "delete product,productimg from product,productimg where product.goodId = productimg.goodId and product.goodId = $goodId";
        $result = excute_oop($sql);
        if ($result){
            echo 'ok';
        }
        else{
            echo 'false';
        }
    }else if($state == "search"){
        $num = ($page-1)*$limit;
        $sql="select product.goodId,product.goodName,product.originalPrice,product.Price,product.size,product.T,productimg.ImgUrl from product INNER JOIN productimg on productimg.goodId = product.goodId WHERE product.goodId LIKE '%$data%' OR product.goodName like '%$data%' limit $num,$limit";
        $sql.=" ;select FOUND_ROWS() as qty";
        $result = multi_query_oop($sql);
        if ($result){
            echo json_encode($result,JSON_UNESCAPED_UNICODE);
        }
        else{
            echo 'false';
        }

    }else if($state == "update"){
        $sql = "UPDATE product,productimg SET product.Price = '$Price',product.Price = '$Price',product.T = '$T',product.goodName = '$goodName',product.originalPrice = '$originalPrice',product.size = '$size',productimg.ImgUrl = '$ImgUrl' WHERE productimg.goodId = '$goodId' AND product.goodId = '$goodId'";
        $result = excute_oop($sql);
        if ($result){
            echo 'ok';
        }
        else{
            echo 'false';
        }
    }else{
        $num = ($page-1)*$limit;
        $sql="select product.goodId,product.goodName,product.originalPrice,product.Price,product.size,product.T,productimg.ImgUrl from product INNER JOIN productimg on productimg.goodId = product.goodId limit $num,$limit";
        $sql.=" ;select count(*) as qty from product";
        $result = multi_query_oop($sql);
        if ($result){
            echo json_encode($result,JSON_UNESCAPED_UNICODE);
        }
        else{
            echo 'false';
        }
    }
?>