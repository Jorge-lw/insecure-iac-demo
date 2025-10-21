#!/usr/bin/env bash
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/insecure-configmap.yaml
kubectl apply -f k8s/insecure-deployment.yaml
kubectl apply -f k8s/insecure-service.yaml

