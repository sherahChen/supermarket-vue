import Vue from 'vue'
import App from './App.vue'
import router from './routers/index'
import store from './store/store'

new Vue({
  el: '#app',
  router,
  store,
  render: h => h(App)
})
