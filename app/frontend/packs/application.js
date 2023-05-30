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
import store from '../stores/store.js';
import orderitem from 'components/orderItem.vue';
import Commentarea from '../components/commentarea.vue'
import Setgroup from '../components/setgroup.vue'
import Grouplabel from '../components/grouplabel.vue'
import axios from 'axios';



document.addEventListener("turbolinks:load", function(event){
    
    let el = document.querySelector('#board'); //抓取最外層園內，內部就是vue運作的範圍
    if(el){
      var vm = new Vue({
        el,
        store,
        data:{
          menu: false,
          orderItem:true,
          darkMode: false,
          problem: '',
          ans: '123',
          chatstate: false,
          list_id: '',
          group_id: '',
          purchaseform: false,
          postitboard:false,
          postitclose: false,
          inviteEditing: false,
          colorList:[
            {
              name: "yellow",
              color: "#FFEB67"
            },
            {
              name: "green",
              color: "#CBE196"
            },
            {
              name: "red",
              color: "#EF898C"
            },
            {
              name: "blue",
              color: "#A5D8D6"
            }
          ],
          nowId: -1,
          mousePos: {
            x: 0,
            y: 0
          },
          startMousePos: {
            x: 0,
            y: 0
          },
          postit: {
            text:'都市更新',
            color: 'yellow',
            pos: { x:40, y:60},
            id: 0 
          }
        },
        watch:{
          mousePos(){
            if( this.nowId != -1){
              let nowPostit = this.postits[this.nowId]
              // nowPostit.pos.x = 200;
              // console.log(nowPostit)
              nowPostit.pos_x = this.mousePos.x-122-this.startMousePos.x;
              nowPostit.pos_y = this.mousePos.y-98-this.startMousePos.y;
              // if(nowPostit.pos_x<0){
              //   nowPostit.pos_x = 0
              //   // console.log(nowPostit.pos.x)
              // }else if(nowPostit.pos_y<60){
              //   nowPostit.pos_y = 60
              //   // nowPostit.pos_x = this.mousePos_x-200-this.startMousePos.x;
              // }else{
              //   nowPostit.pos_x = this.mousePos.x-200-this.startMousePos.x;
              //   nowPostit.pos_y = this.mousePos.y-this.startMousePos.y;
              // }
              
            }
            // console.log(this.mousePos)
          },
        },
        components:{Commentarea: Commentarea,Setgroup: Setgroup, Grouplabel: Grouplabel}, 
        computed:{
          postits(){
            return this.$store.state.postits
          },
          answers(){
            
            return this.$store.state.answers
          }
        },
        methods:{
          showInvite(evt){
            evt.preventDefault();
            this.inviteEditing = !this.inviteEditing;
          },
          hello(){
            console.log('hello');
          },
          showBoard(){
            this.postitboard = true;
            this.postitclose = true
          },
          closeBoard(){
            // console.log("eror");
            this.postitboard = false;
            this.postitclose = !this.postitclose;
          },
          changeText(evt, p){
            // console.log(p)
            this.$store.dispatch('changeText',p)
          },
          changeColor(p,color){
            this.postit = p
            this.postit.color = color.name
            // console.log(this.postit)
            this.$store.dispatch('changeColor', this.postit)
          },
          updateContent(){
            console.log('updateContent')
          },
          focusOn(pid){
            this.$refs.name1[pid].focus();
  
            // console.log(pid);
            // console.log(this.$refs.name1[pid]);
          },
          getColor(name){
            // console.log(name);
            return this.colorList.find(o=>o.name==name).color;
          },
          addPost(){
            this.$store.dispatch('addPost',{text:'文字',
            color: 'yellow',
            pos: { x:260+Math.random()*100, y:160+Math.random()*100}})
          },
          deletePost(p_id,pid){
            this.$store.dispatch('deletePost',{p_id:p_id, pid:pid})
          },
  
          selectId(evt,id, p){
            console.log(evt);
            if(! (evt.srcElement.classList.contains('block')
              || evt.srcElement.classList.contains('btn'))){
              this.nowId = id
              this.postit = p
              // console.log(this.postit)
              this.startMousePos = {
                x: evt.offsetX,
                y: evt.offsetY
              }
              
            }else{
              this.nowId = -1
            }
            
          },
          postitCss(p){
            return { 
              // 'background-color': 'yellow'
              left: p.pos_x+"px",
              top: p.pos_y+"px",
              
              backgroundColor: this.colorList.find(o=>o.name==p.color).color,
            }
          },
          inputCss(p){
            if(((160 / p.content.length)-10)<10){
              return{
                fontSize: 14+"px",
              }
            }else{
              return{
                fontSize: (160 / p.content.length)-10+"px",
              }
            }
            
          },
          newpurchase(evt){
            evt.preventDefault();
            this.purchaseform = !this.purchaseform
          
          },
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
          },
          chatgpt(evt){
            evt.preventDefault();
            this.$store.dispatch('chatgpt',{problem: this.problem});
            this.problem = '' ;
          },
          startChatGpt(evt){
            evt.preventDefault();
            this.chatgpt != this.chatgpt
          },
          setgroup(evt){
            evt.preventDefault();
            console.log("set group info");
          }
        },

        mounted(){
          /*** 
          axios.post('https://api.openai.com/v1/completions', {
            model:'text-davinci-003',
            // messages: [{ role: 'assistant', content: message }],
            prompt: "How old are you?",
            max_tokens: 600,
            temperature: 0
          }, {
            headers: {
              'Content-Type': 'application/json',
              'Authorization': "Bearer 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"
            }
          })
            .then(function (response) {
              console.log(response.data.choices[0].text);
            })
            .catch(function (error) {
              console.log(error);
            });
          ***/
          
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
          this.$store.dispatch('loadPostits');
        }
        
      })
    }
    window.onmousemove = (evt)=>{
      // console.log(evt)
      if(vm.nowId != -1){
        vm.mousePos = {x: evt.pageX, y: evt.pageY}
        // console.log(vm.mousePos)
      }  
    }
    window.onmouseup = (evt)=>{
      // console.log(evt)
      vm.nowId = -1;
      // console.log(vm.postit)
      vm.$store.dispatch('updatePostit',vm.postit)
    }
  })

 
