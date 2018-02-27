<template>
  <div class="Menu_cen">
    <ul class="Menu">
      <li @click="type">{{SmallId || all}}</li><li @click="sort">{{SortName}}</li><li @click="filter">商品筛选</li>
    </ul>

    <div class="menus" v-if="status1" >
      <div class="menus_left">
        <div v-for="(obj) in category" @click="toSmallcategory(obj)">{{obj}}</div>
      </div>
      <ul class="menus_right">
        <li v-for="(obj) in cateSamllList" @click="getproductId({id: obj.classifySmallId, name: obj.classifyName},$event)">{{obj.classifyName}}</li>
    </ul>
    </div>
    <div class="sort" v-if="status2">
        <div class="sortItem" @click="getsort('DefaultSort',$event)"><span>默认排序</span></div>
        <div class="sortItem" @click="getsort('LowPriceSort',$event)"><span>价格最低</span></div>
        <div class="sortItem" @click="getsort('HighPriceSort',$event)"><span>价格最高</span></div>
        <div class="sortItem" @click="getsort('DiscountSort',$event)"><span>折扣最高</span></div>

    </div>
    <div class="filter" v-if="status3">
        <div class="top">
          <div class="filterItem"><span>不限</span></div>
          <div class="filterItem"><span>新品上市</span></div>
          <div class="filterItem"><span>限时抢购</span></div>
          <div class="filterItem"><span>疯狂折扣</span></div>
          <div class="filterItem"><span>新手专享</span></div>
          <div class="filterItem"><span>今日特价</span></div>
          <div class="filterItem"><span>实时热卖</span></div>
          <div class="filterItem"><span>山姆热卖</span></div>
          <div class="filterItem"><span>超级星期三</span></div>
        </div>
        <div class="filterBtn"><span>清除筛选</span><button>确定</button></div>

    </div>
  </div>
</template>

<script>
import http from '../../utils/reqAjax';
import spinner from "../spinnerComponent/spinner";
export default {
  data: function(){
    return {
      url:"category.php",
      category: [],
      status1: false,
      cateSamllList: '',
      status2: false,
      status3: false,
      all: '全部',
      SortName: '默认排序'
    }
  },
  props:['SmallId'],
  mounted(){

  },
  methods: {
    type(){
      spinner.loadspinner();
      http.get({"url":this.url}).then( res => {
        if(res.data){
          this.categoryList = res.data;
          this.catesm('水果');
          res.data.forEach(function(item){
            if( this.category.indexOf(item.categoryName) == -1){
              this.category.push(item.categoryName);
            }
          }.bind(this));
          // console.log(this.category)
          spinner.closeSpinner();
        }
      this.status1 = !this.status1;
        if(this.status2 == true){
          this.status2 = !this.status2;
        }
        if( this.status3 == true ){
          this.status3 = !this.status3;
        }
      });
    },
    toSmallcategory(idx){
      this.catesm(idx);
      // console.log(1,idx)
    },
    catesm(name){
      this.cateSamllList = [];
      if(this.categoryList){
        this.categoryList.forEach( item => {
          if(item.categoryName == name){
            this.cateSamllList.push(item)
          }
        })
        // console.log(this.cateSamllList)
      }
    },
    sort(){
      this.status2 = !this.status2;
      if(this.status1== true){
        this.status1 = !this.status1
      }
      if( this.status3 == true ){
        this.status3 = !this.status3;
      }
    },
    filter(){
      this.status3 = !this.status3;
      if(this.status1== true){
        this.status1 = !this.status1
      }
      if(this.status2 == true){
        this.status2 = !this.status2;
      }
    },
    // 获取点击后的categoryId改变父组件的categoryId
    getproductId(obj,event){
      // console.log('obj',obj);
      this.all = event.target.innerText;
      // 将获取到的categoryId存入store里
      // this.$store.commit('getCategoryId', obj.id);
      // this.$store.commit('getCategoryName', obj.name);
      // this.$store.commit('getCateState', 'cate');
      // 将从store里获取到的categoryId存入父组件的categoryId
      // this.$parent.categoryId = obj.id;
      // console.log('parent',this.$parent.categoryId);
      http.get({"url":'productList.php'+'?categoryId='+ obj.id+"&state="+'small'}).then ( res => {
          this.$parent.dataset = res.data;
          this.$parent.categoryId = obj.id;
          this.$parent.name = obj.categoryName;
          spinner.closeSpinner();
      })
      // this.$parent.name = this.$store.state.CategoryName;
      // this.$parent.state = this.$store.state.CateState;
      // console.log('id',this.$store.state.categoryId);
      // console.log(this.status1)
      if(this.status1== true){
        this.status1 = !this.status1;
      }
    },
    getsort(obj,event){
      // console.log(this.$parent.dataset)
      obj = JSON.stringify(obj)
      this.ajax(obj)
      if(this.status2== true){
        this.status2 = !this.status2;
      }
      this.SortName = event.target.innerText;
      // console.log(obj);
    },
    ajax(name){
      spinner.loadspinner();
      var categoryId = this.$parent.categoryId;
      if(this.$parent.categoryId == undefined){
        categoryId = '0'
      }
      http.get({"url":'productListSort.php'+'?categoryId='+categoryId + '&Sort='+ name}).then ( res => {
        // this.dataset = res.data;
        this.$parent.dataset = res.data;
        // console.log(res.data)
        spinner.closeSpinner();
      })
      // http.post({"url":'productListSort.php',parmas:{categoryId: this.$parent.categoryId,Sort:name}}).then ( res => {
      //   console.log(res.data)
      // })
    }
  }
}
</script>
