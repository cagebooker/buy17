// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require jquery3
//= require jquery_ujs

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import '../styles/index'
import "cocoon-js-vanilla";

import Vue from 'vue/dist/vue.esm';
import orderitem from 'components/orderItem.vue'




document.addEventListener("turbolinks:load", function(event){
    
    let el = document.querySelector('#board'); //抓取最外層園內，內部就是vue運作的範圍
    if(el){
      new Vue({
        el,
        data:{
          menu: false,
          orderItem:true
        },
        methods:{
          orderCancel(){
            this.orderItem = false;
          }
        },
        components:{orderitem},

        mounted(){
          console.log("in vue")
        }
      })
    }
  })

 
