<template>
    <div id="loginParent">
        <div>
            <mt-header title="登录/注册">
                <mt-button slot="left" icon="back" @click="goback"></mt-button>
                <mt-button slot="right" class="glyphicon glyphicon-home" @click="$router.push('/')"></mt-button>
            </mt-header>
            <mt-navbar v-model="selected">
                <mt-tab-item  id="loginP"><span @click="loginP" class="loginP">登录</span></mt-tab-item>
                <mt-tab-item id="registerP"><span @click="registerP" class="registerP">注册</span></mt-tab-item>
            </mt-navbar>
            <router-view></router-view>
        </div>
    </div>
</template>
<script>
    import { Navbar, TabItem,Field,Header,Button } from 'mint-ui';
    import "./loginParent.scss";
    export default {
        data(){
            return{
                selected:"",
                show:false
            }
        },
        mounted(){
            $(".mint-tab-item").eq(0).addClass("is-selected");
        },
        methods:{
            goback(){
                this.$router.go(-1);
                // this.$router.push({ name: 'my'});
            },
            loginP(){
                this.$router.push({name:"login"});
            },
            registerP(){
                this.$router.push({name:"register"});
                $(".mint-tab-item").eq(0).removeClass("is-selected");
            }
        }
    }
</script>
