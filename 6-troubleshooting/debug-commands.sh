#!/bin/bash

echo "🐛 Запуск діагностики Kubernetes кластеру..."

echo "1. Загальний стан кластеру:"
kubectl get all

echo "2. Стан нод:"
kubectl describe nodes

echo "3. Події кластеру:"
kubectl get events --sort-by=.metadata.creationTimestamp

echo "4. Сервіси та їх endpoints:"
kubectl get services
kubectl get endpoints

echo "5. Перевірка Pod:"
kubectl get pods -o wide
kubectl describe pods

echo "6. Логи всіх Pod:"
for pod in $(kubectl get pods -o jsonpath='{.items[*].metadata.name}'); do
    echo "=== Логи Pod: $pod ==="
    kubectl logs $pod --tail=10
done

echo "✅ Діагностика завершена!"
