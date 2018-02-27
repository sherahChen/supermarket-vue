import Vue from 'vue'
import VueRouter from 'vue-router'
import MintUI from 'mint-ui'
import Vuex from 'vuex'

// import '../../node_modules/mint-ui/lib/style.css'
import search from '../components/searchComponent/search'

import categoryComponent from '../components/classifyComponent/classify.vue'
import productComponent from '../components/productComponent/productList.vue'
import c from '../components/classifyComponent/classify.vue'
import register from '../components/registerComponent/register.vue'

import getAddress from '../components/getAddressComponent/getAddress.vue'
import autoAddress from '../components/autoAddressComponent/autoAddress.vue'
import addAddress from '../components/addAddressComponent/addAddress.vue'
import '../sass/base.scss'
import '../sass/styleRem.css'
import rem from '../getRem/getRem.js'
rem.rem();

import login from '../components/loginComponent/login.vue'
import my from '../components/myComponent/my.vue'
import setting from '../components/settingComponent/setting.vue'
import order from '../components/orderComponent/order.vue'
import pay from '../components/payComponent/pay.vue'
import orderdetail from '../components/orderdetailComponent/orderdetail.vue'
import myselect from '../components/myselectComponent/myselect.vue'

import loginParent from '../components/loginParentComponent/loginParent.vue';
import detailPageComponent from '../components/detailPageComponent/detailPage.vue'
import carComponent from '../components/carComponent/car.vue'
import home from '../components/home/home.vue'
import address from '../components/address/address'
import accountComponent from '../components/accountComponent/account.vue'
Vue.use(Vuex);
Vue.use(MintUI);
Vue.use(VueRouter);

var router = new VueRouter({
    routes:[
        {
            path: '/search',
            name: 'search',
            component: search
        },
        {
          path:'/category',
          name: 'category',
          component: categoryComponent
        },
        {
            path: '/getAddress',
            name: 'getAddress',
            component: getAddress
        },
        {
            path:'/autoAddress',
            name:'autoAddress',
            component:autoAddress
        },
        {
            path:'/addAddress',
            name:'addAddress',
            component:addAddress
        },{
          path: '/product',
          name: 'product',
          component: productComponent
        },{
            path: '/loginParent',
            name: 'loginParent',
            component: loginParent,
            children:[
                {
                    path: "/register",
                    name: "register",
                    component: register
                },
                {
                    path: "/login",
                    name: "login",
                    component: login
                }
            ]
        },{
            path:"/my",
            name:"my",
            component:my
        },{
            path:"/setting",
            name:"setting",
            component:setting
        }, {
            path: "/order",
            name: "order",
            component: order
        }
        ,{
          path: '/detailpage',
          name: 'detailpage',
          component: detailPageComponent
        }
        ,{
          path: '/car',
          name: 'car',
          component: carComponent
        },
        {
            path:'/',
            name:"home",
            component:home
        },{
            path:'/pay',
            name:'pay',
            component:pay
        },{
            path:"/orderdetail",
            name:"orderdetail",
            component: orderdetail
        },{
            path:"/myselect",
            name:"myselect",
            component: myselect
        },
        {
            path: '/address',
            name: "address",
            component: address
        },
        {
          path: '/account',
          name: "account",
          component: accountComponent
        }

    ]
})

export default router;
