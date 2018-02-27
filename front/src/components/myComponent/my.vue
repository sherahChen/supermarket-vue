<template>
    <div id="myCenter">
        <div class="top">
            <div class="myhead" style="background-image: url('../../src/assets/img/my/myhead.jpg');background-size:100% 100%;">
                <img :src="imgUrl" class="img">
                <div v-if="!type">
                    <button @click="Lregister">登录/注册</button>
                </div>
                <div v-if="type">
                    <span>{{userNum ? userNum : phoneNum}}</span><br>
                    <span>{{this.$store.state.phoneNum}}</span>
                </div>
                <i class="glyphicon glyphicon-cog" @click="setting"></i>
            </div>
            <div class="order">
                <ul>
                    <li id="dd" @click="order($event,'0')"><i class="glyphicon glyphicon-usd"></i><br><span>待付款</span><span class="number" v-if="obligation">{{obligation}}</span></li>
                    <li @click="order($event,'1')"><i class="glyphicon glyphicon-gift"></i><br><span>待收货</span><span class="number" v-if="receipt">{{receipt}}</span></li>
                    <li @click="order($event,'2')"><i class="glyphicon glyphicon-pencil"></i><br><span>待评价</span><span class="number" v-if="evaluate">{{evaluate}}</span></li>
                    <li @click="order($event,'3')"><i class="glyphicon glyphicon-list-alt"></i><br><span>全部订单</span><span class="number" v-if="allOrder">{{allOrder}}</span></li>
                </ul>
            </div>
            <div class="receiving"  @click="collect($event)">
                <mt-cell title="收货地址" is-link id="address">
                    <i slot="icon" class="iconfont icon-weibiaoti2fuzhi08"></i>
                </mt-cell>

                <mt-cell title="优惠券" is-link>
                    <i slot="icon" class="iconfont icon-youhuiquan"></i>
                </mt-cell>

                <mt-cell title="发票与报销" is-link>
                    <i slot="icon" class="iconfont icon-fapiao"></i>
                </mt-cell>

                <mt-cell title="我的收藏" is-link id="col">
                    <i slot="icon" class="iconfont icon-icowodeshoucang"></i>
                </mt-cell>

                <mt-cell title="到货提醒" is-link>
                    <i slot="icon" class="iconfont icon-iconfontzhizuobiaozhun41" style="font-size:.3rem;"></i>
                </mt-cell>
            </div>
            <div class="introduce">
                <mt-cell title="邀请好友" is-link>
                    <span style="color:#fc0;">送好友188元，自得88元券</span>
                    <i slot="icon" class="iconfont icon-yaoqinghaoyou"></i>
                </mt-cell>
                <mt-cell title="配送时间说明" is-link>
                    <i slot="icon" class="iconfont icon-shijian"></i>
                </mt-cell>
                <mt-cell title="在线客服" is-link>
                    <i slot="icon" class="iconfont icon-zaixiankefu"></i>
                </mt-cell>
                <mt-cell title="帮助与反馈" is-link>
                    <i slot="icon" class="iconfont icon-bangzhu"></i>
                </mt-cell>
                <mt-cell title="招聘" is-link>
                    <i slot="icon" class="iconfont icon-msnui-job"></i>
                </mt-cell>
                <mt-cell title="分享" is-link>
                    <i slot="icon" class="iconfont icon-iconfontzhizuobiaozhun20"></i>
                </mt-cell>
            </div>
            <div class="quit">
                <mt-button type="primary" v-if="this.$store.state.phoneNum != ''" @click="btn">退出</mt-button>
            </div>
        </div>
        <div class="bottom">
            <publicMenu></publicMenu>
        </div>

    </div>
</template>

<script>
    import { Cell,Badge,Button } from 'mint-ui';
    import "./my.scss"
    import cookie from "../../utils/cookie"
    import http from '../../utils/reqAjax';
    import publicMenu from '../publicMenuComponent/publicMenu';

    export default {
        data(){
            return{
                userNum:"",
                phoneNum:"",
                popupVisible:false,
                imgUrl:"../../src/assets/img/my/default.jpg",
                obligation:0,
                receipt:0,
                allOrder:0,
                evaluate:0,
                type:false
            }
        },
        mounted(){
            // cookie判断是否已经登录
            var token = cookie.get("token");
            if(token){
                http.get({url:"user.php?phone=" + this.$store.state.phoneNum}).then((res)=>{
                    if(res.data[0].userName){
                        this.userNum = res.data[0].userName;
                    }
                    if(res.data[0].headeImg){
                        this.imgUrl = res.data[0].headeImg;
                    }
                })
                this.type = !this.type;
                this.phoneNum = this.$store.state.phoneNum;
                http.get({url:"order.php?userId=" + this.$store.state.userId}).then((res)=>{
                    res.data.forEach(function(item,idx){
                        if(item.status == 0){
                            this.obligation ++;
                        }else if(item.status == 1){
                            this.receipt ++;
                        }else if(item.status == 2){
                            this.evaluate ++;
                        }
                        this.allOrder ++;
                    }.bind(this))
                })
            }
        },
        methods:{
            Lregister(){
                this.$router.push("/login");
            },
            setting(){
                if(this.$store.state.phoneNum){
                  if(this.userNum == ''){
                    this.$router.push({name:"setting",params:{userNum:this.phoneNum,imgUrl:this.imgUrl}});
                  } else {
                    this.$router.push({name:"setting",params:{userNum:this.userNum,imgUrl:this.imgUrl}});
                  }

                }else{
                    this.$router.push("/login");
                }
            },
            order(event,val){
                if(this.$store.state.phoneNum == ""){
                    this.$router.push("/login");
                }else{
                    this.$router.push({name:"order",params:{num:val}});
                }
            },
            btn(){
                this.$store.commit('createPhone','');
                this.$store.commit('setUserId','');
                this.obligation = 0;
                this.receipt = 0;
                this.evaluate = 0;
                this.allOrder = 0;
                this.type = !this.type;
                cookie.remove('token');
            },
            collect(val){
                if(this.$store.state.phoneNum == ""){
                    this.$router.push("/login");
                }else if(val.target.parentNode.id == "col"){
                    this.$router.push({name:"myselect"});
                }else if(val.target.parentNode.id == "address"){
                    this.$router.push({name:"address"});
                }
            }
        },
        components: {
            publicMenu
        }
    }
</script>

