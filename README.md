# Vue example

## Technologies

- client: nodejs/vue/vue-router/vuex
- server: golang/echo

## How to run

### Development

**Preparation**

```bash
$ cd client
$ npm install
$ cd -
$ GOPATH=$(pwd)/server
$ cd server/src/github.com/uphy/tryvue-server
$ glide install
$ cd -
```

**Run**

```bash
$ npm run dev
```

Open http://localhost:8080/

In development environment, there are 2 processes, webpack-dev-server(port 8081) and golang echo server(port 8080).  
The client-side codes change can be applied automatically with hot module replacement of webpack.

### Production

```bash
$ npm run prod
```

In production environment, there is only 1 process, golang echo server.  
Echo server provides the client-side code which are minified, uglified by webpack.