<template>
  <div class="group-mark up-2" v-if="show">
    {{ content }}
  </div>

  
</template>

<script>
import Rails from '@rails/ujs'
export default{
    name: 'grouplabel',
    props:["groupId","userId"],
    data: function(){
        return{
          content: '',
          show: false
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
          var ele = document.getElementsByClassName('group-mark')
          switch(res.name){
            case "請客":
              ele.classList.add("m1");
              break;
            case '溫暖':
              break;
            case '打折':
              break;
            case '慶生':
              break;
            case '達標':
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
<style scoped>
.m1{
  color: rgb(255, 40, 55);
  border: 2px solid rgb(255, 40, 55);
}
.group-mark{
  font-weight: bold;
  color: gray;
}
</style>