import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

const store=new Vuex.Store({
    state:{
       user: ''
    },
    mutations:{
        saveUser(state,val){
            state.user=val;
            console.log(state.user)
        },
        clearUser(state){
            state.user='';
        }
    }
})

export default store
