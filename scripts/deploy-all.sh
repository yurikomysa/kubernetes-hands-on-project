#!/bin/bash

echo "🚀 Початок розгортання додатку в Kubernetes..."

# Перехід до кореня проекту
cd "$(dirname "$0")/.."

# Створення простору імен
echo "1. Створення простору імен..."
kubectl create namespace web-app || true

# Застосування ConfigMaps
echo "2. Застосування ConfigMaps..."
kubectl apply -f 3-web-application/k8s/app-configmap.yaml

# Застосування Secrets
echo "3. Застосування Secrets..."
kubectl apply -f 3-web-application/k8s/app-secret.yaml

# Розгортання додатку
echo "4. Розгортання Deployment..."
kubectl apply -f 3-web-application/k8s/app-deployment.yaml

# Створення Service
echo "5. Створення Service..."
kubectl apply -f 3-web-application/k8s/app-service.yaml

# Очікування готовності Pod
echo "6. Очікування готовності Pod..."
kubectl wait --for=condition=ready pod -l app=web-app --timeout=120s

# Отримання інформації про розгортання
echo "7. Інформація про розгортання:"
kubectl get deployments
kubectl get pods
kubectl get services

echo "✅ Розгортання завершено!"
echo "🌐 Додаток доступний за адресою:"
minikube service web-app-service --url