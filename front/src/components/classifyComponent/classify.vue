<template>
  <div class="category_cen">
    <div class="top">
      <mt-header title="分类">
        <mt-button slot="right" @click="toSerch">搜索</mt-button>
      </mt-header>
    </div>

    <div class="menu">
      <ul class="left">
        <li v-for="(obj,idx) in category" @click="toSmallcategory(obj,$event)" :key="idx">{{obj}}</li>
      </ul>
      <div class="right">
        <div class="rigth_child">
        <div class="cateBigImg">
          <img v-if="cateSamllList[1]" v-bind:src="cateSamllList[0].categoryImg" alt="加载中"/>
        </div>
        <div class="menus">
          <div class="menusItem" v-for="(obj,idx) in cateSamllList"  v-bind:data-SmallId="obj.classifySmallId"  @click="toProduct({id:obj.classifySmallId,name:obj.classifyName},$event)" :key="idx">
            <img v-bind:src="obj.classifyImg" alt="加载中"/>
            <span>{{obj.classifyName}}</span>
          </div>
        </div>
      </div>
    </div>
    </div>
    <div class="buttom">
      <publicMenu></publicMenu>
    </div>

  </div>
</template>

<script>
import './classify.scss';
import http from '../../utils/reqAjax'
import publicMenu from '../publicMenuComponent/publicMenu';
import spinner from "../spinnerComponent/spinner"
export default {
  data: function(){
    return {
      category:[],
      categoryIdx:[],
      url: "category.php",
      cateSamll:'1',
      categoryList:'',
      cateSamllList:[]
    }
  },
  mounted(){
    spinner.loadspinner();
    http.get({"url":this.url}).then( res => {
      if(res.data){
        this.categoryList = res.data;
        this.catesm('水果');
       
        res.data.forEach(function(item){
          if( this.category.indexOf(item.categoryName) == -1){
            this.category.push(item.categoryName);
          }
        }.bind(this))
      }
      spinner.closeSpinner();
    });
  },
  methods:{
    toSmallcategory(idx,e){ 
      $('.rigth_child').css({bottom: '-100%'});
      this.catesm(idx);
      $(e.target).css({background:'#fff'}).siblings('li').css({background:'rgb(240, 237, 237)'})
      // console.log('e',e.target)
    },
    catesm(name){
      this.cateSamllList = [];
      if(this.categoryList){
        this.categoryList.forEach( item => {
          if(item.categoryName == name){
            this.cateSamllList.push(item)
          }
        })
      }
      $('.rigth_child').css('top','').stop().animate({top:0},400);
    },
    toProduct(obj,_event){
      console.log(obj)
      this.$router.push({ name: 'product',params: {id:obj.id,catename: obj.name,state: 'cate'}});
    },
    toSerch(){
      this.$router.push({ name: 'search'});
    }
  },
  components: {
    publicMenu
  }
}
</script>
