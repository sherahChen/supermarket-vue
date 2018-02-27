<template>
    <div id="sm_get">
        <div class="get_header">
            <mt-header title="选择配送地址">
                <mt-button icon="back" slot="left" @click.stop="back">返回</mt-button>
        </mt-header>
        </div>
        <div class="searchAddr">
            <mt-search
              v-model="value"
              cancel-text="取消"
              placeholder="搜索">
            </mt-search>
        </div>
        <div class="get_main">
            <div class="address" @click.stop="kipAuto">
                <p><i class="glyphicon glyphicon-screenshot"></i>定位到当前位置<i class="glyphicon glyphicon-chevron-right"></i></p>
            </div>

            <div class="myAddress">
                <h4><i class="glyphicon glyphicon-map-marker"> </i>我的配送地址</h4>
                <ul class="addressList" v-if="data.length>=0">
                    <li v-for="item in data" :key="item.receiveId">
                        <div class="site_l">
                            <div class="l_top">
                                <span v-if="item.type=='公司'" class="company">{{item.type}}</span>
                                <span  v-else-if="item.type=='家'" class="family">{{item.type}}</span>
                                <span  v-else-if="item.type=='学校'" class="school">{{item.type}}</span>
                                <span  v-else>{{item.type}}</span>
                                <p>{{item.village}}  {{item.doorplate}}</p></div>
                                <p class="l_bot"><span>{{item.linkMan}}</span><span>{{item.gender}}</span><span>{{item.phone}}</span></p>
                        </div>
                        <div class="site_r">
                            <i class="glyphicon glyphicon-edit" @click.stop="edit" :id="item.receiveId"></i>
                        </div>
                    </li>
                </ul>
            </div>

        </div>
        <div class="get_footer" @click="kipAdd">添加收货地址</div>
    </div>
</template>
<script>
    import { Spinner,Search,MessageBox} from 'mint-ui';
    import http from '../../utils/reqAjax.js'
    import spinner from "../spinnerComponent/spinner"
    import './getAddress.scss';
    export default{
        data(){
            return {
                value:'',
                url:'getAddress.php',
                data:[],
                userId:this.$store.state.userId
            }
        },
        methods:{
            kipAdd(){
                if(this.userId){
                    this.$router.push({name:'addAddress'});
                }
                else{
                      MessageBox.confirm('用户未登录，是否去登录?').then(action => {
                      if(action == 'confirm'){
                        this.$router.push({name: 'login'})
                      }
                    });
                }
                
            },
            kipAuto(){
                this.$router.push({name:'autoAddress'});
            },
            reBack(e){
                 var tag=e.target.tagName.toLowerCase();
                 if(tag=="button"){
                     this.$router.go(-1);
                 }
            },
            edit(e){
                var tag=e.target.tagName.toLowerCase();
                if(tag=="i"){
                  var $id=$(e.target).attr('id');
                  if(!isNaN($id)){
                      this.$router.push({name:"addAddress",params:{id:$id}});
                  }
                }

            },
             back(){
                this.$router.go(-1);
            }
        },
        mounted(){
            spinner.loadspinner();
            http.get({url:this.url+"?uid="+this.userId}).then(res=>{
                if(res.data){
                spinner.closeSpinner();
                  this.data=res.data;
                }

            });
            var input=$('.mint-searchbar-core');
            input.focus(()=>{
                this.$router.push({name:"autoAddress"});
            })
        }
    }

</script>
