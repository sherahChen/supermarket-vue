import Vue from 'vue'
import Vuex from 'vuex'
import { Indicator,MessageBox } from 'mint-ui';
import spinner from "../components/spinnerComponent/spinner.js";
Vue.use(Vuex);

const store = new Vuex.Store({
    state:{
        site:"",//地址
        phoneNum:"",
        categoryId:"",
        selectTotle:"",
        priceTotle:"",
        checkedCarId: "",
        historySearch:[],
        orderNum:"",
        orderId:"",
        userId:"",
        checkedCarId:"",
        priceTotle: '0.00',
        CategoryName: '',
        CateState:'',
        detailsId:'',

    },
    mutations:{
      //获取当前位置
        getSite(state,self){
            // spinner.loadspinner();
            var map = new BMap.Map("allmap");
            var geocoder= new BMap.Geocoder();
            var geolocation = new BMap.Geolocation();
            geolocation.getCurrentPosition(function(r){
           if(this.getStatus() == BMAP_STATUS_SUCCESS){
             var mk = new BMap.Marker(r.point);
             map.addOverlay(mk);
             map.panTo(r.point);
             geocoder.getLocation(r.point,function(rs){
               spinner.closeSpinner();
              //  MessageBox.alert('你当前所在位置:'+rs.address).then(action => {});
               state.site=rs.address;
               });
           }
           else {
            alert('failed'+this.getStatus());
           }
         },{enableHighAccuracy: true})
        },
        // 点击地图后获取位置
        selectSite(state,e,self){
          var geocoder= new BMap.Geocoder();
          geocoder.getLocation(e.point,function(rs){
              state.site=rs.address;
              console.log(state.site)
          });

         },
        createPhone(state,val){
            state.phoneNum = val;
        },
        setUserId(state, val){
          state.userId = val;
        },
        getCategoryId(state, val){
          state.categoryId = val;
        },
        getSelectTotle(state,val){
          state.selectTotle = val;
        },
        getPriceTotle(state,val){
          state.priceTotle = val;
        },
        getCheckedCarId(state,val){
          state.checkedCarId = val;
        },
        // 保存搜索记录
        historySave(state,val){
        state.historySearch.push($.trim(val));
        state.historySearch = [...new Set(state.historySearch)];
        },
        historyClear(state){
          state.historySearch=[];
        },
        setOrderNum(state, val){
          state.orderNum = val;
        },
        setOrderId(state, val){
          state.orderId = val;
        },
        getCategoryName(state, val){
          state.CategoryName = val;
        },
        getCateState(state, val){
          state.CateState = val;
        },
        getDetailsIdState(state, val){
          state.detailsId = val;
        }

      }
})

export default store
