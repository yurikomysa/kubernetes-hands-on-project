
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
git clone https://github.com/yurikomysa/kubernetes-hands-on-project.git
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

### 📄 1-setup/install-kubernetes.md

```markdown
# Встановлення Kubernetes з використанням Minikube

## Для Windows:
1. Встановіть Chocolatey:
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

2. Встановіть Minikube та kubectl:

```powershell
choco install minikube kubernetes-cli
```

## Для macOS:

```bash
# Встановлення через Homebrew
brew install minikube kubectl
```

## Для Linux (Ubuntu/Debian):

```bash
# Встановлення kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Встановлення Minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
```

## Запуск кластеру:

```bash
minikube start --driver=docker
minikube status
```

### 📄 1-setup/verify-setup.sh

```bash
#!/bin/bash

echo "🔍 Перевірка налаштування Kubernetes середовища..."

# Перевірка версії kubectl
echo "1. Перевірка kubectl..."
kubectl version --client

# Перевірка підключення до кластеру
echo "2. Перевірка підключення до кластеру..."
kubectl cluster-info

# Перевірка нод
echo "3. Перевірка доступних нод..."
kubectl get nodes

# Перевірка просторів імен
echo "4. Перевірка просторів імен..."
kubectl get namespaces

# Перевірка Minikube статусу
echo "5. Перевірка статусу Minikube..."
minikube status

echo "✅ Перевірка завершена!"
```

---

## 📁 2-BASIC-CONCEPTS

### 📄 2-basic-concepts/pods/simple-pod.yaml

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: simple-nginx-pod
  labels:
    app: nginx
    environment: test
spec:
  containers:
  - name: nginx-container
    image: nginx:1.25
    ports:
    - containerPort: 80
    resources:
      requests:
        memory: "64Mi"
        cpu: "250m"
      limits:
        memory: "128Mi"
        cpu: "500m"
```

### 📄 2-basic-concepts/pods/multi-container-pod.yaml

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: multi-container-pod
  labels:
    app: web-app
spec:
  containers:
  - name: nginx
    image: nginx:1.25
    ports:
    - containerPort: 80
  - name: logger
    image: busybox
    command: ['sh', '-c', 'while true; do echo "$(date) - Log message"; sleep 10; done']
```

### 📄 2-basic-concepts/deployments/basic-deployment.yaml

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.25
        ports:
        - containerPort: 80
        env:
        - name: NGINX_PORT
          value: "80"
        - name: ENVIRONMENT
          value: "production"
```

### 📄 2-basic-concepts/deployments/nginx-deployment.yaml

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-high-availability
  labels:
    app: nginx-ha
spec:
  replicas: 5
  selector:
    matchLabels:
      app: nginx-ha
  template:
    metadata:
      labels:
        app: nginx-ha
    spec:
      containers:
      - name: nginx
        image: nginx:alpine
        ports:
        - containerPort: 80
        resources:
          requests:
            memory: "128Mi"
            cpu: "100m"
          limits:
            memory: "256Mi"
            cpu: "200m"
        livenessProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 5
          periodSeconds: 10
```

### 📄 2-basic-concepts/services/clusterip-service.yaml

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    app: nginx
  ports:
  - name: http
    protocol: TCP
    port: 80
    targetPort: 80
  type: ClusterIP
```

### 📄 2-basic-concepts/services/nodeport-service.yaml

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-nodeport
spec:
  selector:
    app: nginx
  ports:
  - name: http
    protocol: TCP
    port: 80
    targetPort: 80
    nodePort: 30080
  type: NodePort
```

---

## 📁 3-WEB-APPLICATION

### 📄 3-web-application/app/Dockerfile

```dockerfile
FROM nginx:alpine

# Відкриття порту
EXPOSE 80

# Команда для запуску nginx
CMD ["nginx", "-g", "daemon off;"]
```

### 📄 3-web-application/app/index.html

```html
<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kubernetes Demo App</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>🚀 Kubernetes Demo Application</h1>
            <p>Цей додаток запущено в Kubernetes кластері</p>
        </header>
  
        <main>
            <div class="info-card">
                <h2>Інформація про Pod</h2>
                <div id="pod-info">
                    <p>Завантаження...</p>
                </div>
            </div>
  
            <div class="info-card">
                <h2>Статус сервісу</h2>
                <div id="service-status">
                    <p class="status-active">🟢 Сервіс активний</p>
                </div>
            </div>
  
            <div class="info-card">
                <h2>Метрики</h2>
                <div id="metrics">
                    <p>Час роботи: <span id="uptime">0</span> секунд</p>
                    <p>Запити: <span id="request-count">0</span></p>
                </div>
            </div>
        </main>
  
        <footer>
            <p>Kubernetes Basics Workshop © 2024</p>
        </footer>
    </div>
  
    <script src="app.js"></script>
</body>
</html>
```

### 📄 3-web-application/app/style.css

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    line-height: 1.6;
    color: #333;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
}

.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
}

header {
    text-align: center;
    margin-bottom: 40px;
    color: white;
}

header h1 {
    font-size: 2.5rem;
    margin-bottom: 10px;
    text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
}

header p {
    font-size: 1.2rem;
    opacity: 0.9;
}

main {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 20px;
    margin-bottom: 40px;
}

.info-card {
    background: white;
    padding: 25px;
    border-radius: 15px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.2);
    transition: transform 0.3s ease;
}

.info-card:hover {
    transform: translateY(-5px);
}

.info-card h2 {
    color: #4a5568;
    margin-bottom: 15px;
    font-size: 1.4rem;
    border-bottom: 2px solid #667eea;
    padding-bottom: 8px;
}

.status-active {
    color: #38a169;
    font-weight: bold;
}

.status-inactive {
    color: #e53e3e;
    font-weight: bold;
}

footer {
    text-align: center;
    color: white;
    opacity: 0.8;
}

#metrics p {
    margin: 8px 0;
    font-size: 1.1rem;
}

@media (max-width: 768px) {
    .container {
        padding: 10px;
    }
  
    header h1 {
        font-size: 2rem;
    }
  
    main {
        grid-template-columns: 1fr;
    }
}
```

### 📄 3-web-application/app/app.js

```javascript
class KubernetesApp {
    constructor() {
        this.startTime = Date.now();
        this.requestCount = 0;
        this.init();
    }

    init() {
        this.updatePodInfo();
        this.startMetrics();
        this.setupEventListeners();
    }

    updatePodInfo() {
        const podInfo = document.getElementById('pod-info');
  
        // Симуляція отримання інформації про Pod
        const podData = {
            name: 'web-app-pod-' + Math.floor(Math.random() * 1000),
            namespace: 'default',
            status: 'Running',
            ip: '10.244.' + Math.floor(Math.random() * 255) + '.' + Math.floor(Math.random() * 255),
            node: 'minikube'
        };

        podInfo.innerHTML = `
            <p><strong>Ім'я Pod:</strong> ${podData.name}</p>
            <p><strong>Namespace:</strong> ${podData.namespace}</p>
            <p><strong>Статус:</strong> <span class="status-active">${podData.status}</span></p>
            <p><strong>IP адреса:</strong> ${podData.ip}</p>
            <p><strong>Вузол:</strong> ${podData.node}</p>
        `;
    }

    startMetrics() {
        setInterval(() => {
            const uptime = Math.floor((Date.now() - this.startTime) / 1000);
            document.getElementById('uptime').textContent = uptime;
            document.getElementById('request-count').textContent = this.requestCount;
        }, 1000);
    }

    setupEventListeners() {
        // Симуляція запитів
        setInterval(() => {
            this.requestCount++;
        }, 3000);
    }
}

// Ініціалізація додатку при завантаженні сторінки
document.addEventListener('DOMContentLoaded', () => {
    new KubernetesApp();
});
```

### 📄 3-web-application/k8s/app-deployment.yaml

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-app-deployment
  labels:
    app: web-app
    version: v1
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web-app
  template:
    metadata:
      labels:
        app: web-app
        version: v1
    spec:
      containers:
      - name: web-app
        image: nginx:alpine
        ports:
        - containerPort: 80
        volumeMounts:
        - name: app-files
          mountPath: /usr/share/nginx/html
        resources:
          requests:
            memory: "64Mi"
            cpu: "100m"
          limits:
            memory: "128Mi"
            cpu: "200m"
        livenessProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 30
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 5
          periodSeconds: 5
      volumes:
      - name: app-files
        configMap:
          name: web-app-config
```

### 📄 3-web-application/k8s/app-service.yaml

```yaml
apiVersion: v1
kind: Service
metadata:
  name: web-app-service
  labels:
    app: web-app
spec:
  selector:
    app: web-app
  ports:
  - name: http
    protocol: TCP
    port: 80
    targetPort: 80
  type: NodePort
```

### 📄 3-web-application/k8s/app-configmap.yaml

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: web-app-config
data:
  index.html: |
    <!DOCTYPE html>
    <html lang="uk">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Kubernetes Demo App</title>
        <link rel="stylesheet" href="style.css">
    </head>
    <body>
        <div class="container">
            <header>
                <h1>🚀 Kubernetes Demo Application</h1>
                <p>Цей додаток запущено в Kubernetes кластері</p>
            </header>
  
            <main>
                <div class="info-card">
                    <h2>Інформація про Pod</h2>
                    <div id="pod-info">
                        <p>Завантаження...</p>
                    </div>
                </div>
      
                <div class="info-card">
                    <h2>Статус сервісу</h2>
                    <div id="service-status">
                        <p class="status-active">🟢 Сервіс активний</p>
                    </div>
                </div>
      
                <div class="info-card">
                    <h2>Метрики</h2>
                    <div id="metrics">
                        <p>Час роботи: <span id="uptime">0</span> секунд</p>
                        <p>Запити: <span id="request-count">0</span></p>
                    </div>
                </div>
            </main>
  
            <footer>
                <p>Kubernetes Basics Workshop © 2024</p>
            </footer>
        </div>
  
        <script src="app.js"></script>
    </body>
    </html>
  
  style.css: |
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        line-height: 1.6;
        color: #333;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        min-height: 100vh;
    }

    .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
    }

    header {
        text-align: center;
        margin-bottom: 40px;
        color: white;
    }

    header h1 {
        font-size: 2.5rem;
        margin-bottom: 10px;
        text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
    }

    header p {
        font-size: 1.2rem;
        opacity: 0.9;
    }

    main {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 20px;
        margin-bottom: 40px;
    }

    .info-card {
        background: white;
        padding: 25px;
        border-radius: 15px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        transition: transform 0.3s ease;
    }

    .info-card:hover {
        transform: translateY(-5px);
    }

    .info-card h2 {
        color: #4a5568;
        margin-bottom: 15px;
        font-size: 1.4rem;
        border-bottom: 2px solid #667eea;
        padding-bottom: 8px;
    }

    .status-active {
        color: #38a169;
        font-weight: bold;
    }

    .status-inactive {
        color: #e53e3e;
        font-weight: bold;
    }

    footer {
        text-align: center;
        color: white;
        opacity: 0.8;
    }

    #metrics p {
        margin: 8px 0;
        font-size: 1.1rem;
    }

    @media (max-width: 768px) {
        .container {
            padding: 10px;
        }
  
        header h1 {
            font-size: 2rem;
        }
  
        main {
            grid-template-columns: 1fr;
        }
    }
  
  app.js: |
    class KubernetesApp {
        constructor() {
            this.startTime = Date.now();
            this.requestCount = 0;
            this.init();
        }

        init() {
            this.updatePodInfo();
            this.startMetrics();
            this.setupEventListeners();
        }

        updatePodInfo() {
            const podInfo = document.getElementById('pod-info');
  
            // Симуляція отримання інформації про Pod
            const podData = {
                name: 'web-app-pod-' + Math.floor(Math.random() * 1000),
                namespace: 'default',
                status: 'Running',
                ip: '10.244.' + Math.floor(Math.random() * 255) + '.' + Math.floor(Math.random() * 255),
                node: 'minikube'
            };

            podInfo.innerHTML = `
                <p><strong>Ім'я Pod:</strong> ${podData.name}</p>
                <p><strong>Namespace:</strong> ${podData.namespace}</p>
                <p><strong>Статус:</strong> <span class="status-active">${podData.status}</span></p>
                <p><strong>IP адреса:</strong> ${podData.ip}</p>
                <p><strong>Вузол:</strong> ${podData.node}</p>
            `;
        }

        startMetrics() {
            setInterval(() => {
                const uptime = Math.floor((Date.now() - this.startTime) / 1000);
                document.getElementById('uptime').textContent = uptime;
                document.getElementById('request-count').textContent = this.requestCount;
            }, 1000);
        }

        setupEventListeners() {
            // Симуляція запитів
            setInterval(() => {
                this.requestCount++;
            }, 3000);
        }
    }

    // Ініціалізація додатку при завантаженні сторінки
    document.addEventListener('DOMContentLoaded', () => {
        new KubernetesApp();
    });
```

### 📄 3-web-application/k8s/app-secret.yaml

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: web-app-secret
type: Opaque
data:
  database-url: ZGI6Ly91c2VyOnBhc3N3b3JkQGxvY2FsaG9zdDozMzA2L2FwcA==
  api-key: bXktc2VjcmV0LWFwaS1rZXk=
```

---

## 📁 4-ADVANCED

### 📄 4-advanced/configmaps/app-config.yaml

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  app.name: "Kubernetes Web App"
  app.version: "1.0.0"
  environment: "development"
  log.level: "info"
```

### 📄 4-advanced/configmaps/nginx-config.yaml

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: nginx-config
data:
  default.conf: |
    server {
        listen 80;
        server_name _;
  
        location / {
            root /usr/share/nginx/html;
            index index.html index.htm;
        }
  
        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
            root /usr/share/nginx/html;
        }
    }
```

### 📄 4-advanced/secrets/app-secrets.yaml

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: app-secrets
type: Opaque
data:
  database-password: c2VjcmV0cGFzc3dvcmQ=
  api-key: bXlhcGlrZXk=
  jwt-secret: c3VwZXItc2VjcmV0LWp3dC1rZXk=
```

### 📄 4-advanced/volumes/persistent-volume.yaml

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: app-pv
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/data/app-pv"
  persistentVolumeReclaimPolicy: Retain
```

### 📄 4-advanced/volumes/persistent-volume-claim.yaml

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: app-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
```

### 📄 4-advanced/ingress/ingress.yaml

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: web-app-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    kubernetes.io/ingress.class: "nginx"
spec:
  rules:
  - host: web-app.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: web-app-service
            port:
              number: 80
```

---

## 📁 5-MONITORING

### 📄 5-monitoring/dashboard/kubernetes-dashboard.yaml

```yaml
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
```

### 📄 5-monitoring/commands/monitoring-commands.md

```markdown
# Команди моніторингу Kubernetes

## Основні команди для спостереження

```bash
# Перегляд ресурсів в реальному часі
kubectl get pods -w
kubectl get deployments -w

# Перегляд логів
kubectl logs -f <pod-name>
kubectl logs --tail=100 <pod-name>

# Моніторинг ресурсів
kubectl top nodes
kubectl top pods

# Перегляд подій
kubectl get events --sort-by=.metadata.creationTimestamp
kubectl get events --field-selector type=Warning
```

## Команди для налагодження

```bash
# Перевірка стану сервісів
kubectl get endpoints

# Перевірка конфігурації
kubectl get configmaps
kubectl get secrets

# Перевірка томів
kubectl get pv
kubectl get pvc
```

---

## 📁 6-TROUBLESHOOTING

### 📄 6-troubleshooting/common-issues.md

# Поширені проблеми та їх вирішення

## 1. Pod не запускається

**Симптоми:** Pod в статусі Pending, CrashLoopBackOff
**Рішення:**

```bash
kubectl describe pod <pod-name>
kubectl logs <pod-name>
kubectl get events
```

## 2. Service не працює

**Симптоми:** Не можу з'єднатися з сервісом
**Рішення:**

```bash
kubectl describe service <service-name>
kubectl get endpoints
kubectl get pods -l app=<label>
```

## 3. Проблеми з образами

**Симптоми:** ImagePullBackOff
**Рішення:**

```bash
kubectl describe pod <pod-name>
# Перевірити назву образу та репозиторій
```

## 4. Проблеми з ресурсами

**Симптоми:** Pod в статусі Pending
**Рішення:**

```bash
kubectl describe node
kubectl top nodes
```

### 📄 6-troubleshooting/debug-commands.sh

```bash
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
```

---

## 📁 SCRIPTS

### 📄 scripts/deploy-all.sh

```bash
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
```

### 📄 scripts/health-check.sh

```bash
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
```

### 📄 scripts/teardown.sh

```bash
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
```

---

## 📁 DOCS

### 📄 docs/cheatsheet.md

# Kubernetes Cheat Sheet

## Основні команди

### Перегляд ресурсів

```bash
kubectl get pods
kubectl get services
kubectl get deployments
kubectl get all
kubectl get nodes
```

### Детальна інформація

```bash
kubectl describe pod <name>
kubectl describe service <name>
kubectl describe deployment <name>
```

### Робота з Pod

```bash
kubectl logs <pod-name>
kubectl exec -it <pod-name> -- /bin/bash
kubectl port-forward <pod-name> 8080:80
```

### Управління розгортанням

```bash
kubectl apply -f file.yaml
kubectl delete -f file.yaml
kubectl scale deployment <name> --replicas=5
kubectl rollout status deployment/<name>
```

## Поширені YAML-структури

### Pod

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  containers:
  - name: app
    image: nginx
    ports:
    - containerPort: 80
```

### Deployment

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
      - name: app
        image: nginx
        ports:
        - containerPort: 80
```

### Service

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  selector:
    app: my-app
  ports:
  - port: 80
    targetPort: 80
  type: ClusterIP
```

### 📄 docs/best-practices.md

```markdown
# Найкращі практики Kubernetes

## 1. Безпека
- Використовуйте Secrets для конфіденційних даних
- Обмежуйте права доступу за допомогою RBAC
- Використовуйте Security Context

## 2. Надійність
- Завжди використовуйте Deployment замість Pod
- Налаштовуйте Liveness та Readiness проби
- Встановлюйте обмеження ресурсів (limits/requests)

## 3. Моніторинг
- Використовуйте логи та метрики
- Налаштовуйте алерти
- Моніторьте ресурси нод

## 4. Масштабування
- Використовуйте Horizontal Pod Autoscaler
- Плануйте ресурси заздалегідь
- Тестуйте навантаження
```

---

## 🎯 ІНСТРУКЦІЯ ДЛЯ ЗАПУСКУ

### Крок 1: Підготовка середовища

```bash
# Створення директорії проекту
mkdir kubernetes-hands-on-project
cd kubernetes-hands-on-project

# Створення всіх директорій
mkdir -p {1-setup,2-basic-concepts/{pods,deployments,services},3-web-application/{app,k8s},4-advanced/{configmaps,secrets,volumes,ingress},5-monitoring/{dashboard,commands},6-troubleshooting,scripts,docs}

# Надання прав на виконання скриптів
chmod +x scripts/*.sh
chmod +x 1-setup/verify-setup.sh
chmod +x 6-troubleshooting/debug-commands.sh
```

### Крок 2: Встановлення та перевірка

```bash
# Встановлення за інструкцією в 1-setup/install-kubernetes.md
# Запуск перевірки
./1-setup/verify-setup.sh
```

### Крок 3: Запуск проекту

```bash
# Повне розгортання
./scripts/deploy-all.sh
```

### Крок 4: Перевірка роботи

```bash
# Перевірка здоров'я
./scripts/health-check.sh

# Перегляд додатку
minikube service web-app-service --url
```

### Крок 5: Тестування

```bash
# Масштабування
kubectl scale deployment web-app-deployment --replicas=5

# Перевірка оновлення
kubectl get pods -w

# Тестування відмовостійкості
kubectl delete pod -l app=web-app
```

---
