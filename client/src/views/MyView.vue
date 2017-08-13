<template>
  <div>
    <img src="/public/logo.png">
    <h1>{{ msg }}</h1>
    Message from server: {{messageFromServer}}
    <links />
  </div>
</template>

<script language="typescript">
import Links from '../components/Links.vue'
import axios from 'axios'

export default {
  name: 'app',
  components: {
    Links
  },
  created() {
    axios.get("/api/test")
      .then(res => {
        this.messageFromServer = res.data;
      })
      .catch(e => {
        this.messageFromServer = 'error';
      });
  },
  data() {
    return {
      msg: 'Welcome to Your Vue.js App',
      messageFromServer: null
    }
  }
}
</script>

<style lang="scss" scoped>

</style>
