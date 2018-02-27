<template>
  <div>
      <div class="header clearfix">
          <h1>后台管理系统</h1>
          <div class="search">
            <el-input
            placeholder="请输入内容"
            v-model="num"
            clearable>
            </el-input>
            <el-button type="primary" @click="search">搜索</el-button>
            <el-button type="primary" @click="add" v-show="show">新增</el-button>
          </div>
          <div class="header_right">
              <ul>
                  <el-button type="primary" @click="quit">退出</el-button>
              </ul>
          </div>
      </div>
      <el-dialog
        title="信息 ："
        :visible.sync="dialog"
        width="40%"
        :before-close="handleClose">
            <div v-for="(value,idx) in dataset" :key="idx">
                <label v-if="idx != 'ImgUrl'">{{idx + ":"}}</label><el-input clearable :id="idx" v-if="idx != 'ImgUrl'" v-model="data[idx]"></el-input>
                <form class="ImgUrl" v-if="idx == 'ImgUrl'">
                    <label>{{idx + ":"}}</label>
                    <input type="file" name="file" :id="idx"/>
                </form>
            </div>
            <span slot="footer" class="dialog-footer">
                <el-button type="primary" @click="save">保 存</el-button>
                <el-button @click="dialog = false">取 消</el-button>
            </span>
        </el-dialog>

            <el-menu
              default-active="1"
              class="el-menu-vertical-demo menu"
              @open="handleOpen($event)"
              background-color="#545c64"
              text-color="#fff"
              active-li-color="#EB9E05">
              <el-submenu index="1" class="in1">
                <template slot="title">
                  <i class="el-icon-location"></i>
                  <span>用户管理</span>
                </template>
              </el-submenu>
              <el-submenu index="2" class="in1">
                <template slot="title">
                  <i class="el-icon-goods"></i>
                  <span>商品管理</span>
                </template>
              </el-submenu>
              <el-submenu index="3" class="in1">
                <template slot="title">
                  <i class="el-icon-message"></i>
                  <span>订单管理</span>
                </template>
              </el-submenu>
              <el-submenu index="4" class="in1">
                <template slot="title">
                  <i class="el-icon-sort"></i>
                  <span>员工管理</span>
                </template>
                  <el-menu-item index="1-1">普通员工</el-menu-item>
                  <el-menu-item index="1-2">选项2</el-menu-item>
              </el-submenu>
              <el-submenu index="5" class="in1">
                <template slot="title">
                  <i class="el-icon-sold-out"></i>
                  <span>采购模块</span>
                </template>
                  <el-menu-item index="1-1">选项1</el-menu-item>
                  <el-menu-item index="1-2">选项2</el-menu-item>
              </el-submenu>
              <el-submenu index="6" class="in1">
                <template slot="title">
                  <i class="el-icon-service"></i>
                  <span>客服管理</span>
                </template>
                  <el-menu-item index="1-1" @click="$router.push({path: '/service'})">当前对话</el-menu-item>
              </el-submenu>
            </el-menu>

        <div class="main">
            <div class="content">
              <router-view >
              </router-view>
              </div>
             <div class="page" v-if="showPage">
              <el-pagination
              background
              layout="total, sizes, prev, pager, next, jumper"
              @size-change="handleSizeChange"
              @current-change="handleCurrentChange"
              :current-page="currentPage"
              :page-sizes="pageSizes"
              :page-size="pagesize"
              :total="totalQty">
              </el-pagination>
            </div>

        </div>

  </div>
</template>

<script>
import baseUrl from '../../utils/baseUrl'
export default {
  name: 'RootComponent',
  data () {
    return {
      msg: '',
      dialog:false,
      dataset:[],
      imgUrl:'',
      show:true,
      num:'',
      pagesize:5,
      pageSizes:[5, 10, 15,20],
      totalQty:0,
      currentPage:1,
      data:{},
      showPage:false,
      uid:this.$store.state.user

    }
  },
  methods: {
      handleOpen(key) {
          if(key == 3){
              this.$router.push("/order");
          }else if(key == 2){
              this.$router.push("/goods");
          }
          else if(key == 1){
              this.$router.push("/user");
          }
      },
      handleClose(done) {
          this.$confirm('确认关闭？')
            .then(_ => {
                done();
            })
      },
      search(){
          // if(this.num){
            if(this.$children[6].search){
              this.$children[6].search(this.num);
            }
            else{
              this.$children[7].search(this.num);
            }
      },
      add(){
         console.log(this)
          if(this.$children[6].dataset){
                // this.data = {};
                this.dialog = true;

                this.dataset = this.$children[6].dataset[0];
            }
            else{
               this.dialog = true;
                this.dataset = this.$children[7].dataset[0];
            }
      },
        save(){
            if(document.querySelector("input[type=file]").files.length){
                jQuery('form').ajaxSubmit({
                    type: 'post',
                    url: baseUrl.url + 'form.php',
                    success:function(data){
                        console.log(data);
                        data = JSON.parse(data);
                        var dataObj = {};
                        for(var attr in this.dataset){
                            dataObj[attr] = document.getElementById(attr).value;
                        }
                        dataObj['ImgUrl'] = "../" + data.path + "/" + data.fileName;
                        $("input[type=file]").val('');
                        this.data = {};
                        if(this.$children[6].updated){
                            this.$children[6].updated(dataObj);
                            this.dialog = false;
                        }
                        else{
                           this.$children[7].updated(dataObj);
                            this.dialog = false;
                        }
                    }.bind(this)
                })
            }

        },
      quit(){
        window.localStorage.clear();
        this.$router.push({path: '/'});
        this.$store.commit('clearUser');

      },
      // 改变记录条数时触发。
      handleSizeChange(key){
        if(this.$children[6].changeQty){
              this.$children[6].changeQty(key);
            }
            else{
             this.$children[7].changeQty(key);
            }

      },
      // 改变页数时触发。
      handleCurrentChange(pageNum){
        if(pageNum){
          console.log(666)
          if(this.$children[6].changePage){
            this.$children[6].changePage(pageNum);
          }
          else{
            this.$children[7].changePage(pageNum);
          }
        }

      }
  },
  mounted(){
    if(!this.uid){

        setTimeout(() => {
          this.$alert('请先登录/注册！！！', '提示', {
          confirmButtonText: '确定'
        });
         this.$router.push({path: '/'});
        }, 800);

    }
  }


}
</script>
<style>
    @import './RootComponent.scss'

</style>
