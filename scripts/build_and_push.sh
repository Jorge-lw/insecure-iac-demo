#!/usr/bin/env bash
set -e
IMAGE="your-dockerhub-user/insecure-app:latest"
cd ../insecure-app-demo
docker build -t $IMAGE .
docker push $IMAGE

