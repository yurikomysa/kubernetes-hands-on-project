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
