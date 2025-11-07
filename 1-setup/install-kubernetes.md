
# 🚀 Покрокова інструкция підготовки та розгортання проекту Kubernetes

## 📋 ЗМІСТ

1. [Підготовка системи](#1-підготовка-системи)
2. [Встановлення Docker](#2-встановлення-docker)
3. [Встановлення Minikube](#3-встановлення-minikube)
4. [Встановлення kubectl](#4-встановлення-kubectl)
5. [Запуск Kubernetes кластера](#5-запуск-kubernetes-кластера)
6. [Налаштування Dashboard](#6-налаштування-dashboard)
7. [Розгортання проекту](#7-розгортання-проекту)
8. [Моніторинг](#8-моніторинг)
9. [Виправлення проблем](#9-виправлення-проблем)

---

## 1. ПІДГОТОВКА СИСТЕМИ

### Крок 1.1: Оновлення системи

```bash
sudo apt update && sudo apt upgrade -y
```

### Крок 1.2: Встановлення необхідних пакетів

```bash
sudo apt install -y curl wget git apt-transport-https ca-certificates \
    software-properties-common gnupg lsb-release
```

---

## 2. ВСТАНОВЛЕНня DOCKER

### Крок 2.1: Додавання репозиторію Docker

```bash
# Додаємо GPG ключ
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Додаємо репозиторій
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

### Крок 2.2: Встановлення Docker

```bash
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io
```

### Крок 2.3: Налаштування Docker

```bash
# Додаємо користувача до групи docker
sudo usermod -aG docker $USER
newgrp docker

# Запускаємо Docker
sudo systemctl enable docker
sudo systemctl start docker

# Перевірка
docker --version
docker run hello-world
```

---

## 3. ВСТАНОВЛЕННЯ MINIKUBE

### Крок 3.1: Завантаження та встановлення

```bash
# Завантажуємо Minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

# Встановлюємо
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64

# Перевірка
minikube version
```

### Крок 3.2: Налаштування драйвера

```bash
minikube config set driver docker
```

---

## 4. ВСТАНОВЛЕННЯ KUBECTL

### Крок 4.1: Встановлення kubectl

```bash
# Завантажуємо останню версію
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Встановлюємо
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
```

### Крок 4.2: Налаштування автодоповнення

```bash
echo 'source <(kubectl completion bash)' >> ~/.bashrc
echo 'alias k=kubectl' >> ~/.bashrc
echo 'complete -F __start_kubectl k' >> ~/.bashrc
source ~/.bashrc

# Перевірка
kubectl version --client
```

---

## 5. ЗАПУСК KUBERNETES КЛАСТЕРА

### Крок 5.1: Запуск Minikube кластера

```bash
# Запускаємо кластер з оптимальними налаштуваннями
minikube start --driver=docker --memory=4096 --cpus=2 --disk-size=20g
```

### Крок 5.2: Включення необхідних аддонів

```bash
minikube addons enable metrics-server
minikube addons enable dashboard
```

### Крок 5.3: Перевірка кластера

```bash
minikube status
kubectl cluster-info
kubectl get nodes
```

---

## 6. НАЛАШТУВАННЯ DASHBOARD

### Крок 6.1: Встановлення Kubernetes Dashboard

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
```

### Крок 6.2: Створення облікового запису адміністратора

```bash
kubectl apply -f - <<EOF
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kubernetes-dashboard
EOF
```

### Крок 6.3: Запуск Dashboard

```bash
# Надійний спосіб запуску
minikube service -n kubernetes-dashboard kubernetes-dashboard
```

### Крок 6.4: Отримання токену для входу

```bash
kubectl -n kubernetes-dashboard create token admin-user
```

**Збережіть цей токен для входу в Dashboard!**

---

## 7. РОЗГОРТАННЯ ПРОЄКТУ

### Крок 7.1: Клонування проекту

```bash
cd ~
git clone <your-repository-url> kubernetes-hands-on-project
cd kubernetes-hands-on-project
```

### Крок 7.2: Перевірка структури проекту

```bash
ls -la
find . -name "deploy-all.sh" -type f
```

### Крок 7.3: Надання прав виконання скриптам

```bash
chmod +x ./scripts/*.sh
```

### Крок 7.4: Розгортання проекту

```bash
cd kubernetes-hands-on-project
./scripts/deploy-all.sh
```

### Крок 7.5: Перевірка розгортання

```bash
kubectl get all
kubectl get pods --watch
```

---

## 8. МОНІТОРИНГ

### Крок 8.1: Моніторинг через Dashboard

```bash
# Якщо Dashboard закрився, перезапустіть:
minikube service -n kubernetes-dashboard kubernetes-dashboard
```

### Крок 8.2: Командний моніторинг

```bash
# Перегляд всіх ресурсів
kubectl get all

# Моніторинг подів
kubectl get pods -w

# Перегляд сервісів
kubectl get services

# Перегляд логів
kubectl logs -l app=<your-app-label> --tail=10
```

### Крок 8.3: Перевірка доступу до додатку

```bash
# Отримання URL для доступу до додатку
minikube service list
```

---

## 9. ВИПРАВЛЕННЯ ПРОБЛЕМ

### 🔄 ПОВНИЙ ПЕРЕЗАПУСК ВСІХ СЛУЖБ

#### Крок 9.1: Повний перезапуск Kubernetes середовища

```bash
#!/bin/bash
echo "🔄 ПОВНИЙ ПЕРЕЗАПУСК KUBERNETES СЕРЕДОВИЩА"

# Зупинити Minikube кластер
echo "1. Зупинка Minikube кластера..."
minikube stop

# Зупинити Docker
echo "2. Зупинка Docker..."
sudo systemctl stop docker

# Чекаємо 5 секунд
sleep 5

# Перезапуск Docker
echo "3. Перезапуск Docker..."
sudo systemctl start docker

# Чекаємо поки Docker повністю запуститься
echo "4. Очікування запуску Docker..."
sleep 10

# Перевірка статусу Docker
sudo systemctl status docker --no-pager

# Очищення Docker (опціонально)
echo "5. Очищення Docker ресурсів..."
docker system prune -f

# Перезапуск Minikube
echo "6. Перезапуск Minikube кластера..."
minikube start --driver=docker

# Перевірка статусу
echo "7. Перевірка статусу..."
minikube status
kubectl cluster-info

echo "✅ Перезапуск завершено!"
```

#### Крок 9.2: Перезапуск окремих компонентів

**Перезапуск Docker:**

```bash
# Повний перезапуск Docker
sudo systemctl daemon-reload
sudo systemctl restart docker
sudo systemctl status docker

# Перевірка
docker ps
docker info
```

**Перезапуск Minikube:**

```bash
# Перезапуск кластера
minikube stop
minikube delete  # повне видалення кластера
minikube start --driver=docker --memory=4096 --cpus=2

# Або швидкий перезапуск
minikube restart
```

**Перезапуск Kubernetes компонентів:**

```bash
# Перезапуск системних подів
kubectl get pods -n kube-system
kubectl delete pods -n kube-system -l component=kube-apiserver
kubectl delete pods -n kube-system -l component=kube-controller-manager
kubectl delete pods -n kube-system -l component=kube-scheduler

# Перезапуск Dashboard
kubectl delete pods -n kubernetes-dashboard --all
```

### 🚨 ВИРІШЕННЯ ПОШИРЕНИХ ПРОБЛЕМ

#### Проблема: Docker не запускається

```bash
# Повний перезапуск Docker
sudo systemctl stop docker
sudo systemctl stop containerd
sleep 5
sudo systemctl start containerd
sudo systemctl start docker
sudo systemctl status docker

# Якщо не допомогло - перевстановлення
sudo apt remove docker-ce docker-ce-cli containerd.io
sudo apt install docker-ce docker-ce-cli containerd.io
```

#### Проблема: Minikube не запускається

```bash
# Повне очищення та перезапуск
minikube delete
docker system prune -f
minikube start --driver=docker --cleanup=true

# Діагностика
minikube logs
minikube status -v
```

#### Проблема: Dashboard не відкривається

```bash
# Перезапуск всіх компонентів Dashboard
kubectl delete -n kubernetes-dashboard deployment kubernetes-dashboard
kubectl delete -n kubernetes-dashboard service kubernetes-dashboard
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml

# Альтернативний спосіб
kubectl proxy --port=8080 &
echo "Dashboard доступний за: http://localhost:8080/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/"
```

#### Проблема: Недостатньо ресурсів

```bash
# Зупинка та перезапуск з більшими ресурсами
minikube stop
minikube start --memory=8192 --cpus=4 --disk-size=30g

# Очищення ресурсів
kubectl delete pods --all --grace-period=0 --force
docker system prune -a -f
```

#### Проблема: Мережеві проблеми

```bash
# Перезапуск мережевих компонентів
sudo systemctl restart docker
minikube stop
minikube start

# Скидання мережевих правил
sudo iptables -F
sudo systemctl restart docker
```

### 🛠️ СКРИПТ ПОВНОГО ВІДНОВЛЕННЯ

Створіть файл `reset-k8s-environment.sh`:

```bash
#!/bin/bash
echo "🛠️ ПОВНЕ ВІДНОВЛЕННЯ KUBERNETES СЕРЕДОВИЩА"

echo "1. Зупинка всіх служб..."
minikube stop
sudo systemctl stop docker

echo "2. Очищення..."
docker system prune -a -f
minikube delete --all --purge

echo "3. Перезапуск Docker..."
sudo systemctl start docker
sleep 10

echo "4. Перезапуск Minikube..."
minikube start --driver=docker --memory=4096 --cpus=2

echo "5. Відновлення Dashboard..."
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml

echo "6. Перевірка..."
minikube status
kubectl get pods -A

echo "✅ Середовище повністю відновлено!"
```

```bash
chmod +x reset-k8s-environment.sh
./reset-k8s-environment.sh
```

### 📝 КОМАНДИ ШВИДКОГО ПЕРЕЗАПУСКУ

```bash
# Швидкий перезапуск всього середовища
sudo systemctl restart docker && minikube stop && minikube start

# Перезапуск тільки Kubernetes компонентів
minikube restart

# Перезапуск конкретного сервісу
kubectl rollout restart deployment/<deployment-name>

# Перезапуск всіх подів в неймспейсі
kubectl delete pods --all -n <namespace>
```

---

## 🎯 ШВИДКИЙ СЦЕНАРІЙ РОЗГОРТАННЯ

Створіть скрипт для швидкого розгортання:

### `quick-deploy.sh`

```bash
#!/bin/bash
echo "🚀 ШВИДКЕ РОЗГОРТАННЯ KUBERNETES ПРОЄКТУ"

# Перевірка та перезапуск служб
sudo systemctl status docker > /dev/null || sudo systemctl start docker
minikube status > /dev/null || minikube start --driver=docker

# Запуск Dashboard
minikube service -n kubernetes-dashboard kubernetes-dashboard --url &

# Розгортання проекту
cd kubernetes-hands-on-project
chmod +x ./scripts/*.sh
./scripts/deploy-all.sh

echo "✅ Проєкт розгорнуто!"
echo "🌐 Dashboard: minikube service -n kubernetes-dashboard kubernetes-dashboard"
echo "🔑 Токен: kubectl -n kubernetes-dashboard create token admin-user"
```

```bash
chmod +x quick-deploy.sh
./quick-deploy.sh
```

**Тепер у вас є повний набір інструкцій для підготовки, розгортання та вирішення проблем з повним перезапуском всіх служб!** 🎉
