<template>
    <div>
        <div class="buttons">
            <input type="button" value="Increment" v-on:click="$store.commit('increment')"></input>
            <input type="button" value="Reset" v-on:click="$store.commit('reset')"></input>
        </div>
        <span class="count">
            {{this.$store.state.count}}
        </span>
    </div>
</template>

<style scoped>
.buttons {
    background-color: gray;
    border: solid 1px black;
}

.count {
    color: red;
}
</style>
