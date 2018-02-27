<template>
    <div id="sm_user" >
       <table v-if="dataset.length > 0" class="table table-bordered table-condensed table-hover table-striped">
           <thead>
                <tr>
                    <th v-for="(value, idx) in data" :key="idx">{{value}}</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="(object, index) in dataset" :key="index">
                     <tD>{{index+1}}</td>
                    <td v-for="(value, key) in object" :key="key" v-if="key=='headeImg'"><img :src="headImg"/></td>
                    <td v-else>{{object[key]}}</td>
                </tr>
            </tbody>
       </table>
       <spinner v-if="show"></spinner>
    </div>
</template>
<script>
import spinner from '../spinner/spinner'
import http from '../../utils/reqAjax.js'
import './user.scss'
export default {
  data(){
      return {
          dataset:[],
          show:false,
          data:['ID','用户名','密码','用户手机号','头像','创建时间'],
          url:'user.php',
          headImg:'./src/assets/login/head.jpg',
          //记录条数
          qty:this.$parent.pagesize,
          //页码
          pageNo:this.$parent.currentPage   
      }
  },
  mounted(){
    this.$parent.showPage=true;
    this.$parent.show=false;
     this.show=true;
     http.get({"url":this.url + "?qty=" + this.qty+"&pageNo="+this.pageNo}).then(res=>{
        this.show=false;
        this.dataset = res.data.data3;
         this.$parent.totalQty=Number(res.data.data2[0].totalQty);
          
    })   
  },
  methods:{
      search(val){
          if(val==""){
              this.reqData();
          }
          this.show=true;
        http.get({"url":this.url + "?qty=" + this.qty+"&pageNo="+this.pageNo+"&data="+val}).then(res=>{
         this.show=false;
        this.dataset = res.data.data1;
         this.$parent.totalQty=Number(res.data.data2[0].totalQty);
         
         })   
       
    },
    //获取记录条数
    changeQty(key){
        this.qty=key;
        this.reqData(); 
    },
    // 获取页数
    changePage(pageNum){
        this.pageNo=pageNum;
        this.reqData();
    },
    reqData(){
         this.show=true;
         http.get({"url":this.url + "?qty=" + this.qty+"&pageNo="+this.pageNo}).then(res=>{ 
         this.show=false;
        this.dataset = res.data.data3;
        
         }) 
    }
  },
  components:{
      spinner
  }
}
</script>
