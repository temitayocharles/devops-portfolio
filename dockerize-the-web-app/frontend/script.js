// Toggle dark mode
document.getElementById('darkToggle')?.addEventListener('click', () => {
  document.body.classList.toggle('dark-mode');
});

// Line Chart Configuration
const ctx = document.getElementById('metricsChart').getContext('2d');

const chart = new Chart(ctx, {
  type: 'line',
  data: {
    labels: [], // timestamps
    datasets: [
      {
        label: 'CPU (%)',
        data: [],
        borderColor: '#007bff',
        tension: 0.3
      },
      {
        label: 'RAM (%)',
        data: [],
        borderColor: '#dc3545',
        tension: 0.3
      },
      {
        label: 'Disk (%)',
        data: [],
        borderColor: '#ffc107',
        tension: 0.3
      },
      {
        label: 'Network (%)',
        data: [],
        borderColor: '#28a745',
        tension: 0.3
      }
    ]
  },
  options: {
    animation: {
      duration: 800,
      easing: 'easeInOutQuart'
    },
    responsive: true,
    scales: {
      y: {
        beginAtZero: true,
        max: 100
      }
    }
  }
});

async function fetchAndUpdate() {
  try {
    const res = await fetch('/api/metrics');

    const metrics = await res.json();

    const timestamp = new Date().toLocaleTimeString();

    if (chart.data.labels.length >= 10) {
      chart.data.labels.shift();
      chart.data.datasets.forEach(dataset => dataset.data.shift());
    }

    chart.data.labels.push(timestamp);
    chart.data.datasets[0].data.push(metrics.cpu);
    chart.data.datasets[1].data.push(metrics.ram);
    chart.data.datasets[2].data.push(metrics.disk);
    chart.data.datasets[3].data.push(metrics.network);

    chart.update();
  } catch (err) {
    console.error("Failed to fetch metrics:", err);
  }
}

setInterval(fetchAndUpdate, 5000);
fetchAndUpdate(); // initial load
