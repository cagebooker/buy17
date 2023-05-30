import Vue from 'vue/dist/vue.esm';
import Vuex from 'vuex';
import axios from 'axios';
import Rails from '@rails/ujs'

Vue.use(Vuex);

const store = new Vuex.Store({
  state: {
    // 設定狀態值
    answers: [],
    comments: [],
    postits: []
  },
  mutations: {
    // 設定修改狀態值的方法
    CHAT_GPT(state,res){
      // console.log(res);
      state.answers.unshift(res.problem);
      state.answers.unshift(res.res);
      
      // console.log(state.answers);
    },
    CHAT_GPT_QUESTION(state,res){
      // console.log(res);
      // state.answers.unshift(res);
    },
    LOAD_COMMENTS(state, comments){
      // console.log(comments.data)
      state.comments = comments.data;
      state.comments.reverse();
    },
    CREATE_COMMENT(state, comment){
      // console.log(comment.data)
      state.comments.unshift(comment.data);
    },
    LOAD_POSTIT(state, postits){
      state.postits = JSON.parse(JSON.stringify(postits))
      // JSON.parse(JSON.stringify(state.postits))
      // console.log(postits)
    },
    CREATE_POST(state,postit){
      state.postits.push(postit)
    },
    DELETE_POST(state,pid){
      // console.log(pid)
      state.postits.splice(pid,1)
    }
  },
  actions: {
    changeText({commit},postit){
      let id = postit.id
      if(id != null){
        let data = new FormData()
        data.append("content", postit.content)
        data.append("color", postit.color)
        data.append("pos_x", postit.pos_x)
        data.append("pos_y", postit.pos_y)
        Rails.ajax({
          url:`/postits/${id}`,
          type: 'PUT',
          data,
          dataType:'json',
          success: res => {
            // commit('CREATE_POST',res)
            // console.log(res)
          },
          error: err => {
            console.log(err)
          }
        }) 
      }
    },
    changeColor({commit},postit){
      // console.log(postit);
      let id = postit.id
      if(id != null){
        let data = new FormData()
        data.append("content", postit.content)
        data.append("color", postit.color)
        data.append("pos_x", postit.pos_x)
        data.append("pos_y", postit.pos_y)
        Rails.ajax({
          url:`/postits/${id}`,
          type: 'PUT',
          data,
          dataType:'json',
          success: res => {
            // commit('CREATE_POST',res)
            // console.log(res)
          },
          error: err => {
            console.log(err)
          }
        }) 
      }
      
    },
    updatePostit({commit},postit){
      // console.log(postit);
      let id = postit.id
      if(id != null){
        let data = new FormData()
        data.append("content", postit.content)
        data.append("color", postit.color)
        data.append("pos_x", postit.pos_x)
        data.append("pos_y", postit.pos_y)
        Rails.ajax({
          url:`/postits/${id}`,
          type: 'PUT',
          data,
          dataType:'json',
          success: res => {
            // commit('CREATE_POST',res)
            // console.log(res)
          },
          error: err => {
            console.log(err)
          }
        }) 
      }
      
    },
    loadPostits({commit}){
      // console.log('hello my god')
      Rails.ajax({
        url: '/postits.json',
        type: 'GET',
        dataType: 'json',
        success: res => {
          // console.log(res)
          commit('LOAD_POSTIT',res)
          // console.log(res)
        },
        error: err => {
          console.log(err)
        }
      })
    },
    addPost({commit},postit){
      // console.log(postit.color)
      let data = new FormData()
      data.append("content", postit.text)
      data.append("color", postit.color)
      data.append("pos_x", postit.pos.x)
      data.append("pos_y", postit.pos.y)
      Rails.ajax({
        url:'/postits',
        type: 'POST',
        data,
        dataType:'json',
        success: res => {
          commit('CREATE_POST',res)
          console.log(res)
        },
        error: err => {
          console.log(err)
        }
      })
    },
    deletePost({commit},data){
      let id = data.p_id
      // console.log(data.p_id)
      // console.log(data.pid)
      Rails.ajax({
        url:`/postits/${id}`,
        type: 'DELETE',
        dataType:'json',
        success: res => {
          commit('DELETE_POST',data.pid)
          console.log(res)
        },
        error: err => {
          console.log(err)
        }
      })
    },
    chatgpt({commit},data){
      // console.log(data.problem);
      // commit('CHAT_GPT_QUESTION',data.problem);
      axios.post('https://api.openai.com/v1/completions', {
        model:'text-davinci-003',
        // messages: [{ role: 'assistant', content: message }],
        prompt: data.problem,
        max_tokens: 600,
        temperature: 0
      }, {
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer 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"
        }
      })
        .then(function (response) {
          commit('CHAT_GPT',{res:response.data.choices[0].text, problem: data.problem})
          // console.log(response.data.choices[0].text);
        })
        .catch(function (error) {
          console.log(error);
        });
    },
    loadComments({commit},url){
      // console.log(url);
      axios.get(url).then((res)=>{
        // console.log(res);
        commit('LOAD_COMMENTS',res)
      }) .catch((err)=>{
        console.log(err);
      })
    },
    createComment({commit},data){
      // console.log(data);
      axios.post(data.url,data)
      .then((res)=>{
        // console.log(res);
        commit("CREATE_COMMENT",res)
      }).catch((err)=>{console.log(err)})
    }
  },
  getters: {
    // 設定獲取狀態值的方法
  }
});

export default store;