#!/usr/bin/env sh

go build -o ./go-stat -ldflags "-s -w" main.go
