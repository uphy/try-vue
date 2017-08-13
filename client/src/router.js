import Vue from 'vue'
import VueRouter from 'vue-router'
import MyView from './views/MyView.vue'
import NotFound from './views/NotFound.vue'

Vue.use(VueRouter)

const Foo = { template: '<div>foo</div>' }
const Bar = { template: '<div>bar</div>' }
const routes = [
    { path: '/', redirect: 'demo' },
    { path: '/foo', component: Foo },
    { path: '/bar', component: Bar },
    { path: '/demo', component: MyView },
    { path: '*', component: NotFound }
]

export default new VueRouter({ routes })
