<template>
    <div id="order">
        
        <table v-if="dataset.length > 0" class="table table-bordered table-condensed table-hover table-striped">
            <thead>
                <tr>
                    <th v-for="(value, idx) in data" :key="idx">{{value}}</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="(object, index) in dataset" :key="index">
                    <td v-for="(value, key) in object" :key="key">{{object[key]}}</td>
                </tr>
            </tbody>
        </table>
        <spinner v-if="show"></spinner>
    </div>
</template>

<script>
    import spinner from '../spinner/spinner'
    import http from '../../utils/reqAjax.js'
    import './order.scss'
    export default {
        data(){
            return{
                dataset:[],
                data:['订单ID','用户手机号','订单状态','订单添加时间'],
                status:['待支付','已付款','待收货','确认收货','待评价','已完成','已取消'],
                url:'order.php',
                num:'',
                show:false,
                qty:this.$parent.pagesize,
                pageNo:this.$parent.currentPage
            }
        },
        mounted(){
            this.$parent.showPage=true;
            this.$parent.show = false;
            this.show=true;
            http.get({"url":this.url + "?qty=" + this.qty+"&pageNo="+this.pageNo}).then(res=>{
               for(var i=0;i<res.data.data3.length;i++){
                    res.data.data3[i].status = this.status[res.data.data3[i].status];
                }
                this.dataset = res.data.data3;
                this.$parent.totalQty=Number(res.data.data2[0].totalQty);
                this.show=false;
            })
        },
        methods:{
            search(val){
                if(val == "待支付"){
                    val = 0;
                }else if(val == "已付款" ){
                    val = 1;
                }else if(val == "待收货" ){
                    val = 2;
                }else if(val == "确认收货" ){
                    val = 3;
                }else if(val == "待评价" ){
                    val = 4;
                }else if(val == "已完成" ){
                    val = 5;
                }else if(val == "已取消" ){
                    val = 6;
                }
                if(val==""){
                    this.reqData();
                }
                this.show=true;
                http.get({"url":this.url + "?state=search&data=" + val+"&qty="+this.qty+"&pageNo="+this.pageNo}).then(res=>{ 
                for(var i=0;i<res.data.data1.length;i++){
                    res.data.data1[i].status = this.status[res.data.data1[i].status];
                }
                this.dataset = res.data.data1;
                 this.$parent.totalQty=Number(res.data.data2[0].totalQty);
                this.show=false;
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
                for(var i=0;i<res.data.data3.length;i++){
                    res.data.data3[i].status = this.status[res.data.data3[i].status];
                }
                this.dataset = res.data.data3;
                this.show=false;
                }) 
            }
        },
         components:{
                spinner
            }

    }
</script>
