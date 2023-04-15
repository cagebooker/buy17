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
          orderItem:true,
          darkMode: false,
        },
        methods:{
          orderCancel(){
            this.orderItem = false;
          },
          changeMode(evt){
            evt.preventDefault();  
            // console.log("dark mode on") success
            if( this.darkMode == true){
              console.log("dark mode -> light mode")
              this.darkMode = false;
              document.getElementById("body").classList.remove("dark-mode",);

              Rails.ajax({
                url: '/set_mode',
                type: 'post',
                dataType: 'json',
                success: res => {
                  console.log(res)
                },
                error: err => {
                  console.log(err)
                }
              }); 
            }else{
              console.log("lightmode -> dark mode")
              this.darkMode = true;
              document.getElementById("body").classList.add("dark-mode",);
              Rails.ajax({
                url: '/set_mode',
                type: 'post',
                dataType: 'json',
                success: res => {
                  console.log(res)
                },
                error: err => {
                  console.log(err)
                }
              }); 
            }
          }
        },
        components:{orderitem},

        mounted(){
          // console.log('mounted');
          // Rails.ajax({
          //   url: '/set_mode',
          //   type: 'get',
          //   dataType: 'json',
          //   success: res => {
          //     console.log(res)
          //     if(res.mode == "light"){
          //       this.darkMode = false;
          //       // console.log("darkmode right now ? "+this.darkMode);
          //       document.getElementById("body").classList.remove("dark-mode");
          //     }else{
          //       this.darkMode = true;
          //       // console.log(this.darkMode);
          //       document.getElementById("body").classList.add("dark-mode");
          //     }
          //   },
          //   error: err => {
          //     console.log(err)
          //   }
          // }); 
          
        },
        beforeMount(){
          Rails.ajax({
            url: '/set_mode',
            type: 'get',
            dataType: 'json',
            success: res => {
              console.log(res)
              if(res.mode == "light"){
                this.darkMode = false;
                // console.log("darkmode right now ? "+this.darkMode);
                document.getElementById("body").classList.remove("dark-mode");
              }else{
                this.darkMode = true;
                // console.log(this.darkMode);
                document.getElementById("body").classList.add("dark-mode");
              }
            },
            error: err => {
              console.log(err)
            }
          }); 
        }
        
      })
    }
  })

 
