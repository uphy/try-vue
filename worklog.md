# express + vue + vue-router + vuex

## nodeプロジェクト作成

```bash
$ mkdir vue-test
$ cd vue-test
$ npm init
```

プロジェクト名等入力。

以下のようなファイルが生成された。

```json
{
  "name": "vue-test",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "Yuhi Ishikura",
  "license": "ISC"
}
```

何も実行できないので、とりあえずindex.jsを作成。

```bash
echo console.log("hello") > index.js
```

package.jsonのいらない項目削除＆上記index.js実行タスク追加。

```json
{
  "name": "vue-test",
  "version": "1.0.0",
  "scripts": {
    "start": "node index.js"
  },
  "author": "Yuhi Ishikura"
}
```

実行

```bash
$ npm start

> vue-test@1.0.0 start /Users/ishikura/dev/heroku/vue-test
> node index.js

hello
```

## express導入

```
$ npm install --save express
```

package.jsonにexpressが追加された。

```json
...
  "dependencies": {
    "express": "^4.15.4"
  }
...
```

単純なAPI定義。
index.jsを以下のように変更。

```js
var express = require("express");
var app = express();

var server = app.listen(3000, function () {
    console.log("Node.js is listening to PORT:" + server.address().port);
});

app.get("/test", function (req, res, next) {
    res.json({
        "a": 1,
        "b": "123abc"
    });
});
```

実行

```
$ npm start
```

確認。

```bash
$ curl localhost:3000/test
{"a":1,"b":"123abc"}
```

## vue導入

サーバーとは切り離したかったので、プロジェクト直下にclientディレクトリを切って作成する。

vue-cliでボイラープレート生成。

```
$ npm install -g vue-cli
$ vue init simple client
```

client/index.htmlが生成された。

生成されたhtmlを、expressで簡易的に提供する。index.jsに以下を追記。

```js
app.use(express.static('client'));
```

ブラウザでlocalhost:3000/にアクセス。Vueのサンプルページが表示された。

## vueのコンポーネント化

webpackが難しいので、webpack-simpleのテンプレートを使った。

```
$ rm -rf client
$ vue init webpack-simple client
$ cd client
$ npm install
$ npm run dev
```

package.jsonも修正

```diff
   "name": "vue-test",
   "version": "1.0.0",
   "scripts": {
-    "start": "node index.js"
+    "start": "node index.js",
+    "build": "cd client && npm run build"
   },
   "author": "Yuhi Ishikura",
   "dependencies": {
```

## vue-router導入

```bash
$ cd client
$ npm install --save vue-router
```

ソースの変更は多すぎるので省略。
commit:6840b11

## vuex導入

```bash
$ cd client
$ npm install --save vuex
```

## API呼び出し

クライアントからAPIを呼び出してみる。  
vue-resourcesが非推奨になってるので、axios使う。

```bash
$ cd client
```
commit: 81cd421

## serverとclientの統合

今のところserverとclientを協調して動作させるためには、npm run build, npm run startしないといけない。  
実行が面倒な上に、hot deployじゃないので効率が悪い。  
serverとclientの両方をwebpackのdev serverで提供しようとしたが、[出来ないらしかった。](https://webpack.github.io/docs/webpack-dev-server.html#combining-with-an-existing-server)  
推奨される方法だと、production/developmentでindex.htmlのjsのリンクや、静的ファイルの提供方法を切り替えなければならず、複雑になりそうだった。

結局好みでサーバはgolangのechoに変更した。  
webpack dev serverのhot module replacementの恩恵は受けたかったので、
development環境では、webpack dev serverのプロセスとecho serverのプロセス２つを起動し、
echo serverに来たリクエストを、API以外はwebpack dev serverにプロキシするようにした。  
production環境では、echo serverのみを起動し、webpackでビルド済みのjsをecho serverで提供するようにした。
