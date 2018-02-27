<template>
    <div id="sm_home">
        <header id="header">
            <div class="h_l">
               <p @click.stop="kipGet"> <i class="glyphicon glyphicon-map-marker"></i>{{$store.state.site}}<i class=""></i></p>
            </div>
            <div class="h_r">
                <i class="mintui mintui-search"></i>
                <input class="kipSearch" type="text" placeholder="1元起送，30分钟达">
            </div>
        </header>
        <main>
           <div id="banner">
                <mt-swipe :auto="4000">
                    <mt-swipe-item v-for="(n,idx) in 6" :key="n"><img :src="img[idx]" alt=""></mt-swipe-item>
                </mt-swipe>
            </div>
             <div id="type">
                <dl v-for="(item) in typeData" :key="item.categoryId" @click="toCategory(item.categoryId,item.categoryName)">
                        <dt><img :src="item.categoryImg2" alt="" />
                        </dt>
                        <dd>{{item.categoryName}}</dd>
                </dl>
                <dl v-if="typeData.length>=1" @click="toClassify">
                        <dt><img :src="allTypeimg" alt="" />
                        </dt>
                        <dd>全部品类</dd>
                </dl>
             </div>

            <div id="list">
            
            <mt-navbar v-model="selected">
                    <mt-tab-item v-for="(item,idx) in typeData" :key="idx" :id="'data'+(idx*1+1)" >{{item.categoryName}}</mt-tab-item>
            </mt-navbar>
                <mt-tab-container v-model="selected" :swipeable="true">
                    <mt-tab-container-item v-for="(obj,index) in datalist" :id="index" :key="index">
                            <ul class="datalist" v-if="obj.length>0">
                             <li v-for="(arr,idx) in obj" :key="arr.goodName" :gid="arr.goodId" @click.stop="toDetailPage(arr.goodId,$event)">
                                <div>
                                    <img v-lazy="arr.ImgUrl"/>
                                </div>
                                <div>
                                    <h2>{{arr.goodName}}</h2>
                                    <p class="details">{{arr.describe}}</p>
                                    <p class="size"><span>{{arr.size}}</span></p>
                                    <div class="purchase">
                                        <p><span v-filter>{{arr.Price}}</span><span v-filter>{{arr.originalPrice}}</span></p>
                                        <button class="Addbtn" @click.stop="addCar(arr.goodId,$event)" v-if="orderObj.indexOf(arr.goodId)<0">立即购买</button>
                                            <p class="qty" v-else>
                                            <span class="compute" @click="compute(arr.goodId,idx,$event)">-</span><span class="num" @click="compute(arr.goodId,idx,$event)">1</span><span class="compute">+</span>
                                            </p>
                                    </div>

                                </div>
                                </li>
                            </ul>
                            <div v-else class="dataNull">
                               <img :src="dataNull" alt="">
                            </div>
                        </mt-tab-container-item> 
                </mt-tab-container>

            </div> 
        </main> 
        <div id="allmap" style="width:0;height:0;"></div>
        <publicMenu></publicMenu>
    </div>
</template>
<script>
    import publicMenu from '../publicMenuComponent/publicMenu'
    import { Nacbar,TabItem,Swipe, SwipeItem, TabContainer, TabContainerItem,MessageBox,Lazyload } from 'mint-ui';
    import http from '../../utils/reqAjax.js'
    import spinner from "../spinnerComponent/spinner"
    import './home.scss'
    export default{
        data(){
            return {
                userid:this.$store.state.userId,
                url:'home.php',
                typeData:[],
                typeArr:[],
                active:'水果',
                datalist:{},
                showNum:false,
                orderObj:[],
                cargoods:[],
                dataNull:"../../src/assets/img/loading.jpg",
                allTypeimg:"../../src/assets/img/iconv3/f10.jpg",
                img:["../../src/assets/img/banner/1.png","../../src/assets/img/banner/2.png","../../src/assets/img/banner/3.png","../../src/assets/img/banner/4.png","../../src/assets/img/banner/5.png","../../src/assets/img/banner/6.png",],
                typeImg:"../../src/assets/img/iconv3/f1.jpg",
                selected:'data1'
                
            }
        },

        methods:{
            kipGet(){
                this.$router.push({name:"getAddress"});
            },
            toDetailPage(obj,_event){
                if(_event.target.tagName !== 'BUTTON'){
                    this.$store.commit("getDetailsIdState",obj);
                    this.$router.push({ name: 'detailpage',params: {id: obj}});
                }
            },
            toClassify(){
                this.$router.push({ name: 'category'});
            },
            addCar(id,e){
                if(this.userid){
                    http.post({"url":"car1.php",parmas:{userId: this.userid,goodId:id,state: 'addProduct'}}).then ( res => {
                    if( res.data == 'seccese'){
                        // this.ajax();
                        }
                    })
                 }
                 else{
                    MessageBox.confirm('用户未登录，是否去登录?').then(action => {
                      if(action == 'confirm'){
                        this.$router.push({name: 'login'})
                      }
                    });
                 }
                },
                  // 商品数量加减
            compute(idx,subItem,event){
              var target = event.target;
              // console.log(subItem)
              // 加
              if(target.innerText == '+'){
                  // this.sum=(target.parentNode.childNodes[1].innerText*1)+1
                  // console.log(this.sum)
                  http.post({"url":"car1.php",parmas:{userId: this.userid,goodId:idx,state: 'addProductTotle'}}).then ( res => {
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
                      http.post({"url":this.url,parmas:{userId: this.userid,goodId:idx,state: 'delProduct'}}).then ( res => {
                          // console.log(this.carprd.splice(aa, 1));
                          this.carprd.splice(subItem, 1);
                          this.ajax();
                      })
                  }
              }

              },
            toCategory(id,name){
              this.$router.push({ name: 'product',params: {id: id,catename: name,state: 'home'}})
            }
        },
        directives:{
            filter:{
                inserted(ele){
                    var text="￥"+ele.innerText;
                    $(ele).html(text);
                }

             }
        },
        components: {
            publicMenu
        },
        mounted(){
          if(this.$store.state.userId){
              this.userid = this.$store.state.userId;
          } else {
            this.userid = ''
          }
          var p= new Promise(()=>{
                spinner.loadspinner();
                 http.get({url:this.url}).then(res=>{
                    this.typeData=res.data;
                    $.each(res.data,(idx,item)=>{
                        this.typeArr.push(item.categoryName);
                    })
                    // if(this.userId){
                        //  http.get({url:this.url+"?uid=28"}).then(res=>{
                            // this.cargoods=res.data;
                            // var data=Object.assign(res.data.data2,res.data.data1);
                            // this.datalist=res.data;
                            // console.log(res.data).
                        // });
                    // }
                     http.get({url:this.url+"?allType="+this.typeArr}).then(res=>{               
                      this.datalist=res.data;
                    });
                });
           });
           p.then(()=>{
               spinner.closeSpinner(); 
           })
          
            var input=$('.kipSearch');
            input.focus(()=>{
                this.$router.push({name:"search"});
            });
             
             this.$store.commit('getSite');

            // 吸顶导航
            nav();
            function nav(){
                    var height=0;
                    var headerH=$("#header").height();
                    var bannerH = $("#banner").height();
                    height=headerH+bannerH;
                    $(window).scroll(function() {
                        var w = $("body").scrollTop() || $(document).scrollTop(); //获取滚动值
                            if(w > height) {
                    $(".mint-navbar").addClass("titleTap");
                            } else if(w <= 0){
                    $(".mint-navbar").removeClass("titleTap")
                            }else{
                    $(".mint-navbar").removeClass("titleTap")
                            }
                });
            }
        }
    }

</script>
