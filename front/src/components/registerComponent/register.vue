<template>
    <div id="register">
        <div class="reg">
            <div>
                <label for="phone">手机号 :</label><input type="text" placeholder="请输入手机号" v-model="phone" @blur="btn(phone)" id="phone">
            </div>
            <span v-if="type">请输入正确的手机号码</span>
            <span v-if="type1">亲，该手机号已被注册</span>
            <div>
                <label for="password">密码 :</label><input type="password" placeholder="请输入6-20位数字或者字母" v-model="password" id="password" @blur="pwd(password)" :disabled="disabled1">
            </div>
            <span v-if="type2">请输入正确的格式</span>
            <div>
                <label for="password1">确认密码 :</label><input type="password" placeholder="请再次输入密码" v-model="password1" id="password1" @blur="pw(password1)" :disabled="disabled1">
            </div>
            <span v-if="type3">两次输入的密码不正确！</span>
            <button @click="getCode" :disabled="disabled1" class="getCode" v-if="!show">获取验证码</button>
            <p v-if="show"><span class="codeing">{{time + "秒后可重新获取验证码"}}</span><span>短信验证码已发送</span></p>
            <div>
                <label for="code">验证码 :</label>
                <input type="text" placeholder="请输入验证码" v-model="code" id="code" :disabled="disabled1">
            </div>
            <span v-if="type4">验证码错误！</span>
            <mt-button type="primary" :disabled="disabled" @click="register">注册</mt-button>
        </div>
    </div>
</template>
<script>
    import { Field,Header,Button } from 'mint-ui';
    import "./register.scss";
    import "../spinnerComponent/spinner.scss";
    import spinner from "../spinnerComponent/spinner"
    import http from "../../utils/reqAjax";
    import cookie from "../../utils/cookie";
    import baseUrl from '../../utils/baseUrl'
    export default {
        data(){
            return {
                phone:"",
                password:"",
                code:"",
                codenum:"",
                disabled:"",
                disabled1:"",
                type:false,
                type1:false,
                type2:false,
                type3:false,
                type4:false,
                show:false,
                password1:"",
                time:60
            }
        },
        methods:{
            btn(val){
                // 失去焦点时先判断格式发送请求验证用户是否存在
                var reg = /^1[3578]\d{9}$/g;
                if(reg.test(val)){
                    this.type = false;
                    http.get({url:"register.php?phone=" + val}).then((res)=>{
                        if(!res.data){
                            this.disabled1 = "";
                            this.type1 = true;
                        }else{
                            this.disabled1 = false;
                            this.type1 = false;
                        }
                    })
                }else{
                    this.type = true;
                }

            },
            pwd(val){
                var reg = /^[0-9a-zA-Z]{6,20}$/g;
                if(reg.test(val)){
                    this.type2 = false;

                }else{
                    this.type2 = true;
                }
            },
            pw(val){
                if(this.password == val){
                    this.type3 = false;
                }else{
                    this.type3 = true;
                }
            },
            register(){
                if(this.type3 == false && this.codenum == this.code && this.password !== ""){
                    spinner.loadspinner();
                    http.get({url:"register.php?phone=" + this.phone + "&password=" + this.password}).then((res)=>{
                        console.log(res)
                        setTimeout(function(){
                            spinner.closeSpinner();
                            if(res.data != 'fail'){
                                this.$store.commit('createPhone',this.phone);
                                this.$store.commit("setUserId",res.data[0].userId);
                                var now = new Date();
                                now.setDate(now.getDate()+90);
                                cookie.set("token",res.data,now,"/");
                                if(this.$store.state.aa){
                                    this.$router.push({name:this.$store.state.aa});
                                }else{
                                    this.$router.push("/my");
                                }
                            }else{
                                alert("网络出现故障，请重新注册！")
                            }
                        }.bind(this),1000)
                    })
                }else{
                    this.type4 = true;
                }
            },
            getCode(){
                var phonenum = this.phone;
                var codenum = vCode();
                this.codenum = codenum;
                function vCode(){
                    var arr_char = '0123456789abcdefghijklmnopqrstuvwxyz'.split('');
                    var res = '';
                    for(var i=0;i<4;i++){
                        // 获取随机索引值
                        var idx = parseInt(Math.random()*arr_char.length);
                        // 根据索引值获取字符，并拼接
                        res += arr_char[idx];
                    }
                    return res;
                }

                $.ajax({
                    type: 'POST',
                    url: baseUrl.Url + "smsyzm.php",
                    data: {yzm:codenum,yzmtel:phonenum},
                    success: function(res){
                        res = eval('(' + res + ')');
                        if(res.msg === "OK"){
                            this.code = '';
                            this.type4 = false;
                            this.disabled = false;
                            this.show = true;
                            // 设置倒计时
                            var timer = setInterval(function(){
                                this.time--;
                                if(this.time == 0){
                                    clearInterval(timer);
                                    this.show = false;
                                    this.codenum = '';
                                    this.time = 60;
                                }
                            }.bind(this),1000);
                        }
                    }.bind(this)
                })
            },
            goback(){
                this.$router.go(-1);
            }
        }
    }
</script>

