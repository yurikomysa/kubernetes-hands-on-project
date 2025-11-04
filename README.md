# 🚀 Kubernetes Hands-on Project

Практичний проект для освоєння Kubernetes через створення та розгортання веб-додатку.

## 📋 Зміст проекту

1. **Налаштування середовища** - встановлення та конфігурація
2. **Основні концепції** - Pod, Deployment, Service
3. **Веб-додаток** - повноцінний додаток з фронтендом
4. **Розширені можливості** - ConfigMaps, Secrets, Volumes
5. **Моніторинг** - інструменти для спостереження
6. **Діагностика** - вирішення проблем

## 🏁 Швидкий старт

### Вимоги

- Docker
- Minikube
- kubectl

## 📁 ПОВНА СТРУКТУРА ПРОЕКТУ

```
kubernetes-hands-on-project/
│
├── README.md
├── 1-setup/
│   ├── install-kubernetes.md
│   └── verify-setup.sh
│
├── 2-basic-concepts/
│   ├── pods/
│   │   ├── simple-pod.yaml
│   │   └── multi-container-pod.yaml
│   ├── deployments/
│   │   ├── basic-deployment.yaml
│   │   └── nginx-deployment.yaml
│   └── services/
│       ├── clusterip-service.yaml
│       └── nodeport-service.yaml
│
├── 3-web-application/
│   ├── app/
│   │   ├── Dockerfile
│   │   ├── index.html
│   │   ├── style.css
│   │   └── app.js
│   └── k8s/
│       ├── app-deployment.yaml
│       ├── app-service.yaml
│       ├── app-configmap.yaml      # ✅ містить index.html, style.css, app.js
│       └── app-secret.yaml
│
├── 4-advanced/
│   ├── configmaps/
│   │   ├── app-config.yaml         # ✅ метадані (не конфліктує з web-app-config)
│   │   └── nginx-config.yaml
│   ├── secrets/
│   │   └── app-secrets.yaml
│   ├── volumes/
│   │   ├── persistent-volume.yaml
│   │   └── persistent-volume-claim.yaml
│   └── ingress/
│       └── ingress.yaml            # ✅ припускає `minikube addons enable ingress`
│
├── 5-monitoring/
│   ├── dashboard/
│   │   └── kubernetes-dashboard.yaml
│   └── commands/
│       └── monitoring-commands.md
│
├── 6-troubleshooting/
│   ├── common-issues.md
│   └── debug-commands.sh
│
├── scripts/
│   ├── deploy-all.sh               # ✅ виправлені шляхи, використовує лише 3-web-application/k8s/*
│   ├── teardown.sh
│   └── health-check.sh
│
└── docs/
    ├── project-guide.md
    ├── cheatsheet.md
    └── best-practices.md
```

### Запуск проекту

```bash
# Клонування проекту
git clone <repository-url>
cd kubernetes-hands-on-project

# Надання прав на виконання скриптів
chmod +x scripts/*.sh

# Запуск повного розгортання
./scripts/deploy-all.sh

# Перевірка стану
./scripts/health-check.sh
```

> 💡 Для роботи Ingress виконайте: `minikube addons enable ingress`

### Кроки навчання

1. **Етап 1**: Налаштування середовища
2. **Етап 2**: Основи Kubernetes
3. **Етап 3**: Розгортання додатку
4. **Етап 4**: Розширені функції
5. **Етап 5**: Моніторинг та діагностика

## 🛠 Команди для навчання

```bash
# Перегляд всіх ресурсів
kubectl get all

# Детальна інформація про Pod
kubectl describe pod <pod-name>

# Перегляд логів
kubectl logs -f <pod-name>

# Масштабування Deployment
kubectl scale deployment web-app-deployment --replicas=5

# Оновлення образу
kubectl set image deployment/web-app-deployment web-app=nginx:latest
```

## 📚 Корисні посилання

- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
- [Minikube Guide](https://minikube.sigs.k8s.io/docs/)

---

## 📁 1-SETUP

## Generated project files

This project was generated from the provided `12.md` content.
