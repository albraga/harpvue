import Vue from 'vue'

let now = new Date().getMilliseconds();

new Vue({
  el: '#app',
  data: {
    message: now
  }
})