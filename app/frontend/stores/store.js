import Vue from 'vue/dist/vue.esm';
import Vuex from 'vuex';
import axios from 'axios';

Vue.use(Vuex);

const store = new Vuex.Store({
  state: {
    // 設定狀態值
    answers: []
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
    }
  },
  getters: {
    // 設定獲取狀態值的方法
  }
});

export default store;