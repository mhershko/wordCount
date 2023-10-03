#!/bin/bash

docker rm $(docker ps -a -q)
docker buildx prune -f
docker image prune -a -f
docker container prune -f
docker build  --tag "word-count:latest" --no-cache .
docker-compose up -d
docker ps -a
