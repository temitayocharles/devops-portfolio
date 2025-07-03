#!/bin/bash

set -e
TARGET_DIR="/Users/charlie/Documents/PERSONAL/dockerize-the-web-app/frontend"
mkdir -p "$TARGET_DIR"

echo "🎨 Generating styled HTML frontend..."

# index.html (home)
cat > "$TARGET_DIR/index.html" <<'EOF'
<!DOCTYPE html>
<html>
<head>
  <title>Three-Tier App</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <div class="d-flex">
    <nav class="sidebar bg-dark text-white p-3">
      <h4>Three-Tier App</h4>
      <ul class="nav flex-column">
        <li><a href="index.html" class="nav-link">Home</a></li>
        <li><a href="metrics.html" class="nav-link">Metrics</a></li>
        <li><a href="status.html" class="nav-link">Status</a></li>
        <li><a href="team.html" class="nav-link">Team</a></li>
      </ul>
      <button id="darkToggle" class="btn btn-secondary mt-3">Toggle Dark Mode</button>
    </nav>
    <main class="p-4">
      <h1>Welcome to the Three-Tier App</h1>
      <p>This is your enterprise-grade frontend.</p>
    </main>
  </div>
  <script src="script.js"></script>
</body>
</html>
EOF

# metrics.html
cat > "$TARGET_DIR/metrics.html" <<'EOF'
<!DOCTYPE html>
<html>
<head>
  <title>Metrics | Three-Tier App</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <div class="d-flex">
    <nav class="sidebar bg-dark text-white p-3">
      <h4>Three-Tier App</h4>
      <ul class="nav flex-column">
        <li><a href="index.html" class="nav-link">Home</a></li>
        <li><a href="metrics.html" class="nav-link active">Metrics</a></li>
        <li><a href="status.html" class="nav-link">Status</a></li>
        <li><a href="team.html" class="nav-link">Team</a></li>
      </ul>
      <button id="darkToggle" class="btn btn-secondary mt-3">Toggle Dark Mode</button>
    </nav>
    <main class="p-4 w-100">
      <h2>Live Metrics</h2>
      <canvas id="metricsChart" width="400" height="150"></canvas>
    </main>
  </div>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <script src="script.js"></script>
</body>
</html>
EOF

# status.html
cat > "$TARGET_DIR/status.html" <<'EOF'
<!DOCTYPE html>
<html>
<head>
  <title>Status | Three-Tier App</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <div class="d-flex">
    <nav class="sidebar bg-dark text-white p-3">
      <h4>Three-Tier App</h4>
      <ul class="nav flex-column">
        <li><a href="index.html" class="nav-link">Home</a></li>
        <li><a href="metrics.html" class="nav-link">Metrics</a></li>
        <li><a href="status.html" class="nav-link active">Status</a></li>
        <li><a href="team.html" class="nav-link">Team</a></li>
      </ul>
      <button id="darkToggle" class="btn btn-secondary mt-3">Toggle Dark Mode</button>
    </nav>
    <main class="p-4 w-100">
      <h2>Status</h2>
      <p>App is running in production mode.</p>
    </main>
  </div>
  <script src="script.js"></script>
</body>
</html>
EOF

# team.html
cat > "$TARGET_DIR/team.html" <<'EOF'
<!DOCTYPE html>
<html>
<head>
  <title>Team | Three-Tier App</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <div class="d-flex">
    <nav class="sidebar bg-dark text-white p-3">
      <h4>Three-Tier App</h4>
      <ul class="nav flex-column">
        <li><a href="index.html" class="nav-link">Home</a></li>
        <li><a href="metrics.html" class="nav-link">Metrics</a></li>
        <li><a href="status.html" class="nav-link">Status</a></li>
        <li><a href="team.html" class="nav-link active">Team</a></li>
      </ul>
      <button id="darkToggle" class="btn btn-secondary mt-3">Toggle Dark Mode</button>
    </nav>
    <main class="p-4 w-100">
      <h2>Our Team</h2>
      <ul>
        <li><strong>s9charles</strong> – DevOps Engineer – +1 519 215 8388</li>
        <li><strong>Assisted by:</strong> s8ikoyi</li>
      </ul>
    </main>
  </div>
  <script src="script.js"></script>
</body>
</html>
EOF

# style.css
cat > "$TARGET_DIR/style.css" <<'EOF'
body.dark-mode {
  background-color: #121212;
  color: white;
}
.sidebar {
  width: 200px;
  min-height: 100vh;
}
.nav-link {
  color: white;
}
.nav-link:hover {
  color: #ccc;
}
EOF

# script.js
cat > "$TARGET_DIR/script.js" <<'EOF'
// Toggle dark mode
document.getElementById('darkToggle')?.addEventListener('click', () => {
  document.body.classList.toggle('dark-mode');
});

// Chart rendering
if (document.getElementById('metricsChart')) {
  fetch('/api/metrics') // or hardcoded for demo: http://localhost:3000/api/metrics
    .then(res => res.json())
    .then(data => {
      new Chart(document.getElementById('metricsChart'), {
        type: 'bar',
        data: {
          labels: ['CPU', 'RAM', 'Disk', 'Network'],
          datasets: [{
            label: 'Usage %',
            data: [data.cpu, data.ram, data.disk, data.network],
            backgroundColor: ['#007bff', '#dc3545', '#ffc107', '#28a745']
          }]
        },
        options: {
          responsive: true,
          scales: { y: { beginAtZero: true, max: 100 } }
        }
      });
    });
}
EOF

echo "✅ Frontend files created in $TARGET_DIR"
