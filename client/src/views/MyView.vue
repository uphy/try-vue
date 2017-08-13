<template>
  <div>
    <img src="/public/logo.png">
    <h1>{{ msg }}</h1>
    <links />
  </div>
</template>

<script language="typescript">
import Links from '../components/Links.vue'

export default {
  name: 'app',
  components: {
    Links
  },
  data() {
    return {
      msg: 'Welcome to Your Vue.js App'
    }
  }
}
</script>

<style lang="scss" scoped>

</style>
