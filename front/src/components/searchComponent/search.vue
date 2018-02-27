<template>
    <div id="sm_search">
        <div class="header">

                <mt-button icon="back" slot="left" @click="back">返回</mt-button>

            <mt-search class="h_center" placeholder="搜索"></mt-search>
            <mt-button icon="search" slot="right" @click="skip"></mt-button>
        </div>
        <div class="main" @click.stop="getValue">
            <div class="hostory" v-if="$store.state.historySearch.length>0">
                <h3>历史搜索<i class="glyphicon glyphicon-trash" @click="removesAll"></i></h3>
                <ul class="show" >
                  <li v-for="(item,idx) in $store.state.historySearch" :key="idx">{{item}}</li>
                </ul>
            </div>
            <div class="hot">
                <h3>热门搜索</h3>
                <ul class="show" >
                  <li v-for="item in hot" :key="item">{{item}}</li>
                </ul>
            </div>
        </div>
     </div>
</template>

<script>
    import { MessageBox,Header } from 'mint-ui';
    import './search.scss'
    export default{
        data(){
            return {
                 hot:['草莓','车厘子','烘焙','洗发水','肉','水果','烧烤','薯片','三文鱼','鱼','虾']
            }
        },
        methods:{
            skip(){
                var val=$('.mint-searchbar-core').val();
                if(val){
                  console.log('val',val)
                    this.$store.commit('historySave',val);
                  // 直接跳转列表页面
                  this.$router.push({ name: 'product',params: {catename: val,state: 'serch'}});
                }
            },
            getValue(e){
              var tag=e.target.tagName.toLowerCase();
              if(tag=="li"){
                $('.mint-searchbar-core').val(e.target.innerText)
                  // 直接跳转列表页面
                  // this.$router.push({name: ''});
              }
            },
            removesAll(){
                MessageBox.confirm('确定删除全部历史搜索记录?').then(action => {
                this.$store.commit('historyClear');
              });

            },
            back(){
                this.$router.go(-1)
            }
        }
    }

</script>
