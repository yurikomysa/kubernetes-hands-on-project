#!/bin/bash

echo "🧹 Очищення ресурсів Kubernetes..."

# Перехід до кореня проекту
cd "$(dirname "$0")/.."

echo "1. Видалення Deployment..."
kubectl delete -f 3-web-application/k8s/app-deployment.yaml

echo "2. Видалення Service..."
kubectl delete -f 3-web-application/k8s/app-service.yaml

echo "3. Видалення ConfigMaps..."
kubectl delete -f 3-web-application/k8s/app-configmap.yaml

echo "4. Видалення Secrets..."
kubectl delete -f 3-web-application/k8s/app-secret.yaml

echo "5. Видалення простору імен..."
kubectl delete namespace web-app

echo "6. Перевірка, що все видалено:"
kubectl get all -n web-app

echo "✅ Очищення завершено!"