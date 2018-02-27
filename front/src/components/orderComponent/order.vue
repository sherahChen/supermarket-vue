<template>
    <div id="order">
        <mt-header title="我的订单">
            <mt-button slot="left" icon="back" @click="goback"></mt-button>
        </mt-header>
        <mt-navbar v-model="selected">
            <mt-tab-item id="obligation"><span @click="checkedClick(0)">待付款</span></mt-tab-item>
            <mt-tab-item id="noReceive"><span @click="checkedClick(1)">待收货</span></mt-tab-item>
            <mt-tab-item id="noEvaluation"><span @click="checkedClick(2)">待评价</span></mt-tab-item>
            <mt-tab-item id="allOrders"><span @click="checkedClick(3)">全部订单</span></mt-tab-item>
        </mt-navbar>
        <div id="orderlist">
            <div v-for="(arr,key) in dataobj" :key="key" @click="btn(key,$event)">
                <div>
                    <span>{{arr[0].status == 0 ? "待付款" : arr[0].status == 1 ? "待收货" :  arr[0].status == 2 ? "待评价" : arr[0].status == 3 ? "已完成" : "已取消"}}</span>
                    <span>{{arr[0].time}}</span>
                    <i class="iconfont icon-shanchu" v-if="arr[0].status == 2 || arr[0].status == 3 || arr[0].status == 4"></i>
                    <i class="iconfont icon-right" v-if="arr[0].status == 0 || arr[0].status == 1"></i>
                </div>
                <div>
                    <img :src="arr[0].ImgUrl" alt="">
                    <div>
                        <div v-for="(obj,idx) in arr" :key="idx">
                            <span>{{obj.goodName}}</span>
                            <span class="orderqty">{{"x"+obj.qty}}</span>
                        </div>
                    </div>
                </div>
                <p>共 {{dataPrice[key].qty}} 份，实付 {{"￥" + dataPrice[key].price.toFixed(2)}}</p>
                <button>{{arr[0].status == 0 ? "去支付" : arr[0].status == 1 ? "确认收货" : arr[0].status == 2 ? "去评价" :  "再来一单"}}</button>
            </div>
        </div>

    </div>
</template>

<script>
    import { Navbar, TabItem, MessageBox, Cell } from 'mint-ui';
    import http from "../../utils/reqAjax"
    import spinner from "../spinnerComponent/spinner";
    import "./order.scss"
    export default {
        data(){
            return{
                selected:"",
                data:[],
                dataset:[],
                dataobj:{},
                show:true,
                dataPrice:{}
            }
        },
        mounted(){
            this.dataobj = {};
            this.data = [];
            this.dataset = [];
            this.dataPrice = {};
            var num = this.$route.params.num || this.$store.state.orderNum;
            this.refresh(num*1);
            
        },
        methods:{
            goback(){
                this.$router.push("/my");
            },
            checkedClick(val){
                this.dataobj = {};
                this.dataset = [];
                this.dataPrice = {};
                this.$store.commit('setOrderNum',val);
                $(".mint-tab-item").eq(val).siblings().removeClass("is-selected");
                this.switchF(val);
            },
            refresh(num){
                this.dataobj = {};
                this.dataset = [];
                this.dataPrice = {};
                 // 请求所有数据
                  spinner.loadspinner();
                http.get({'url':"order.php?userId=" + this.$store.state.userId + "&state=" + 'get'}).then(res=>{
                    spinner.closeSpinner();
                    this.data = res.data;
                    $(".mint-tab-item").eq(num).addClass("is-selected");
                    var status;
                    this.checkedClick(num);
                })
            },
            switchF(val){
                var status;
                switch(val){
                    case 0:
                        status = 0;
                        this.assignment(0);
                        break;
                    case 1:
                        status = 1;
                        this.assignment(1);
                        break;
                    case 2:
                        status = 2;
                        this.assignment(2);
                        break;
                    case 3:
                        status = "";
                        // 将orderId且goodId相同的数据整合
                        this.data.forEach(function(item,index){
                            if(this.dataset.length == 0){
                                item.qty = 1;
                                this.dataset.push(item);
                            }else{
                                for(var i=0;i<this.dataset.length;i++){
                                    if(this.dataset[i].goodId == item.goodId && this.dataset[i].orderId == item.orderId){
                                        this.dataset[i].qty++;
                                        break;
                                    }else{
                                        item.qty = 1;
                                        this.dataset.push(item);
                                        break;
                                    }
                                }
                            }
                        }.bind(this))
                        // 将同一orderId的订单整理在一起
                        this.dataset.forEach(function(item,index){
                            if(!this.dataobj[item.orderId]){
                                this.dataobj[item.orderId] = [item];
                            }else{
                                this.dataobj[item.orderId].push(item);
                            }
                        }.bind(this))
                        for(var key in this.dataobj){
                            for(var i=0;i<this.dataobj[key].length;i++){
                                if(this.dataPrice[key]){
                                    this.dataPrice[key].qty += this.dataobj[key][i].qty;
                                    this.dataPrice[key].price += this.dataobj[key][i].qty * this.dataobj[key][i].Price;
                                }else{
                                    this.dataPrice[key] = {qty:this.dataobj[key][i].qty,price:this.dataobj[key][i].qty * this.dataobj[key][i].Price};
                                }
                            }
                        }
                        break;
                    default:
                        break;
                }
            },
            assignment(val){
                // 将orderId且goodId相同的数据整合
                this.data.forEach(function(item,index){
                    if(item.status == val){
                        if(this.dataset.length == 0){
                            item.qty = 1;
                            this.dataset.push(item);
                        }else{
                            for(var i=0;i<this.dataset.length;i++){
                                if(this.dataset[i].goodId == item.goodId && this.dataset[i].orderId == item.orderId){
                                    this.dataset[i].qty++;
                                    break;
                                }else{
                                    item.qty = 1;
                                    this.dataset.push(item);
                                    break;
                                }
                            }
                        }
                    }
                }.bind(this))
                // 将同一orderId的订单整合在一起
                this.dataset.forEach(function(item,index){
                    if(!this.dataobj[item.orderId]){
                        this.dataobj[item.orderId] = [item];
                    }else{
                        this.dataobj[item.orderId].push(item);
                    }
                }.bind(this))
                for(var key in this.dataobj){
                    for(var i=0;i<this.dataobj[key].length;i++){
                        if(this.dataPrice[key]){
                            this.dataPrice[key].qty += this.dataobj[key][i].qty;
                            this.dataPrice[key].price += this.dataobj[key][i].qty * this.dataobj[key][i].Price;
                        }else{
                            this.dataPrice[key] = {qty:this.dataobj[key][i].qty,price:this.dataobj[key][i].qty * this.dataobj[key][i].Price};
                        }
                    }
                }
            },
            btn(val,event){
                if(event.target.innerText == "去支付"){
                    this.$router.push({name:'pay',params:{orderId:val,price:this.dataPrice[val].price}});
                }else if(event.target.innerText == "取消订单"){
                    MessageBox.confirm('确定执行此操作?').then(action => {
                        this.data.forEach(function(item,index){
                            if(item.orderId == val){
                                item.status = 4;
                            }
                        }.bind(this))
                        this.checkedClick(3);
                        http.get({url:"order.php?phone=" + this.$store.state.phoneNum + "&state=update&status=4&orderId=" + val}).then(res=>{
                            // console.log(res)
                        })
                    })
                }else if(event.target.className == "iconfont icon-shanchu"){
                    MessageBox.confirm('确定执行此操作?').then(action => {
                        var phone = this.$store.state.phoneNum;
                        this.data.forEach(function(item,index){
                            if(item.orderId == val){
                                this.data.splice(index,1);
                            }
                        }.bind(this))
                        this.checkedClick(3);
                        http.get({url:"order.php?phone=" + this.$store.state.phoneNum + "&state=del&orderId=" + val}).then(res=>{
                            // console.log(res)
                        })
                    })

                }else{
                    this.$store.commit('setOrderId',val);
                    this.$router.push({name:"orderdetail"});
                }
            },

        }
    }
</script>

