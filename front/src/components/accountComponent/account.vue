<template>
  <div class="account_cen">
    <div class="top">
      <mt-header title="确认订单">
        <mt-button icon="back" slot="left" @click="back">返回</mt-button>
      </mt-header>
    </div>
    <div class="account">
      <div class="address" @click="toAddress">
        <i class="glyphicon glyphicon-map-marker"></i>
        <h4>收货人：{{userAddress.linkMan}}{{userAddress.gender}} <span>{{userAddress.phone}}</span></h4>
        <p>收货地址:  {{userAddress.village}}</p>
        <i class="glyphicon glyphicon-chevron-right"></i>
      </div>
      <div class="prdItem">
        <h3>确认商品:<span>共计1件商品</span></h3>
        <ul>
          <li v-for="obj in goods">
            <div class="left">
               <img v-bind:src="obj.ImgUrl" alt="">
            </div>
            <div class="center">
              <p>{{obj.goodName}}</p>
              <span>{{obj.size}}</span>
            </div>
            <div class="rigth">
              <p>￥{{obj.Price}}</p>
              <span>X{{obj.count}}</span>
            </div>
          </li>
        </ul>
        <div class="totle">
          <h4>小计<span>￥{{sum}}</span></h4>
          <h4>配送费<span>￥10.00</span></h4>
          <h4>合计<span>￥{{totle}}</span></h4>
          <h4 style="height:1.33rem;">留言：<input type="text" placeholder="买家留言" v-model="leveword"></h4>
        </div>
      </div>
    </div>
    <div class="bottom">
      <div class="priceTotle">合计：￥{{totle}}</div>
      <div class="pay">
        <button @click="toPay">去支付</button>
      </div>
    </div>
  </div>
</template>
<script>
import { Cell } from 'mint-ui';
import http from '../../utils/reqAjax';
import './account.scss'
export default {
  data: function(){
    return {
      url:'account.php',
      userid:'',
      userAddress:[],
      goods: [],
      sum:0,
      totle:0,
      leveword:''
    }
  },
  mounted: function(){
    this.userid = this.$store.state.userId;
    http.post({"url":this.url,parmas:{userId: this.userid,state: 'selectaddress'}}).then ( res => {
      console.log('userAddress',res.data)
      if(res.data == 'fail'){
        this.$router.push({name: 'getAddress'})
      } else {
        this.userAddress = res.data[0];
      }
    });
    http.post({"url":this.url,parmas:{userId: this.userid,state: 'selectproduct'}}).then ( res => {
      console.log(res.data)
      this.goods = res.data;
      for(var i=0; i< this.goods.length; i++){
        this.sum += res.data[i].Price*1*res.data[i].count;
      }
      this.sum = this.sum.toFixed(2);
      this.totle = this.sum*1 + 10;
    });
  },
  methods :{
    back(){
      this.$router.go(-1);
    },
    toAddress(){
      // console.log(666);
      this.$router.push({ name: 'getAddress'});
    },
    toPay(){
      var timestamp = (new Date()).valueOf();
      var goodsId = [];
      // console.log('timestamp',timestamp);
      // console.log('user',this.$store.state.userId);
      for(var i=0; i<this.goods.length; i++){
        goodsId.push(this.goods[i].goodId)
      }
      // console.log(this.leveword)
      // console.log('goodsId', goodsId)
      http.post({"url":this.url,parmas:{orderId:timestamp,userId: this.$store.state.userId,goodsId: goodsId,leaveword: this.leveword,state: 'inserproduct'}}).then ( res => {
        // console.log(res.data)
        this.$router.push({name: 'pay',params:{orderId: timestamp,totle:  this.totle}});
      });
      http.post({"url":this.url,parmas:{userId: this.userid,state: 'deleteproduct'}}).then ( res => {
        console.log(res.data)
      });
    }
  },
  computed: {
  },
  watch: {

  },
  components: {
  }
}
</script>
