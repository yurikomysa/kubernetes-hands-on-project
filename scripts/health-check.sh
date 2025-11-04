#!/bin/bash

echo "🏥 Перевірка здоров'я кластеру..."

echo "1. Перевірка нод:"
kubectl get nodes

echo "2. Перевірка Pod:"
kubectl get pods -o wide

echo "3. Перевірка Services:"
kubectl get services

echo "4. Перевірка Deployments:"
kubectl get deployments

echo "5. Логи додатку:"
kubectl logs -l app=web-app --tail=10

echo "6. Опис Pod:"
kubectl describe pods -l app=web-app

echo "✅ Перевірка завершена!"
