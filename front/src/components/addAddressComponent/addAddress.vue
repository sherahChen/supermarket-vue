<template>
    <div id="sm_add">
        <div class="add_header">
            <mt-header title="添加收货人">
                <mt-button icon="back" slot="left" @click.stop="back">返回</mt-button>
        </mt-header>
        </div>
        <div class="add_main">
            <mt-field label="收货人" placeholder="点击输入姓名" v-model="data.linkMan">
                <p class="gender sel" @click.stop="getGender"><span v-for="(item,idx) in allGender" v-if="data.gender==item" class="active" :key="idx" >{{item}}</span><span v-else>{{item}}</span></p>
            </mt-field>
                <mt-field label="手机号码" placeholder="输入手机号码" type="tel" v-model="data.phone"></mt-field>
                <mt-field label="小区" class="site" placeholder="请输入小区地址" type="text" v-model="$store.state.site" ></mt-field>
                <mt-field label="单元门牌" placeholder="请输入门牌号" type="text" v-model="data.doorplate"></mt-field>
                <div class="address sel" @click.stop.prevent="getType"><p class="ras"><label>地址分类</label><span v-for="item in allType" v-if="data.type==item" class="active" :key="item">{{item}}</span><span v-else>{{item}}</span></p></div>

            <mt-button type="primary" size="large" @click.stop="save">保存</mt-button>
            <mt-button type="primary" size="large" @click.stop="del"  v-if="editID">删除地址</mt-button>
        </div>
        <mt-popup
            v-if="success"
            v-model="success"
            position="top"
            closeOnClickModal="false">
            {{tip}}
        </mt-popup>
    </div>
</template>
<script type="text/javascript">
    import './addAddress.scss'
    import spinner from "../spinnerComponent/spinner"
    import http from '../../utils/reqAjax'
    import { Field,Button,MessageBox,Popup} from 'mint-ui';
    export default{
        data(){
            return {
                data:{linkMan:'',gender:'',phone:'',village:'',doorplate:'',type:''},
                allType:['家','公司','学校','其他'],
                allGender:['先生','女士'],
                success:false,
                url:"addAddress.php",
                tip:'',
                editID:this.$route.params.id,
                userId:''
            }
        },
        methods:{
            goback(){
                this.$router.go(-1);
            },
            getGender(e){
                var tag=e.target.tagName.toLowerCase();
                if(tag=="span"){
                    $(e.target).addClass('active').siblings().removeClass('active');   
                              
                }
            },
            getType(e){
                var tag=e.target.tagName.toLowerCase();
                if(tag=="span"){
                    $(e.target).addClass('active').siblings('span').removeClass('active');     
                }
            },
            save(){
                    this.data.gender=$('.gender').find('.active').html();
                    this.data.type=$('.ras').find('.active').html();
                    this.data.village=$('.site').find('input').val();
                    //判断是否为有效电话
                     var ph=new RegExp(/^1[34578]\d{9}$/).test(this.data.phone);
                     if(!ph){
                         MessageBox.alert('请输入有效的电话号码！').then(action => {});
                         this.data.phone="";
                     }
                // 判断是否填写完整
                for(var key in this.data){
                   if(!this.data[key]){
                        switch(key){
                            case 'linkMan':
                            MessageBox.alert('请填写收货人姓名！').then(action => {});
                            break;
                            case 'gender':
                            MessageBox.alert('请选择性别！').then(action => {});
                            break;
                            case 'phone':
                            MessageBox.alert('请输入有效的电话号码！').then(action => {});
                            break;
                            case 'village':
                            MessageBox.alert('请填写小区信息！').then(action => {});
                            break;
                            case 'doorplate':
                            MessageBox.alert('请填写门牌号信息！').then(action => {});
                            break;
                            case 'type':
                            MessageBox.alert('请选择地址分类！').then(action => {});
                            break;
                        }
                    return;
                   }
                }
                //填写完整信息后
                spinner.loadspinner();
                this.data.userId=this.$store.state.userId;
                var $data=JSON.stringify(this.data);
                    if(!this.editID){//保存新地址
                     http.get({url:this.url+'?checkData='+$data}).then(result=>{
                        var row=result.data.data2[0].row;
                         if(row=="0"){
                            http.post({url:this.url,parmas:{data:$data}}).then(res=>{
                                if(res.data){
                                    spinner.closeSpinner();
                                    this.tip="地址添加成功";
                                    this.success=true;
                                    $('input').val('');
                                    window.setTimeout(()=>{
                                        this.success=false;
                                        this.$router.push({name:'getAddress'});
                                    },1000);
                                }

                            })
                        }
                        else{
                            spinner.closeSpinner();
                            this.tip="收货人信息已存在";
                            this.success=true;
                                    window.setTimeout(()=>{
                                        this.success=false;
                                    },1000);

                        }
                    })
                }
                //保存更新的信息
                http.post({url:this.url,parmas:{updata:$data,receiveId:this.editID}}).then(res=>{
                    if(res.data){
                        spinner.closeSpinner();
                        this.tip="信息更新成功";
                        this.success=true;
                         window.setTimeout(()=>{
                            this.success=false;
                            this.$router.push({name:'getAddress'});
                        },1000);

                    }else{
                        spinner.closeSpinner();
                        this.tip="更改信息失败";
                        this.success=true;
                             window.setTimeout(()=>{
                                this.success=false;
                                 this.$router.push({name:'getAddress'});
                            },1000);

                        }
                })

            },
            del(){
               MessageBox.confirm('确定删除该地址信息?').then(action => {
                   spinner.loadspinner();
                    http.post({url:this.url,parmas:{delId:this.editID}}).then(res=>{
                    if(res.data){
                        spinner.closeSpinner();
                        this.tip="信息删除成功";
                        this.success=true;
                         window.setTimeout(()=>{
                            this.success=false;
                            this.$router.push({name:'getAddress'});
                        },1000);

                    }
                    else{
                        spinner.closeSpinner();
                        this.tip="更改信息失败";
                        this.success=true;
                        window.setTimeout(()=>{
                            this.success=false;
                        },1000);
                    }
                })
              });

            },
             back(){
                this.$router.go(-1);
            }
        },
        mounted(){
            this.userId = this.$store.state.userId;
            if(this.editID){
                 spinner.loadspinner();
                 var id=this.editID;
                http.get({url:this.url+"?id="+id}).then(res=>{
                if(res.data){
                     spinner.closeSpinner();
                     this.data={linkMan:res.data[0].linkMan,gender:res.data[0].gender,phone:res.data[0].phone,village:'',doorplate:res.data[0].doorplate,type:res.data[0].type};
                    $('.site').find('input').val(res.data[0].village);
                }
                })

            }
             var input=$('.site').find('input');
            input.focus(()=>{
                if(this.$route.params.id){
                    this.$router.push({name:"autoAddress",params:{id:this.$route.params.id}});
                }else{
                    this.$router.push({name:"autoAddress"});
                }

            })
        }
    }

</script>
