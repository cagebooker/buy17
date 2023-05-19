<template>
  <span class="set-icon setting-icon down-2">
    <span class="size" @click="editing = !editing">
      <i class="fa-solid fa-ellipsis-vertical fa-lg  down-1" ></i>
    </span>
    <div class="set-area" v-if="editing" @keyup.enter="hello">
      <input v-model="gName" class="mb-2">
      <div class="group-mark adjust mark-1" @click="sendlabel1">
        請客
      </div>
      <div class="group-mark adjust mark-2" @click="sendlabel2">
        溫暖
      </div>
      <div class="group-mark adjust mark-3" @click="sendlabel3">
        打折
      </div>
      <div class="group-mark adjust mark-4" @click="sendlabel4">
        慶生
      </div>
      <div class="group-mark adjust mark-5" @click="sendlabel5">
        達標
      </div>
      <div class="group-mark adjust mark-6" @click="sendlabel6">
        取消
      </div>
      
    </div>
  </span>
  

</template>

<script>
import Rails from '@rails/ujs'
export default{
    name: 'setgroup',
    props: ["groupName","groupId","userId", ],
    data: function(){
        return{
          editing: false,
          gName: this.groupName,
          label:''
        }
    },
    methods:{
      hello(){
        let data = new FormData();
        let id = this.groupId
        data.append("group[name]",this.gName);
        data.append("group_id",id);
        Rails.ajax({
          url: `/groups/${id}`,
          type: 'PUT',
          data,
          dataType: 'json',
          success: res =>{
            console.log('success')
          },
          error: err => {
            console.log(err)
          }
        })
      },
      sendlabel1(){
        // console.log("請客")
        let data = new FormData();
        let id = this.groupId;
        let uid = this.userId;
        data.append("label[name]","請客");
        data.append("group_id",id);
        data.append("user_id",uid);
        Rails.ajax({
          url: `/groups/${id}/label`,
          type: 'post',
          data,
          dataType: 'json',
          success: res =>{
            console.log(res)
          },
          error: err => {
            console.log(err)
          }
        })
        
      },
      sendlabel2(){
        // console.log("請客")
        let data = new FormData();
        let id = this.groupId;
        let uid = this.userId;
        data.append("label[name]","溫暖");
        data.append("group_id",id);
        data.append("user_id",uid);
        Rails.ajax({
          url: `/groups/${id}/label`,
          type: 'post',
          data,
          dataType: 'json',
          success: res =>{
            console.log(res)
          },
          error: err => {
            console.log(err)
          }
        })
        
      },
      sendlabel3(){
        // console.log("請客")
        let data = new FormData();
        let id = this.groupId;
        let uid = this.userId;
        data.append("label[name]","打折");
        data.append("group_id",id);
        data.append("user_id",uid);
        Rails.ajax({
          url: `/groups/${id}/label`,
          type: 'post',
          data,
          dataType: 'json',
          success: res =>{
            console.log(res)
          },
          error: err => {
            console.log(err)
          }
        })
        
      },
      sendlabel4(){
        // console.log("請")
        let data = new FormData();
        let id = this.groupId;
        let uid = this.userId;
        data.append("label[name]","慶生");
        data.append("group_id",id);
        data.append("user_id",uid);
        Rails.ajax({
          url: `/groups/${id}/label`,
          type: 'post',
          data,
          dataType: 'json',
          success: res =>{
            console.log(res)
          },
          error: err => {
            console.log(err)
          }
        })
        
      },
      sendlabel5(){
        // console.log("請客")
        let data = new FormData();
        let id = this.groupId;
        let uid = this.userId;
        data.append("label[name]","達標");
        data.append("group_id",id);
        data.append("user_id",uid);
        Rails.ajax({
          url: `/groups/${id}/label`,
          type: 'post',
          data,
          dataType: 'json',
          success: res =>{
            console.log(res)
          },
          error: err => {
            console.log(err)
          }
        })
        
      },
      sendlabel6(){
        // console.log("請客")
        let data = new FormData();
        let id = this.groupId;
        let uid = this.userId;
        data.append("label[name]","取消");
        data.append("group_id",id);
        data.append("user_id",uid);
        Rails.ajax({
          url: `/groups/${id}/label`,
          type: 'post',
          data,
          dataType: 'json',
          success: res =>{
            console.log(res)
          },
          error: err => {
            console.log(err)
          }
        })
        
      }
    }
}
</script>
<style lang="scss" scoped>
.set-area{
  width: 190px;
  height: 110px;
  border: 1px solid gray;
  border-radius: 3px;
  position: absolute;
  left: -170px;
  top: -130px;
  background-color: white;
  text-align: left;
  padding: 4px 8px;
  input{
    display: block;
    border: none;
    outline: none;
    width: 120px;
    border-bottom: 1px solid rgb(202, 202, 202);
    transition: 0.3s;
    font-size: 16px;
    &:hover{
      border-bottom: 1px solid gray;
    }
  }
}
.size{
  display: inline-block;
  width: 28px;
  height: 28px;
  // border: 1px solid black;
}
.adjust{
  margin-bottom: 4px;
  margin-right: 2px;
  transition: 0.2s;
  font-weight: bold;
}
.mark-1{
  &:hover{
    color: rgb(255, 40, 55);
    border: 2px solid rgb(255, 40, 55);
  }
}
.mark-2{
  &:hover{
    color: rgb(250, 171, 67);
    border: 2px solid rgb(250,171,67);
  }
}
.mark-3{
  &:hover{
    color: rgb(241, 208, 21);
    border: 2px solid rgb(241,208,21);
  }
}
.mark-4{
  &:hover{
    color: rgb(90, 231, 95);
    border: 2px solid rgb(90, 231, 95);
  }
}
.mark-5{
  &:hover{
    color: rgb(39, 174, 237);
    border: 2px solid rgb(39, 174, 237);
  }
}
.mark-6{
  &:hover{
    color: rgb(115, 115, 115);
    border: 2px solid rgb(115,115,115);
  }
}
</style>