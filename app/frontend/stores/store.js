import Vue from 'vue/dist/vue.esm';
import Vuex from 'vuex';
import axios from 'axios';

Vue.use(Vuex);

const store = new Vuex.Store({
  state: {
    // 設定狀態值
    answers: [],
    comments: []
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
    }
  },
  actions: {
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