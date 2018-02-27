import Vue from 'vue'
import App from './App.vue'
import Vuex from 'vuex'
import store from './vuex/store'

import Element from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import './css/base.css'
Vue.use(Element)
Vue.use(Vuex)

import Router from './router/index.js'

new Vue({
  el: '#app',
  router:Router,
  store,
  render: h => h(App)
})