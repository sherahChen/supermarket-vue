<template>
    <div id="rapid">
        <div class="rapidCom">
            <input type="text" placeholder="请输入手机号" v-model="phone" id="phone">
            <button @click="getCode">获取验证码</button><br>
            <input type="password" placeholder="请输入验证码" v-model="password" id="password">
            <span v-if="type">请输入正确的验证码</span><br>
            <mt-button type="primary" @click="Rapid">快速登录</mt-button>
        </div>
    </div>
</template>
<script>
    import { Button } from 'mint-ui';
    import "./rapid.scss";
    import "../../sass/spinner.scss";
    import http from "../../utils/reqAjax";
    export default {
        data(){
            return{
                phone:"",
                password:"",
                type:false
            }
        },
        methods:{
            goBack(){
                this.$router.go(-1);
            },
            getCode(){
                var phonenum = this.phone;
                
                $.ajax({
                    type: 'POST',
                    url: "http://localhost:888/smsyzm.php",
                    data: {yzm:123,yzmtel:phonenum},
                    success: function(res){
                        console.log(res)
                    }
                })
            },
            Rapid(){

            }
        }
    }
</script>
