<template>
    <div id="sm_address">
        <div class="get_header">
            <mt-header title="配送地址">
                <mt-button icon="back" slot="left" @click="back">返回</mt-button>
        </mt-header>
        </div>
        <div class="get_main">
            <div class="get_footer" @click="kipAdd">添加收货地址</div>
            <div class="myAddress">
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

    </div>
</template>
<script>
    import { Spinner,Search} from 'mint-ui';
    import http from '../../utils/reqAjax.js'
    import spinner from "../spinnerComponent/spinner"
    import './address.scss'
    export default{
        data(){
            return {
                url:'getAddress.php',
                data:[],
                userId:this.$store.state.userId
            }
        },
        methods:{
            kipAdd(){
                this.$router.push({name:'addAddress'});
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
            http.get({url:this.url+'?uid='+this.userId}).then(res=>{
                if(res.data){
                spinner.closeSpinner();
                  this.data=res.data;
                }
            });
        }
    }

</script>
