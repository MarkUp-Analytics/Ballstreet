// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import moment from 'moment'
import vueScrollto from 'vue-scrollto'
import vSelect from 'vue-select'


Vue.use(vueScrollto);

Vue.component('v-select', vSelect)

Vue.config.productionTip = false

Vue.filter('formatDate', function(value) {
  if (value) {
    if(typeof(value) == 'string'){
      return moment(new Date(value)).format('DD-MMM-YYYY')
    }
    else{
      return moment(value).format('DD-MMM-YYYY')
    }
    
  }
})

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  components: { App },
  template: '<App/>'
})
