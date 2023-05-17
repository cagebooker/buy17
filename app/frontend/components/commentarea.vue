<template>
  <div>
    <div class="comment-button" @click="load">留言板</div>
    <div class="comment-area" v-if="editing">
      <div class="content-area">
        <div class="iconarea" >
          評價：
          <span class="icon" @click="editing = false">
            <i class="fa-solid fa-xmark" ></i>
          </span>
          
        </div>
        <div v-for="comment in comments"> 
          {{ comment.name }}：
          {{ comment.content }}
        </div>
      </div>
      
      
      <input class="input-kg" placeholder="寫出你的意見" type="text" name="content" v-model="content">  
      <input type="hidden" id="user_id" name="user_id" :value="userId">
      <button class="button" @click="send">送出</button>
      
      
    </div>
    
  </div>
  
</template>

<script>
export default{
    name: 'commentarea',
    props: ["storeId","groupId","userId","userName"],
    data: function(){
        return{
          editing: false,
          url: `/groups/${this.groupId}/stores/${this.storeId}/comments`,
          content: ''
        }
    },
    computed:{
      comments() {return this.$store.state.comments}
    },
    methods:{
      send(evt){
        // evt.preventDefault();
        if(this.content == ''){

        }else{
          this.$store.dispatch("createComment", 
          {
            content: this.content,
            store_id: this.storeId,
            group_id: this.groupId,
            user_id: this.userId,
            url: this.url,
            name: this.userName,
          });
          this.content = '';
        }
        
      },
      load(){
        this.editing = !this.editing;
        this.$store.dispatch("loadComments",this.url); 
      }
      
    },

}
</script>
<style lang="scss" scoped>
.input-kg{
  position: absolute;
  bottom:5px;
  width: 90%;
  left: 5px;
  outline: none;
  border: none;
  border-bottom: 1px solid transparent;
  background-color: #d9d9da;
  line-height: 24px;
  font-size: 16px;
  padding-left: 6px;
  border-radius: 3px;
  // transition: 0.3s;
  &:hover{
    border-bottom: 1px solid rgb(30, 30, 30);
  }
}
.idarea{
  position: absolute;
  top:100px;
}
.button{
  position: absolute;
  bottom: 5px;
  right: 5px;
  height:28px;
  outline: none;
  &:focus{
    outline:none;
  }
}
.content-area{
  // border: 1px solid gray;
  width: 290px;
  height: 250px;
  position: relative;
  top: 0px;
  padding:10px;
  overflow-y: scroll;
}
.iconarea{

  // border: 1px solid gray;
  top: 0px;
  display: block;
  width: 280px;
}
.icon{
  position: absolute;
  right: 10px;
  cursor: pointer;
  top: 10px;
  border: 1px solid transparent;
  transition: 0.1s;
  border-radius: 50%;
  &:hover{
    border: 1px solid rgb(45, 45, 45);
  }
}
</style>