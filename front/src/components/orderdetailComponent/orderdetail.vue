<template>
    <div id="orderdetail">
        <mt-header title="订单详情页">
            <mt-button icon="back" slot="left" @click="goback"></mt-button>
            <mt-button slot="right" class="iconfont icon-zaixiankefu"></mt-button>
        </mt-header>
        <div class="goodsMessage">
            <p>商品信息 :</p>
            <div v-for="(obj, idx) in dataset" :key="idx">
                <div>
                    <img :src="obj.ImgUrl">
                    <div>
                        <p>{{obj.goodName}} <span>{{"￥" + obj.Price}}</span></p>
                        <span>{{"x" + obj.qty}}</span>
                    </div>
                </div>
            </div>
            <span>合计：{{"￥" + price}}</span>
        </div>
        <div class="addressMessage">
            <p>配送信息 :</p>
            <p>收货人：<span>{{linkMan}}({{gender}})</span><span>{{phone}}</span></p>
            <p>收货地址：<span>{{village + doorplate}}</span></p>
        </div>
        <div class="orderMessage">
            <p>订单信息 :</p>
            <p>订单号：{{$store.state.orderId}}</p>
            <p>下单时间：{{time}}</p>
        </div>
        <div class="pay">
            <mt-button type="primary" @click="update" class="payBtn">{{status == 0 || status == 1 ? "取消订单" : "删除订单"}}</mt-button>
            <mt-button type="primary" @click="pay"  class="payMoney" v-if="status == 3 || status == 4 ? false : true">{{status == 0 ? "去支付" : status == 1 ? "确认收货" : "去评价"}}</mt-button>
        </div>
    </div>
</template>

<script>
    import './orderdetail.scss'
    import http from "../../utils/reqAjax"
    import { Header,Button,MessageBox } from 'mint-ui';
    export default {
        data(){
            return{
                dataset:[],
                price:'',
                time:"",
                linkMan:"",
                gender:"",
                village:"",
                doorplate:"",
                status:"",
                phone:""
            }
        },
        mounted(){
            http.get({url:"getAddress.php?phone=" + this.$store.state.phoneNum + "&orderId=" + this.$store.state.orderId}).then(res=>{
                var arr = res.data;
                var arr1 = [];
                // 将orderId且goodId相同的数据整合
                arr.forEach(function(item,index){
                    if(arr1.length == 0){
                        item.qty = 1;
                        arr1.push(item);
                        this.price = 1 * item.Price;
                        this.time = item.time;
                        this.linkMan = item.linkMan;
                        this.gender = item.gender;
                        this.village = item.village;
                        this.doorplate = item.doorplate;
                        this.phone = item.phone;
                        this.status = item.status;
                    }else{
                        for(var i=0;i<arr1.length;i++){
                            if(arr1[i].goodId == item.goodId && arr1[i].orderId == item.orderId){
                                arr1[i].qty++;
                                this.price += item.Price * 1;
                                break;
                            }else{
                                item.qty = 1;
                                this.price += item.Price * 1;
                                arr1.push(item);
                                break;
                            }
                        }
                    }
                }.bind(this))
                this.dataset = arr1;

            })
        },
        methods:{
            goback(){
                this.$router.go(-1);
            },
            update(){
                MessageBox.confirm('确定执行此操作?').then(action => {
                    var state;
                    var status;
                    if($('.payBtn').text() == '取消订单'){
                        state = 'update';
                        status = 4;
                    }else if($('.payBtn').text() == '删除订单'){
                        http.get({url:"order.php?phone=" + this.$store.state.phoneNum + "&state=del&orderId=" + this.$store.state.orderId}).then(res=>{
                            if(res.data == 'ok'){
                                this.$router.go(-1);
                            }
                        })
                        return;
                    }
                    http.get({url:"order.php?phone=" + this.$store.state.phoneNum + "&state=" + state + "&status=" + status + "&orderId=" + this.$store.state.orderId}).then(res=>{
                        if(res.data == 'ok'){
                            this.$router.go(-1);
                        }
                    })
                });
            },
            pay(){
                var state;
                var status;
                if($('.payMoney').text() == '确认收货'){
                    state = 'update';
                    status = 2;
                }else if($('.payMoney').text() == '去支付'){
                    this.$router.push({name:'pay',params:{orderId:this.$store.state.orderId,price:this.price}});
                }
                // else if($('.payMoney').text() == '去评价'){
                //     this.$router.push({name:'pay',params:{orderId:this.$store.state.orderId,price:this.price}});
                // }
                 http.get({url:"order.php?phone=" + this.$store.state.phoneNum + "&state=" + state + "&status=" + status + "&orderId=" + this.$store.state.orderId}).then(res=>{
                    if(res.data == 'ok'){
                        this.$router.go(-1);
                    }
                })
                
            }
        }
    
    }
</script>

