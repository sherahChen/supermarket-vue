<template>
    <div id="goods">
        <datagrid :api="url" :filterCols="filterColumns"></datagrid>
        <spinner v-if="show"></spinner>
    </div>
</template>

<script>
    import spinner from '../spinner/spinner'
    import datagrid from "../datagridL/datagridL.vue";
    import http from "../../utils/reqAjax";
    import './goods.scss'
     export default {
        data(){
            return{
                url:"goodsB.php",
                 filterColumns:['capacity','describe','classifySmallId','productionAddress'],
                //记录条数
                qty:this.$parent.pagesize,
                //页码
                pageNo:this.$parent.currentPage,
                show:false

            }
        },
        components:{
            datagrid,
            spinner
        },
        mounted(){
            this.$parent.show = true;
            this.$parent.showPage=true;
        },
        methods:{
            changeQty(key) {
                 this.qty=key;
                this.reqData();
            },
           changePage(pageNum) {
                this.pageNo=pageNum;
                this.reqData();
            },
            search(val){
                if(val==''){
                    this.reqData();
                }
                this.show=true;
                http.get({"url":this.url + "?state=search&data=" + val}).then(res=>{
                    this.show=false;
                    this.$children[0].dataset = res.data.data1;
                    this.$parent.totalQty=Number(res.data.data2[0].qty);
                })
            },
            updated(val){
                val.state = 'add';
                var str = '?';
                for(var attr in val){
                    str += attr + '=' + val[attr] + "&";
                }
                str = str.slice(0,str.length-1);
                http.get({url:"goodsB.php" + str}).then(res=>{
                    console.log(res)
                })
            },
            reqData(){
                this.show=true;
                http.get({"url":this.url + "?limit=" + this.qty+"&page="+this.pageNo}).then(res=>{
                this.$children[0].dataset = res.data.data1;
                this.$parent.totalQty=Number(res.data.data2[0].qty);
                this.show=false;

                })
            }

        }
    }
</script>

