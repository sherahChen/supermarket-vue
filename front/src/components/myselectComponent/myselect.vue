<template>
    <div id="myselect">
        <div class="top">
            <mt-header title="我的收藏">
                <router-link to="/my" slot="left">
                    <mt-button icon="back"></mt-button>
                </router-link>
            </mt-header>
        </div>
        <div class="product_menu">
            <div v-for="obj in dataset" class="goodItem" @click.stop="toDetailPage(obj.goodId,$event)" :key="obj.goodId">
                <div class="left_img">
                    <img v-bind:src="obj.ImgUrl" alt="加载中"/>
                </div>
                <div class="right_prd_mess">
                    <h3 class="goodName">{{obj.goodName}}</h3>
                    <h4 class="goodDescribe">{{obj.describe}}</h4>
                    <h4 class="goodSize"><span>{{obj.size}}</span></h4>
                    <h4><span class="goodPre">￥{{obj.Price}}</span><span class="goodOrgpre">￥{{obj.originalPrice}}</span><button class="buy" @click="addCar(obj.goodId,$event)">立即购买</button></h4>
                </div>
                <i class="iconfont icon-shanchu"></i>
            </div>
        </div>
        <div class="addCar">
            <div class="carIcom" @click="toCar">
                <i class="glyphicon glyphicon-shopping-cart"></i><span class="carNum">{{carNum}}</span>
            </div>
        </div>
        <div class="addCar1">
            <div class="carIcom1" @click="$router.push('/my')">
                <i class="glyphicon glyphicon-user"></i>
            </div>
        </div>
    </div>
</template>

<script>
    import './myselect.scss'
    import http from '../../utils/reqAjax';
    import spinner from "../spinnerComponent/spinner"
    import { MessageBox} from 'mint-ui';

    export default {
        data: function(){
            return {
                categoryId:'1',
                url:"myselect.php",
                dataset:[],
                name:'',
                carNum:0,
                prdNum:0,
                prdPrice:0,
                userid:1
            }
        },
        mounted(){
            this.userid = this.$store.state.userId;
            this.prdNum = this.$store.state.selectTotle;
            this.prdPrice =  this.$store.state.priceTotle;
            this.categoryId = this.$route.params.id;
            this.name = this.$route.params.name;
            http.get({url:this.url + "?phone=" + this.$store.state.phoneNum}).then(res=>{
                this.dataset = res.data;
            });
            http.post({"url":'car1.php',parmas:{userId: this.$store.state.userId,state: 'selectprdCount'}}).then ( res => {
                this.carNum = res.data[0].totle;
            })
            http.post({"url":'car1.php',parmas:{userId: this.userid,state: 'selectprdCount'}}).then ( res => {
                this.carNum = res.data[0].totle;
            })
            this.ajaxCar()
        },

        methods:{
            
            ajaxCar(){
                // 请求用户购物车的商品
                http.post({"url":'car1.php',parmas:{userId: this.userid,state: 'selectproduct'}}).then ( res => {
                this.carprd = res.data;
                var selectTotle=0;
                var priceTotle = 0;
                for(var i=0; i< res.data.length; i++){
                    if(res.data[i].checkedstatus == 'true'){
                    selectTotle += res.data[i].count*1;
                    priceTotle += res.data[i].Price*1*res.data[i].count*1;
                    }
                }

                this.$store.commit("getSelectTotle",selectTotle)
                this.$store.commit("getPriceTotle",priceTotle.toFixed(2));
                })
            },
            toDetailPage(prdId,_event){
                if(_event.target.tagName == 'I'){
                    MessageBox.confirm('确定取消收藏?').then(action => {
                        http.post({'url': 'collect.php',parmas:{userid: this.userid,goodId: prdId,state: 'delete'}}).then ( res => {
                            if(res.data == 'delete'){
                                MessageBox.alert('已取消收藏').then(action => {
                                    this.dataset.forEach(function(item,idx){
                                        if(item.goodId == prdId){
                                            this.dataset.splice(idx,1);
                                        }
                                    }.bind(this))
                                });
                            }
                        })
                    });
                }else if(_event.target.tagName !== 'BUTTON'){
                    this.$router.push({ name: 'detailpage',params: {id: prdId}});
                }
            },
            toCar(){
                this.$router.push({ name: 'car'});
            },
            addCar(obj,e){
                spinner.loadspinner();
                http.post({"url":'Car.php',parmas:{userid: this.userid,goodId:obj}}).then ( res => {
                    var icom = $('<span/>').addClass('icon').css({top: e.clientY,left: e.clientX})
                    $(e.target).closest('.product_menu').append(icom);
                    $('.icon').animate({top:'90%',left:60},500,function(){
                        $('.icon').remove();
                        this.carNum = res.data[0].totle;
                        this.prdPrice = res.data[0].Price;
                    }.bind(this));
                    spinner.closeSpinner();
                })
            }
        }
    }
</script>

