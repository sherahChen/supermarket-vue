<template>
    <div id="sm_auto">
         <div class="auto_header">
            <mt-header title="选择配送地址">
                <mt-button icon="back" slot="left" @click="back">返回</mt-button>
        </mt-header> 
        </div> 
        <div class="auto_main">
            <div id="r-result">
              <input id="cityName" type="text" placeholder="请输入地址"/>
              <button class="btn"><i class="mintui mintui-search"></i></button>
            </div>
            <div class="local">
            <i class="glyphicon glyphicon-screenshot"></i>
            </div>
             <div id="allmap"></div>
        </div>
    </div>
</template>
<script type="text/javascript">
 import './autoAddress.scss'
 import spinner from "../spinnerComponent/spinner"
 import {MessageBox} from 'mint-ui';
  export default{

    data(){
        return {
          receiveID:this.$route.params.id,
          uid:this.$route.params.userId
        }
    },
    methods:{
       back(){
                this.$router.go(-1);
            }
    },
    mounted(){
      spinner.loadspinner();
      var self=this;
      var map = new BMap.Map("allmap");
      var point = new BMap.Point(113.27416, 23.133523);
      var geocoder= new BMap.Geocoder();
      map.centerAndZoom(point,11);
      // map.addEventListener("tilesloaded",function(){
      //      spinner.closeSpinner();
      // });
     map.enableScrollWheelZoom();
      //启用滚轮放大缩小，默认禁用
      map.enableContinuousZoom();
       //启用地图惯性拖拽，默认禁用
       currentAddress();
       // 当前地址
       // this.$store.commit('getSite');
      function currentAddress(){
          var geolocation = new BMap.Geolocation();
           geolocation.getCurrentPosition(function(r){
          if(this.getStatus() == BMAP_STATUS_SUCCESS){
            var mk = new BMap.Marker(r.point);
            map.addOverlay(mk);//
            map.panTo(r.point);
            geocoder.getLocation(r.point,rs=>{
                spinner.closeSpinner();
                 MessageBox.alert('你当前所在位置:'+rs.address).then(action => {});
              });
          }
          else {
            alert('failed'+this.getStatus());
          }
        },{enableHighAccuracy: true})
      }
      $('.local').click(()=>{
        currentAddress();
      });
       //获取搜索位置
      $('.btn').click(theLocation);
      function theLocation(){
        var city = document.getElementById("cityName").value;
        if(city != ""){
          map.centerAndZoom(city,11);// 用城市名设置地图中心点
        }
      }
      //给地图添加点击事件 获取点击时的地址
        map.addEventListener("click",(e)=>{
            this.$store.commit('selectSite',e,self);
            if(this.receiveID){
               this.$router.push({name:"addAddress",params:{id:this.receiveID}});
            }
            else{
              this.$router.push({name:"addAddress"})
            }


        });
        }
    }

</script>
