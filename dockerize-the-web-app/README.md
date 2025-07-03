# 🐳 Containerized Full-Stack Metrics Dashboard

This project is a **Dockerized 3-tier application** that collects real-time system metrics (CPU, RAM, Disk, Network), stores them in PostgreSQL, and visualizes them live using Chart.js on a responsive Bootstrap frontend.

---

## 🧱 Architecture

- **Frontend**: Nginx + Bootstrap + Chart.js  
- **Backend**: Node.js (Express) API  
- **Database**: PostgreSQL 15  
- **Infrastructure**: Docker Compose  
- **Live Visualization**: Chart.js (auto-refreshing line graph)  
- **CI/CD**: GitHub Actions → Docker Hub or Render (optional)

---

## 🚀 Quick Start

### 1. Clone the project

```bash
git clone https://github.com/<your-username>/dockerized-metrics-dashboard.git
cd dockerized-metrics-dashboard
```

### 2. Create `.env` from example

```bash
cp backend/.env.example backend/.env
```

Edit values as needed.

### 3. Start the stack

```bash
docker compose up --build
```

---

## 🔍 Access

- **Frontend Dashboard** → http://localhost:8080/metrics.html  
- **API Endpoint** → http://localhost:3000/api/metrics  
- **Metrics Graph** updates every 5 seconds

---

## 📁 Project Structure

```
.
├── backend
│   ├── app.js              # Express API
│   ├── db/                 # PostgreSQL pool
│   ├── routes/             # API routes
│   ├── Dockerfile
│   └── .env.example
├── frontend
│   ├── metrics.html        # Chart.js dashboard
│   ├── script.js           # Chart rendering
│   ├── style.css
│   └── nginx.conf          # Proxy to backend
├── init.sql                # DB schema (metrics table)
├── docker-compose.yml
├── .dockerignore
└── README.md
```

---

## ⚙️ Environment Variables

`.env` for backend:

```env
DB_HOST=db
DB_PORT=5432
DB_USER=charles
DB_PASSWORD=strongpassword
DB_NAME=metricsdb
PORT=3000
```

---

## 🛠️ Planned Enhancements

- [ ] CI/CD pipeline via GitHub Actions  
- [ ] Auto-deploy to Docker Hub or Render  
- [ ] Export metrics (CSV/PDF)  
- [ ] Threshold alerts (CPU > 80%)  
- [ ] Slack / Mattermost integration  

---

## 👤 Author

**Temitayo Charles**  
DevOps & Infrastructure Engineer  
GitHub: [@temitayocharles](https://github.com/temitayocharles)

---

> Built for real-world observability. Simple. Powerful. Containerized.
