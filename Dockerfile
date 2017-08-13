# -----------------------------
# clientモジュール(node)のビルド
# -----------------------------

FROM node:8 as client-builder
WORKDIR /app
# ビルド高速化のため、package.jsonだけコピーして、依存モジュールのインストールを先に行う。
COPY client/package.json .
RUN npm install
# 上でインストールしたnode_modulesを上書きしないように、node_modulesを削除してからビルド対象のソースをコピー
COPY client /work
RUN rm -rf /work/node_modules && \
    cp -RT /work /app/
# ビルド
RUN npm run build

FROM golang:1.8 as server-builder
COPY server /app
WORKDIR /app/src/github.com/uphy/tryvue-server
RUN GOPATH=/app go build -o tryvue-server main.go 

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=client-builder /app/dist ./dist
COPY --from=client-builder /app/public ./public/
COPY --from=server-builder /app/src/github.com/uphy/tryvue-server/tryvue-server ./
COPY --from=client-builder /app/index.html ./static/
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2
CMD ./tryvue-server

