<template>
  <div class=" out-div">
    <div class="group-mark m1" id="mark" v-if="show1">
      請客
    </div>
    <div class="group-mark m2" v-if="show2">
      {{ content }}
    </div> 
    <div class="group-mark m3" v-if="show3">
      {{ content }}
    </div> 
    <div class="group-mark m4" v-if="show4">
      {{ content }}
    </div> 
    <div class="group-mark m5" v-if="show5">
      {{ content }}
    </div> 
    <span class="set-icon setting-icon" >
      <span class="size" @click="editing = !editing">
        <i class="fa-solid fa-ellipsis-vertical fa-lg  down-1" ></i>
      </span>
      <div class="set-area" v-if="editing" @keyup.enter="hello">
        <input v-model="gName" class="mb-2">
        <span class="icon" @click="editing = false">
          <i class="fa-solid fa-xmark" ></i>
        </span>
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
  </div>
  
  

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
          label:'',
          content:'',
          xediting: false,
          show1: false,
          show2: false,
          show3: false,
          show4: false,
          show5: false,
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
            this.content = res.name
            this.show1 = true;
            this.show2 = false;
            this.show3 = false;
            this.show4 = false;
            this.show5 = false;
            // console.log(res)
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
            this.content = res.name
            this.show1 = false;
            this.show2 = true;
            this.show3 = false;
            this.show4 = false;
            this.show5 = false;
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
            this.content = res.name
            this.show1 = false;
            this.show2 = false;
            this.show3 = true;
            this.show4 = false;
            this.show5 = false;
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
            this.content = res.name
            this.show1 = false;
            this.show2 = false;
            this.show3 = false;
            this.show4 = true;
            this.show5 = false;
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
            this.content = res.name
            this.show1 = false;
            this.show2 = false;
            this.show3 = false;
            this.show4 = false;
            this.show5 = true;
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
            if (res.name == '取消'){
              // this.show = false;
              this.show1 = false;
              this.show2 = false;
              this.show3 = false;
              this.show4 = false;
              this.show5 = false;
            }
            console.log(res)
          },
          error: err => {
            console.log(err)
          }
        })
        
      }
    },
    mounted(){
      let id = this.groupId;
      let uid = this.userId;
      Rails.ajax({
        url: `/groups/${id}/label`,
        type: 'get',
        dataType: 'json',
        success: res =>{
          this.content = res.name
          if (res.name == '取消'){

          }else{
            this.show = true
          }
          
          // console.log(element);
          // element.classList.add("mystyle");
          switch(res.name){
            case "請客":
              this.show1 = true;
              break;
            case '溫暖':
              this.show2 = true;
              break;
            case '打折':
              this.show3 = true;
              break;
            case '慶生':
              this.show4 = true;
              break;
            case '達標':
              this.show5 = true;
              break;
          }
        },
        error: err => {
          console.log(err)
        }
      })
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
.m1{
  color: rgb(255, 40, 55);
  border: 2px solid rgb(255, 40, 55);
  font-weight: bold;
  animation: shake 1s ease-in-out;
}
.mark-2{
  &:hover{
    color: rgb(250, 171, 67);
    border: 2px solid rgb(250,171,67);
  }
}
.m2{
  color: rgb(250, 171, 67);
  border: 2px solid rgb(250,171,67);
  font-weight: bold;
  animation: shake 1s ease-in-out;
}
.mark-3{
  &:hover{
    color: rgb(241, 208, 21);
    border: 2px solid rgb(241,208,21);
  }
}
.m3{
  color: rgb(241, 208, 21);
  border: 2px solid rgb(241,208,21);
  font-weight: bold;
  animation: shake 1s ease-in-out;
}
.mark-4{
  &:hover{
    color: rgb(90, 231, 95);
    border: 2px solid rgb(90, 231, 95);
  }
}
.m4{
  color: rgb(90, 231, 95);
  border: 2px solid rgb(90, 231, 95);
  font-weight: bold;
  animation: shake 1s ease-in-out;
}
.mark-5{
  &:hover{
    color: rgb(39, 174, 237);
    border: 2px solid rgb(39, 174, 237);
  }
}
.m5{
  color: rgb(39, 174, 237);
  border: 2px solid rgb(39, 174, 237);
  font-weight: bold;
  animation: shake 1s ease-in-out;
}
.mark-6{
  &:hover{
    color: rgb(115, 115, 115);
    border: 2px solid rgb(115,115,115);
  }
}
@keyframes shake {
  0%{
    transform: rotate(0deg);
  }
  30%{
    transform: rotate(-6deg);
  } 
  50%{
    transform: rotate(6deg);
  }
  70%{
    transform: rotate(-6deg);
  }
  100%{
    transform: rotate(0deg);
  }
  
}
.icon{
  position: absolute;
  right: 10px;
  top: 6px;
  border: 1px solid transparent;
  border-radius: 50%;
  transition: 0.2s;
  &:hover{
    border: 1px solid gray;
  }
}
.out-div{
  height:36px;
  padding-right: 36px;
  transform: translate(0px, -2px);
}
</style>