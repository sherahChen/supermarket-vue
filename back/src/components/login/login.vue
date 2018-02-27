<template>
<div id="sm_login">
    <div class="cotn_principal" :style="bgimg">
        <div class="cont_centrar">
            <div class="cont_login">
            <div class="cont_info_log_sign_up">
                <div class="col_md_login">
                <div class="cont_ba_opcitiy">
                    <h2>LOGIN</h2>
                    <p>The best preparation for tomorrow is doing your best today.</p>
                    <button class="btn_login" @click="cambiar_login1">LOGIN</button>
                </div>
                </div>
                <div class="col_md_sign_up">
                <div class="cont_ba_opcitiy">
                    <h2>SIGN UP</h2>
                    <p>The best preparation for tomorrow is doing your best today.</p>
                    <button class="btn_sign_up" @click="cambiar_sign_up1">SIGN UP</button>
                </div>
                </div>
            </div>
            <div class="cont_back_info">
                <div class="cont_img_back_grey"> <img :src="img" alt="" /> </div>
            </div>
            <div class="cont_forms" >
                <div class="cont_img_back_"> <img :src="img" alt="" /> </div>
                <div class="cont_form_login"> <a href="#" @click="ocultar_login_sign_up" ><i class="material-icons">&#xE5C4;</i></a>
                <h2>LOGIN</h2>
                <input type="text" placeholder="User/Email" v-model="loginData.l_user" class="l_email"/>
                <input type="password" placeholder="Password" v-model="loginData.l_pwd" class="l_pwd"/>
                <button class="btn_login" @click="cambiar_login">LOGIN</button>
                </div>
                <div class="cont_form_sign_up"> <a href="#" @click="ocultar_login_sign_up"><i class="material-icons">&#xE5C4;</i></a>
                <h2>SIGN UP</h2>
                <input type="text" placeholder="Email" @change="checkEmail" v-model="data.email" class="s_email"/>
                <input type="text" placeholder="User" @change="checkUser" v-model="data.user" class="s_user"/>
                <input type="password" placeholder="Password" class="s_pwd" v-model="data.password"/>
                <input type="password" placeholder="Confirm Password" class="sdb_pwd" v-model="data.dbpassword"/>
                <button class="btn_sign_up" @click="cambiar_sign_up">SIGN UP</button>
                </div>
            </div>
            </div>
        </div>
    </div>
    <spinner v-if="show"></spinner>
</div>
</template>
<script>
import spinner from '../spinner/spinner.vue'
import http from '../../utils/reqAjax.js'
import './login.scss'
export default {
    data(){
        return {
            show:false,
            loginData:{l_user:'',l_pwd:''},
            data:{email:'',user:'',password:'',dbpassword:''},
            img:"./src/assets/login/timg.jpg",
            bgimg:{'background-image':"url('./src/assets/login/bg.jpg')"}
        }
    },
    methods:{
        // 返回箭头点击事件
        ocultar_login_sign_up(){
            document.querySelector('.cont_forms').className = "cont_forms";
            document.querySelector('.cont_form_sign_up').style.opacity = "0";
            document.querySelector('.cont_form_login').style.opacity = "0";
            setTimeout(function(){
            document.querySelector('.cont_form_sign_up').style.display = "none";
            document.querySelector('.cont_form_login').style.display = "none";
            },500);
        },
        cambiar_login1(){
            document.querySelector('.cont_forms').className = "cont_forms cont_forms_active_login";
            document.querySelector('.cont_form_login').style.display = "block";
            document.querySelector('.cont_form_sign_up').style.opacity = "0";
               setTimeout(function(){
                document.querySelector('.cont_form_login').style.opacity = "1";
                 },400);
                setTimeout(function(){
                    document.querySelector('.cont_form_sign_up').style.display = "none";
                },200);
        },
        cambiar_sign_up1(){
            document.querySelector('.cont_forms').className = "cont_forms cont_forms_active_sign_up";
            document.querySelector('.cont_form_sign_up').style.display = "block";
            document.querySelector('.cont_form_login').style.opacity = "0";
            setTimeout(function(){  document.querySelector('.cont_form_sign_up').style.opacity = "1";
            },100);
            setTimeout(function(){   document.querySelector('.cont_form_login').style.display = "none";
            },400);
        },
        // login按钮事件
        cambiar_login(){
             for(var key in this.loginData){
                 if(!this.loginData[key]){
                     switch(key){
                         case 'l_user':
                             this.$message({
                            showClose: true,
                             message: '请输入用户名或电子邮箱！',
                             type: 'warning'
                             });
                             break;
                        case 'l_pwd':
                            this.$message({
                                showClose: true,
                                message: '请输入密码！',
                                type: 'warning'
                                });
                                break;
                     }
                     return;
                 }
             }
            var $email=$.trim(this.loginData.l_user);
            var $pwd=$.trim(this.loginData.l_pwd);
             this.show=true;
            http.get({url:"login.php?user="+$email+"&password="+$pwd}).then(res=>{
                  // 登陆成功
                if(res.data){
                    this.$store.commit('saveUser',$email);//保存到Vuex
                    this.show=false;
                    this.$message({
                    message: 'Login success!',
                    type: 'success',
                    center: true,
                    duration:'700'
                    });
                    setTimeout(()=>{
                        this.$router.push({name:"user"});
                    },1000)
                    window.localStorage.setItem("user", $email);
                }
                //失败
                else{
                    this.show=false;
                    this.$message({
                    showClose: true,
                    message: '用户名或密码错误，请重新输入!',
                    type: 'error'
                    });

                }
            })

        },
        // sign up按钮事件
        cambiar_sign_up(){
            // 动画
            var pwd=$.trim(this.data.password);
            var email=$.trim(this.data.email);
            var user=$.trim(this.data.user);
            if(pwd!=this.data.dbpassword){
                this.$message({
                showClose: true,
                message: '密码输入不一致!',
                type: 'warning'
                });
            }
             // 判断是否填写完整
            for(var key in this.data){
                 if(!this.data[key]){
                     switch(key){
                        case 'email':
                                this.$message({
                                showClose: true,
                                message: '请输入电子邮箱！',
                                type: 'warning'
                                });
                                break;
                            case 'user':
                                this.$message({
                                showClose: true,
                                message: '请输入用户名！',
                                type: 'warning'
                                });
                                break;
                            case 'password':
                                this.$message({
                                showClose: true,
                                message: '请输入密码！',
                                type: 'warning'
                                });
                                break;
                            case 'dbpassword':
                                this.$message({
                                showClose: true,
                                message: '请输入确认密码！',
                                type: 'warning'
                                });
                               break;
                        }
                       return;
                   }
                 }
               this.show=true;
                http.post({url:"register.php",parmas:{email:email,user:user,password:pwd}}).then(res=>{
                    if(res.data){
                        this.show=false;
                         this.$message({
                            message: '注册成功!请前往登陆!',
                            type: 'success',
                            center: true
                        });
                        this.cambiar_login1()
                        for(var key in this.data){
                            this.data[key]="";
                        }

                    } else {
                        this.show=false;
                        this.$message({
                        showClose: true,
                        message: '注册失败!请重新注册!',
                        type: 'error'
                        });
                    }
                })

        },
        checkUser(e){
            var user=this.data.user;
            http.get({url:"register.php?user="+user}).then(res=>{
                if(!res.data){
                   this.$message({
                    showClose: true,
                    message: '警告,该用户名已存在!',
                    type: 'warning'
                    });
                    $(e.target).val('');
                }
            })
        },
        checkEmail(e){
            var email=$.trim(this.data.email);
             var ph=new RegExp(/^[a-z0-9][\w\-\.]{2,}@[a-z0-9\-]+(\.[a-z]{2,})+$/).test(email);
               if(!ph){
                    this.$message({
                    showClose: true,
                    message: '请输入有效的电子邮箱！',
                    type: 'warning'
                    });
                    this.data.email="";
                }
                else{
                   http.get({url:"register.php?email="+email}).then(res=>{
                        if(!res.data){
                        this.$message({
                            showClose: true,
                            message: '警告,该邮箱已注册!',
                            type: 'warning'
                            });
                            this.data.email="";
                        }
                    })
                }

        }
    },
    components:{
        spinner
    }
}
</script>
