<template>
    <div class="detail_cen">
      <div class="top">
        <mt-header title="商品详情">
          <!-- <router-link to="/product" > -->
            <mt-button icon="back" @click="back" slot="left">返回</mt-button>
          <!-- </router-link> -->
          <mt-button icon="more" slot="right"></mt-button>
        </mt-header>
        <!-- <productMenu v-bind:SmallId="name"></productMenu> -->
      </div>
      <div class="bottom">
        <div class="prdInfor">
          <div class="prdImg">
            <img v-bind:src="dataItem.ImgUrl" alt="加载中"/>
            <h2>{{dataItem.goodName}}</h2>
            <h3>{{dataItem.describe}}</h3>
            <h4>￥<span>{{dataItem.Price}}</span>/￥{{dataItem.originalPrice}}</h4>
          </div>
          <ul>
            <li><i class="glyphicon glyphicon-gift"></i><span>{{dataItem.size}}</span></li>
            <li><i class="glyphicon glyphicon-map-marker"></i><span>{{dataItem.productionAddress}}</span></li>
            <li><i class="glyphicon glyphicon-tint"></i> <span>{{dataItem.T}}</span></li>
          </ul>
        </div>
        <div class="more">
          <h1><span>更多选择</span> </h1>
          <ul>
            <li v-for="(obj, idx) in randomData"  @click.stop="toDetailPage(obj.goodId,$event)">
                <img v-bind:src="obj.ImgUrl" alt="">
                <h2>{{obj.goodName}}</h2>
                <h4><span>￥{{obj.Price}}</span><span class="glyphicon glyphicon-shopping-cart"  v-bind:id="idx"></span></h4>
            </li>
        </ul>
        </div>
        <div class="deteils">
          <h1><span>商品详情</span></h1>
          <ul>
            <li><img src="../../assets/common/product_details_footer6.jpg" alt=""></li>
          </ul>
        </div>
      </div>
      <div class="addCar">
        <div class="carIcom" @click="toCar">
          <i class="glyphicon glyphicon-shopping-cart"></i>
          <span>购物车</span>
          <span class="carNum" v-if="carNum">{{carNum}}</span>
        </div>
        <div class="prdNum" @click="addCollect"><i class="glyphicon " :class="className"></i><span>收藏</span></div>
        <div class="account"><button @click="addCar(dataItem.goodId)">加入购物车</button></div>
        </div>
      </div>
</template>
<script>
import './detailPage.scss';
import http from '../../utils/reqAjax';
import {MessageBox} from 'mint-ui';
import spinner from "../spinnerComponent/spinner";

export default {
  data: function(){
    return {
      dataItem:'',
      randomData:[],
      userid: '',
      className:'glyphicon-star-empty',
      id:'',
      carNum:0
    }
  },
  mounted(){
    this.userid = this.$store.state.userId;
    // this.dataItem = this.$route.params;
    // console.log(this.$route.params.id);
    this.id =  this.$store.state.detailsId;
    http.get({"url":'productListSort.php'+'?Sort="random"& state= 1'}).then ( res => {
      this.randomData = res.data;
      // console.log(res.data)
    })
    spinner.loadspinner();
      http.post({"url":'getProduct.php',parmas:{goodId:  this.id,state:'select'}}).then ( res => {
        // console.log('item',res.data[0]);
        this.dataItem = res.data[0];
        spinner.closeSpinner();
        //  console.log('aa',this.dataItem)
        http.post({"url":'collect.php',parmas:{userid: this.userid,goodId:this.dataItem.goodId,state:'select'}}).then ( res => {
            // console.log(res.data);
            // if(res.data.length > 1){
            //   this.className = 'glyphicon-star'
            // }
            if(res.data == 'ok'){
              this.className = 'glyphicon-star'
            }
            // spinner.closeSpinner();
        })
    });

     http.post({"url":'car1.php',parmas:{userId: this.userid,state: 'selectprdCount'}}).then ( res => {
      this.carNum = res.data[0].totle;
      // this.prdPrice = res.data[0].Price;
    })
  },
  methods: {
    back(){
      this.$router.go(-1)
    },
    toDetailPage(id,_event){
      // console.log(id)
      this.id = id;
      if(!_event.target.id){
         this.$store.commit("getDetailsIdState",id);
        this.$router.push({ name: 'detailpage',params:{id: this.id }});
        this.ajaxProduct()
      } else {
        this.addCar(id)
      }
    },
    ajaxProduct(){
      spinner.loadspinner();
        http.post({"url":'getProduct.php',parmas:{goodId:  this.id,state:'select'}}).then ( res => {
          console.log('item',res.data[0]);
          this.dataItem = res.data[0];
          spinner.closeSpinner();
      });
    },
    addCar(obj){
       if(this.userid == ''){
        MessageBox.confirm('用户未登录，是否去登录?').then(action => {
          if(action == 'confirm'){
            this.$router.push({name: 'login'})
          }
        });
      } else {
      spinner.loadspinner();
      MessageBox.alert('成功加入购物车').then(action => {
        http.post({"url":'Car.php',parmas:{userid: this.userid,goodId:obj}}).then ( res => {
          this.carNum = res.data[0].totle;
          spinner.closeSpinner();
        })
      });
      
      }
    },
    toCar(){
       if(this.userid == ''){
        MessageBox.confirm('用户未登录，是否去登录?').then(action => {
          if(action == 'confirm'){
            this.$router.push({name: 'login'})
          }
        });
      } else {
      this.$router.push({ name: 'car'});
      }
    },
    addCollect(){
      if(this.userid == ''){
        MessageBox.confirm('用户未登录，是否去登录?').then(action => {
          if(action == 'confirm'){
            this.$router.push({name: 'login'})
          }
        });
      } else {
      spinner.loadspinner();
      if(this.className == 'glyphicon-star'){
        // console.log(666)
        http.post({'url': 'collect.php',parmas:{userid: this.userid,goodId: this.dataItem.goodId,state: 'delete'}}).then ( res => {
          console.log(res.data)
          if(res.data == 'delete'){
            MessageBox.alert('已取消收藏').then(action => {
              // console.log(action);
              this.className = 'glyphicon-star-empty';
              spinner.closeSpinner();
            });
          }
        })

      } else if(this.className == 'glyphicon-star-empty'){
        http.post({"url":'collect.php',parmas:{userid: this.userid,goodId:this.dataItem.goodId,state:'insert'}}).then ( res => {
          // console.log(res.data);
          if(res.data == 'ok'){
            MessageBox.alert('收藏成功').then(action => {
              // console.log(action);
              this.className = 'glyphicon-star'
              spinner.closeSpinner();
            });
          }
          // this.carNum = res.data[0].totle;
          // this.prdPrice = res.data[0].Price;
        })
      }
      }
    }
  }
}
</script>
