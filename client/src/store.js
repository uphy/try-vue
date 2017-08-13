import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex);

var state = {
    count: 0
};
var mutations = {
    increment(state) {
        state.count++
    },
    reset(state) {
        state.count = 0;
    }
};

export default new Vuex.Store({
    state,
    mutations
})
