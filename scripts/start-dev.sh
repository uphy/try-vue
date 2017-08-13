#!/bin/bash

cd client && npm run dev &
GOPATH=$(pwd)/server
cd server/src/github.com/uphy/tryvue-server
go run main.go
