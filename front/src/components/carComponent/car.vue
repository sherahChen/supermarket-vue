<template>
  <div class="car_cen">
    <div class="top">
      <mt-header title="购物车">
        <!-- <router-link to="/product" slot="left">
          <mt-button icon="back">返回</mt-button>
        </router-link> -->
        <mt-button slot="right" @click="empty">清空</mt-button>
      </mt-header>
    </div>
    <div class="prdItem">
      <div class="clear" v-if="carprd.length <= 0"> 购物车空空如也</div>
      <ul>
        <li v-for="(obj,idx) in carprd">
          <div class="prdImg">
            <!-- <input type="checkbox" checked  v-bind:id="obj.carId"  class="check" v-bind:value="obj.carId" v-model="checkedCarId" @click="checked($event)"> -->
            <input type="checkbox" class="check" :checked="obj.checkedstatus == 'true'"  @click="checked(obj.goodId,$event)">
            <img v-bind:src="obj.ImgUrl" alt="" @click.stop="ToDetailPage(obj.goodId,$event)">
          </div>
          <div class="prdinfor">
            <h3 @click.stop="ToDetailPage(obj.goodId,$event)">{{obj.goodName}}</h3>
            <h4>{{obj.describe}}</h4>
            <div class="prdprice">
              <span class="price">￥{{obj.Price}}</span>
              <p><span class="compute" @click="compute(obj.goodId,idx,$event)">-</span><span class="num">{{obj.count}}</span><span class="compute" @click="compute(obj.goodId,idx,$event)">+</span></p>
            </div>
          </div>
        </li>
      </ul>
      <div class="MayLike">
        <!-- <span>Checked names: {{ checkedCarId }}</span> -->
        <h1>猜你喜欢</h1>
        <ul>
          <li v-for="(obj,idx) in randomData" @click.stop="toDetailPage(obj.goodId,$event)">
            <img v-bind:src="obj.ImgUrl" alt="">
            <h4><span>￥{{obj.Price}}</span><span class="glyphicon glyphicon-shopping-cart"  @click.stop="addCar(obj.goodId)"></span></h4>
          </li>
        </ul>
      </div>
    </div>
    <div class="bottom">
      <div class="car">
        <div class="check">
          <label for="aa">
            <!-- <input type="checkbox" name="" id="aa"> -->
            已选 <span>{{this.$store.state.selectTotle || 0}}</span></label></div>
        <div class="price">￥{{this.$store.state.priceTotle}}</div>
        <div class="count"><button @click="toAccount">去结算</button></div>
      </div>
      <publicMenu></publicMenu>
    </div>
  </div>
</template>
<script>
import {Checklist, MessageBox} from 'mint-ui';
import publicMenu from '../publicMenuComponent/publicMenu'
import './car.scss';
import http from '../../utils/reqAjax';

export default {
  data: function(){
    return {
      randomData:[],
      userid:'',
      carprd:[],
      sum:'',
      url:'car1.php'
    }
  },
  mounted: function(){
    this.userid = this.$store.state.userId;
     if(this.userid == ''){
        MessageBox.confirm('用户未登录，是否去登录?').then(action => {
          if(action == 'confirm'){
            this.$router.push({name: 'login'})
          }
        });
      } else {
      this.ajax()
    }
    http.get({"url":'productListSort.php'+'?Sort="random"& state= 1'}).then ( res => {
       this.randomData = res.data;
    })
  },
  methods :{
    ajax(){
      // 请求用户购物车的商品
      http.post({"url":this.url,parmas:{userId: this.userid,state: 'selectproduct'}}).then ( res => {
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
      })
    },
    // 商品数量加减
    compute(idx,subItem,event){
      var target = event.target;
      // console.log(subItem)
      // 加
      if(target.innerText == '+'){
        // this.sum=(target.parentNode.childNodes[1].innerText*1)+1
        // console.log(this.sum)
        http.post({"url":this.url,parmas:{userId: this.userid,goodId:idx,state: 'addProductTotle'}}).then ( res => {
          // console.log(res.data)
          if( res.data == 'seccese'){
            target.parentNode.childNodes[1].innerHTML = (target.parentNode.childNodes[1].innerText*1)+1;
          }
        })
      // 减
      } else if( target.innerText == '-'){
        // 判断当小于一时提示是否删除
        if(target.parentNode.childNodes[1].innerText*1 >1){
          http.post({"url":this.url,parmas:{userId: this.userid,goodId:idx,state: 'subProductTotle'}}).then ( res => {
          // console.log(res.data)
            if( res.data == 'seccese'){
              target.parentNode.childNodes[1].innerHTML = (target.parentNode.childNodes[1].innerText*1)-1;
            }
          })
        } else {
          // 删除商品
          MessageBox({
            title: '提示',
            message: '是否从购物车中删除?',
            showCancelButton: true
          }).then(confirm => {
            console.log(confirm)
            if(confirm == 'confirm'){
              http.post({"url":this.url,parmas:{userId: this.userid,goodId:idx,state: 'delProduct'}}).then ( res => {
                // console.log(this.carprd.splice(aa, 1));
                this.carprd.splice(subItem, 1);
                this.ajax();
              })
            }
          });
        }
      }
      this.ajax()
    },
    toDetailPage(obj,_event){
      if(!_event.target.id){
         this.$store.commit("getDetailsIdState",obj);
        this.$router.push({ name: 'detailpage',params: {id:obj}});
      }
    },
    ToDetailPage(obj,_event){
      // console.log(_event.target.tagName)
       this.$store.commit("getDetailsIdState",obj);
      this.$router.push({ name: 'detailpage',params: {id: obj}});
      // if(_event.target.tagName !== 'P' || _event.target.tagName !== 'INPUT'){
        // console.log(666)
      // }
    },
    checked(idx,eve){
      if(eve.target.checked == true){
        // console.log('true')
        http.post({"url": this.url,parmas:{userId: this.userid,goodId:idx,state: 'changestate',changestate: 'true'}}).then ( res => {
          // console.log(res.data);
          this.ajax()
          //  this.carprd = res.data;
        })
      } else {
        // console.log('false');
        http.post({"url": this.url,parmas:{userId: this.userid,goodId:idx,state: 'changestate',changestate: 'false'}}).then ( res => {
          // console.log(res.data);
          this.ajax();
        })
      }

    },
    // 清空购物车
    empty(){
      MessageBox({
        title: '提示',
        message: '确定清空购物车?',
        showCancelButton: true
      }).then(confirm => {
        if(confirm == 'confirm'){
          http.post({"url": this.url,parmas:{userId: this.userid,state: 'emptycart'}}).then ( res => {
          // console.log(res.data)
          this.carprd = [];
        })
        }
      });
    },
    addCar(id){
      if(this.userid == ''){
        MessageBox.confirm('用户未登录，是否去登录?').then(action => {
          if(action == 'confirm'){
            this.$router.push({name: 'login'})
          }
        });
      } else {
        // console.log(666);
        http.post({"url":this.url,parmas:{userId: this.userid,goodId:id,state: 'addProduct'}}).then ( res => {
          // console.log(this.carprd.splice(aa, 1));
        if( res.data == 'seccese'){
            this.ajax();
          }
        })
      }
    },
    toAccount(){
      if(this.userid == ''){
        MessageBox.confirm('用户未登录，是否去登录?').then(action => {
          if(action == 'confirm'){
            this.$router.push({name: 'login'})
          }
        });
      } else {

        var totle =0;
        http.post({"url":this.url,parmas:{userId: this.userid,state: 'selectproduct'}}).then ( res => {
          // console.log(res.data)
          this.goods = res.data;
          for(var i=0; i< this.goods.length; i++){
            // console.log(res.data[i].checkedstatus)
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

      }
    }
  },
  computed: {
  },
  watch: {

  },
  components: {
    publicMenu
  }
}
</script>
