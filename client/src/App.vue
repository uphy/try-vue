<template>
    <div id="container">
        <h1>Example</h1>
        <ul>
            <li>
                <router-link to="/">/</router-link>
            </li>
            <li>
                <router-link to="/demo">/demo</router-link>
            </li>
            <li>
                <router-link to="/counter">/counter</router-link>
            </li>
            <li>
                <router-link to="/foo">/foo</router-link>
            </li>
            <li>
                <router-link to="/bar">/bar</router-link>
            </li>
            <router-link tag="li" to="/bar" :event="['mousedown', 'touchstart']">
                <a>/bar</a>
            </router-link>
        </ul>
        <router-view class="view"></router-view>
    </div>
</template>

<style>
#container {
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: #2c3e50;
    margin-top: 60px;
}

h1,
h2 {
    font-weight: normal;
}

ul {
    list-style-type: none;
    padding: 0;
}

li {
    display: inline-block;
    margin: 0 10px;
}

a {
    color: #42b983;
}
</style>
