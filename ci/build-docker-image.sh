#!/bin/sh

docker build -f Dockerfile ../ -t go-stat-backend:latest
docker save go-stat-backend:latest | gzip -c > go-stat-backend.tar.gz
