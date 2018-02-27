<template>
  <div class="product_cen">
    <div class="top">
      <mt-header>
        <!-- <router-link to="/category" > -->
          <mt-button icon="back" slot="left" @click="back">返回</mt-button>
        <!-- </router-link> -->
      </mt-header>
      <span class="glyphicon glyphicon-home" @click="toHome"></span>
      <input type="text"  placeholder="搜索" class="serch" @focus="toSerch">
      <productMenu v-bind:SmallId="name"></productMenu>
    </div>
    <div class="product_menu">
      <div v-for="(obj,key) in dataset" class="goodItem" @click.stop="toDetailPage(obj.goodId,$event)" :key="key">
        <div class="left_img">
          <img v-lazy="obj.ImgUrl" alt="加载中"/>
        </div>
        <div class="right_prd_mess">
          <h3 class="goodName">{{obj.goodName}}</h3>
          <h4 class="goodDescribe">{{obj.describe}}</h4>
          <h4 class="goodSize"><span>{{obj.size}}</span></h4>
          <h4><span class="goodPre">￥{{obj.Price}}</span><span class="goodOrgpre">￥{{obj.originalPrice}}</span><button class="buy" @click="addCar(obj.goodId,$event)">立即购买</button></h4>
        </div>
      </div>
    </div>
    <div class="addCar">
      <div class="carIcom" @click="toCar"><i class="glyphicon glyphicon-shopping-cart"></i><span class="carNum"  v-if="carNum">{{carNum}}</span></div><div class="prdNum">已选<span>{{this.$store.state.selectTotle|| 0}}</span></div><div class="prdprice"><span>￥{{this.$store.state.priceTotle}}</span></div><div class="account"><button @click="ToAccount">去结算</button></div>
    </div>
  </div>
</template>

<script>

import http from '../../utils/reqAjax';
import './productList.scss';
import productMenu from './productMenu';
import spinner from "../spinnerComponent/spinner";
import { Search, MessageBox, Lazyload } from 'mint-ui';

export default {
  data: function(){
    return {
      categoryId:'',
      url:"productList.php",
      dataset:[],
      name:'',
      carNum:0,
      prdNum:0,
      prdPrice:0,
      userid:'',
      categoryName:'',
      state:''
    }
  },
  mounted(){
    this.userid = this.$store.state.userId;
    this.prdNum = this.$store.state.selectTotle;
    this.prdPrice =  this.$store.state.priceTotle;
    // console.log('id',this.$route.params.id)

    this.categoryId = this.$route.params.id;
    this.categoryName = this.$route.params.catename;
    this.name = this.$route.params.name;
    this.state = this.$route.params.state;
    // console.log('categoryId',this.categoryId);
    // console.log('categoryName',this.categoryName);
    // console.log('name',this.name);
    // console.log('state',this.state)
    if(this.state == 'home'){
      this.ajax(this.categoryId,'bigCategory')
      this.name = this.categoryName
    } else if( this.state == 'serch'){
      this.ajax(this.categoryName,'search')
      this.name = this.categoryName

    } else if( this.state == 'cate'){
      this.ajax(this.categoryId,'small');
      this.name = this.categoryName;
    } else  if( this.state == undefined) {
      this.ajax();
    }

    http.post({"url":'car1.php',parmas:{userId: this.userid,state: 'selectprdCount'}}).then ( res => {
      this.carNum = res.data[0].totle;
      // this.prdPrice = res.data[0].Price;
    })
    this.ajaxCar()
  },
  computed: {
  },
  methods:{
    // 二次封装ajax请求
    ajax(_param,state){
      spinner.loadspinner();
      if(_param,state){
        http.get({"url":this.url+'?categoryId='+_param+"&state="+state}).then ( res => {
          this.dataset = res.data;
          spinner.closeSpinner();
        })
      } else {
        http.get({"url":this.url}).then ( res => {
          this.dataset = res.data;
          spinner.closeSpinner();
        })
      }
    },
    ajaxCar(){
      // 请求用户购物车的商品
      spinner.loadspinner();
      if(this.userid == ''){

      } else {
        http.post({"url":'car1.php',parmas:{userId: this.userid,state: 'selectproduct'}}).then ( res => {
            // console.log(res.data)
            this.carprd = res.data;
            var selectTotle=0;
            var priceTotle = 0;
            for(var i=0; i< res.data.length; i++){
              if(res.data[i].checkedstatus == 'true'){
                selectTotle += res.data[i].count*1;
                priceTotle += res.data[i].Price*1*res.data[i].count*1;
                // console.log('i',i,priceTotle)
              }
            }
            this.$store.commit("getSelectTotle",selectTotle)
            this.$store.commit("getPriceTotle",priceTotle.toFixed(2));
            // console.log('a',this.$store.state.priceTotle)
            spinner.closeSpinner();
          })
      }
    },
    addCar(obj,e){
      // console.log(e.screenX)
      if(this.userid == ''){
        MessageBox.confirm('用户未登录，是否去登录?').then(action => {
          if(action == 'confirm'){
            this.$router.push({name: 'login'})
          }
        });
      } else {
        
        spinner.loadspinner();
        // console.log(obj);
        http.post({"url":'Car.php',parmas:{userid: this.userid,goodId:obj}}).then ( res => {
          // console.log(res.data[0].Price)
          
          var icom = $('<span/>').addClass('icon').css({top: e.clientY,left: e.clientX})
          $(e.target).closest('.right_prd_mess').append(icom);
          $('.icon').animate({top:'95%',left:30},500,function(){
            $('.icon').remove();
            this.carNum = res.data[0].totle;
            this.prdPrice = res.data[0].Price;
          }.bind(this))
          spinner.closeSpinner();
        })
      // this.carNum  += this.carNum;
      }

    },
    toDetailPage(prdId,_event){
      // console.log()
      if(_event.target.tagName !== 'BUTTON'){
         this.$store.commit("getDetailsIdState",prdId);
        this.$router.push({ name: 'detailpage',params: {id: prdId}});
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
    ToAccount(){
      if(this.userid == ''){
        MessageBox.confirm('用户未登录，是否去登录?').then(action => {
          if(action == 'confirm'){
            this.$router.push({name: 'login'})
          }
        });
      } else {
        var totle =0;
        http.post({"url": 'car1.php',parmas:{userId: this.userid,state: 'selectproduct'}}).then ( res => {
          // console.log(res.data)
          this.goods = res.data;
          for(var i=0; i< this.goods.length; i++){
            console.log('aa',res.data[i].checkedstatus)
            if(res.data[i].checkedstatus == 'true'){
              totle++;
            }
          }
          console.log('totle',totle)
          if(totle <= 0){
            MessageBox('提示', '你还未选择商品');
          } else {
            this.$router.push({ name: 'account'});
          }
        });
      // this.$router.push({name: 'account'});
      }
    },
    toHome(){
      this.$router.push({ name: 'home'});
    },
    toSerch(){
      this.$router.push({ name: 'search'});
    },
    back(){
      this.$router.go(-1)
    }
  },
  watch: {
    // 监听子组件是否改变categoryId
    categoryId: function( newval, oldval){
      // console.log(newval,oldval);
      // if(this.categoryId !== undefined){
      //   this.ajax(this.categoryId,'small')
      // }
    }
  },
  components:{
    productMenu
  }
}
</script>
