<?php
    header('Access-Control-Allow-Origin:*');
    header("Content-Type: text/html;charset=utf-8");
    include "DBHelper.php";

    $data= isset($_POST['data']) ? $_POST['data'] : "";
    $checkData=isset($_GET['checkData'])?$_GET['checkData']:'';
    $updata=isset($_POST['updata'])?$_POST['updata']:'';
    $receiveId=isset($_POST['receiveId'])?$_POST['receiveId']:'';
    $id=isset($_GET['id'])?$_GET['id']:'';
    $delId=isset($_POST['delId'])?$_POST['delId']:'';
    $uid=isset($_GET['uid'])?$_GET['uid']:'';
    if($data){
        $arr=changeArr($data);
        $key=implode(',',$arr[0]);
        $value=substr(json_encode($arr[1],JSON_UNESCAPED_UNICODE),1,-1);//去除[]
        $sql = "insert into address($key) values($value)";
        $result = multi_query_oop($sql);
        if($result){
            // 插入成功
            echo "true";
        }else{
            echo "false";
        }
    }
    if($checkData){
        $address=json_decode($checkData);
        $arr=array();
        // 转为$key='$value'的形式
        foreach($address as $key =>$val){
            $arr[]=$key."='".$val."'";
       }
        $sql = "select * from address where $arr[0] and $arr[1] and $arr[2] and $arr[3] and $arr[4] and $arr[5]";
        $sql.=";select FOUND_ROWS() as row;";
        $result=multi_query_oop($sql);
        echo json_encode($result, JSON_UNESCAPED_UNICODE);
    }
    if($id){
        $sql="select * from address where receiveId=$id";
         $result =query_oop($sql);
         echo json_encode($result, JSON_UNESCAPED_UNICODE);

    }
    if($updata){
        $newData=json_decode($updata);
        $arr=array();
        // 转为$key='$value'的形式
        foreach($newData as $key =>$val){
            $arr[]=$key."='".$val."'";
       }
       $data=implode(',',$arr);
       $sql="update address set $data where receiveId=$receiveId";
        $result =excute_oop($sql);
        if($result){
            // 插入成功
            echo "true";
        }else{
            echo "false";
        }
    }
    if($delId){
        $sql="delete from address where receiveId=$delId";
         $result =excute_oop($sql);
        if($result){
            // 插入成功
            echo "true";
        }else{
            echo "false";
        }
    }

    // key、value分别存放为两个数组
    function changeArr($data){
        $address=json_decode($data);//转对象
        $arrKey=array();
         $arrValue=array();
         foreach($address as $key =>$val){
             $arrKey[]=$key;
              $arrValue[]=$val;
        }

        return [$arrKey,$arrValue];

    }

?>
