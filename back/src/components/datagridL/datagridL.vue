<template>
    <div>
        <table v-if="dataset.length > 0" class="table table-bordered table-condensed table-hover table-striped">
            <thead>
                <tr>
                    <th v-for="(value, key) in dataset[0]" v-if="filterCols.indexOf(key) < 0"  :key="key">{{key}}</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="(object, index) in dataset" :key="index">
                    <td v-for="(value, key) in object" v-if="key != 'ImgUrl' && filterCols.indexOf(key) < 0" :key="key">{{object[key]}}</td>
                    <td v-for="(value, key) in object" v-if="key == 'ImgUrl'" :key="key"><img :src="object[key]" alt=""></td>
                    <td>
                        <el-button type="success" plain @click="edit($event,index)">编辑</el-button>
                        <el-button type="success" plain @click="btn($event,index)">删除</el-button>
                    </td>
                </tr>
            </tbody>
        </table>
        <el-dialog
        title="用户信息"
        :visible.sync="dialogVisible"
        width="40%"
        :before-close="handleClose">
            <div v-for="(value,idx) in data" :key="idx">
                <label v-if="idx != 'ImgUrl'">{{idx + ":"}}</label><el-input clearable :id="idx" v-if="idx != 'ImgUrl'" :value="value" :disabled=" idx == 'goodId' ? 'disabled' : false"></el-input>
                <form class="ImgUrl" v-if="idx == 'ImgUrl'">
                    <label>{{idx + ":"}}</label>
                    <input type="file" name="file" :id="idx">
                    <img :src="data.ImgUrl" class="imgs">
                </form>
            </div>

            <span slot="footer" class="dialog-footer">
                <el-button type="primary" @click="saved">保 存</el-button>
                <el-button @click="dialogVisible = false">取 消</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
    import http from '../../utils/reqAjax.js'
    import './datagridL.scss'
    import baseUrl from '../../utils/baseUrl'
    export default {
        data: function(){
            return {
                dialogVisible: false,
                dataset: [],
                index:"",
                data:{}
            }
        },
        props: ['api', 'filterCols'],
        methods:{
            // 删除事件
            btn($event,index){

                var goodId = this.dataset[index].goodId;
                http.get({"url":this.api + "?state=del&goodId=" + goodId}).then(res=>{
                    if(res.data == "ok"){
                        this.dataset.splice(index,1);
                    }
                })

            },
            // 编辑事件
            edit($event,index){
                this.data = this.dataset[index];
                this.index = index;
                this.dialogVisible = true;
                console.log(index)
            },
            saved(){

                if(document.querySelector("input[type=file]").files.length){
                    jQuery('form').ajaxSubmit({
                        type: 'post',
                        url: baseUrl.url + 'form.php',
                        success:function(data){
                            console.log(data);
                            data = JSON.parse(data);
                            var dataObj = {};
                            for(var attr in this.dataset[0]){
                                dataObj[attr] = document.getElementById(attr).value;
                            }
                            dataObj['ImgUrl'] = "../" + data.path + "/" + data.fileName;
                            $("input[type=file]").val('');
                            this.data = {};
                            this.dialogVisible = false;

                            dataObj.state = 'update';
                            var str = '?';
                            for(var attr in dataObj){
                                str += attr + '=' + dataObj[attr] + "&";
                            }
                            str = str.slice(0,str.length-1);
                            http.get({url:"goodsB.php" + str}).then(res=>{
                                if(res.data == "ok"){
                                    delete dataObj.state;
                                    this.dataset.splice(this.index,1,dataObj);
                                }
                            })
                        }.bind(this)
                    })
                }else{
                    var dataObj = {};
                    for(var attr in this.dataset[0]){
                        dataObj[attr] = document.getElementById(attr).value;
                        console.log(document.getElementById(attr))
                    }
                    console.log(this.dataset[0])
                    dataObj['ImgUrl'] = $('.imgs').attr('src');
                    $("input[type=file]").val('');
                    this.data = {};
                    this.dialogVisible = false;

                    dataObj.state = 'update';
                    var str = '?';
                    for(var attr in dataObj){
                        str += attr + '=' + dataObj[attr] + "&";
                    }
                    str = str.slice(0,str.length-1);
                    http.get({url:"goodsB.php" + str}).then(res=>{
                        if(res.data == "ok"){
                            delete dataObj.state;
                            this.dataset.splice(this.index,1,dataObj);
                        }
                    })
                }
            },
            handleClose(done) {
                this.$confirm('确认关闭？')
                .then(_ => {
                    done();

                })
                .catch(_ => {

                });
            }
        },
        mounted(){
            http.get({"url":this.api}).then(res=>{
                this.$parent.$parent.totalQty = res.data.data2[0].qty*1;
                this.$parent.dataset = res.data.data1;
                this.dataset=res.data.data1;

            })

        }
    }
</script>



