<template>
    <div class="menu_cen">
      <ul>
        <li>
          <router-link to="/">
          <i class="glyphicon glyphicon-home"></i>
          <span>首页</span>
          </router-link>
        </li>
        <li>
          <router-link to="/category">
            <i class="glyphicon glyphicon-th"></i>
            <span>分类</span>
          </router-link>
        </li>
        <li @click="goCar">

            <i class="glyphicon glyphicon-search"></i>
            <span>购物车</span>

        </li>
        <li>
           <router-link to="/my">
          <i class="glyphicon glyphicon-user"></i>
          <span>我的</span>
          </router-link>
        </li>
      </ul>
    </div>
</template>
<script>

import './publicMenu.scss';
import cookie from "../../utils/cookie";
import http from '../../utils/reqAjax';

export default {
  data: function(){
    return {

    }
  },
   mounted(){
    // cookie判断是否已经登录
    var token = cookie.get("token");
    if(token){
        http.get({url:"user.php?phone=" + this.$store.state.userId}).then((res)=>{
            if(res.data[0].userName){
                this.userNum = res.data[0].userName;
            }
            if(res.data[0].headeImg){
                this.imgUrl = res.data[0].headeImg;
            }
        })
        this.type = !this.type;
        this.userId = this.$store.state.userId;
    }
  },
  methods:{
    goCar(){
      // if(this.$store.state.userId){
        this.$router.push({name:"car"});
      // }else{
      //   this.$router.push("/login");
      // }
    }
  }

}
</script>
