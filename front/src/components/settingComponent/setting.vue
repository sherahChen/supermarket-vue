<template>
    <div id="setting">
        <mt-header title="设置">
            <router-link to="/my" slot="left">
                <mt-button icon="back"></mt-button>
            </router-link>
        </mt-header>
        <form class="head">
            <span>头像：</span>
            <img :src="imgUrl" alt="">
            <input type="file" v-if="type" name="file" id="files">
        </form>
        <div>
            <label for="nickname">昵称：</label><input type="text" placeholder="请输入昵称" :value="userName" id="nickname" v-if="type"><span v-text="userName" v-if="!type"></span>
        </div>
        <div>
            <mt-button type="primary" class="upd" @click="update" v-if="!type">修改</mt-button>
            <mt-button type="primary" class="save" v-if="type" @click="save">保存</mt-button>
        </div>
    </div>
</template>

<script>
    import "./setting.scss";
    import http from "../../utils/reqAjax";
    import baseurl from '../../utils/baseUrl';
    import { MessageBox } from 'mint-ui';
    import spinner from "../spinnerComponent/spinner";

    export default {
        data(){
            return{
                userName:"",
                imgUrl:"",
                type:false
            }
        },
        mounted(){
            this.userName = this.$route.params.userNum;
            this.imgUrl = this.$route.params.imgUrl;
        },
        methods:{
            update(){
                this.type = true;
            },
            save(){
                if(document.querySelector("input[type=file]").files.length){
                    spinner.loadspinner();
                    jQuery('form').ajaxSubmit({
                        type: 'post',
                        url: baseurl.Url+'form.php',
                        success:function(data){
                            // console.log(data);
                            spinner.closeSpinner();
                            data = JSON.parse(data);
                            this.imgUrl = "../" + data.path + "/" + data.fileName;
                            this.userName = jQuery("#nickname").val();

                            http.get({url:"user.php?phone=" + this.$store.state.phoneNum + "&userName=" + this.userName + "&headeImg=" + this.imgUrl}).then(res=>{
                                if(data){
                                     MessageBox.confirm('确定执行此操作?').then(action => {
                                        this.$router.go(-1);
                                    });
                                }
                            })
                        }.bind(this)
                    })
                }else{
                    spinner.loadspinner();
                    this.userName = jQuery("#nickname").val();
                    http.get({url:"user.php?phone=" + this.$store.state.phoneNum + "&userName=" + this.userName + "&headeImg=" + this.imgUrl}).then(res=>{
                        spinner.closeSpinner();
                        MessageBox.confirm('确定执行此操作?').then(action => {
                            this.$router.go(-1);
                        });
                    })
                }
            }
        }
    }
</script>

