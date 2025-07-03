const express = require('express');
const os = require('os');
const db = require('./db');

const app = express();
const port = process.env.PORT || 3000;

app.use(express.json());

app.get('/api/metrics', async (req, res) => {
  const totalMem = os.totalmem();
  const freeMem = os.freemem();
  const usedMemPercent = Math.round(((totalMem - freeMem) / totalMem) * 100);

  const cpu = Math.floor(Math.random() * 100);
  const ram = usedMemPercent;
  const disk = Math.floor(Math.random() * 100);
  const network = Math.floor(Math.random() * 100);

  try {
    await db.query(
      `INSERT INTO metrics (cpu, ram, disk, network) VALUES ($1, $2, $3, $4)`,
      [cpu, ram, disk, network]
    );

    res.json({ cpu, ram, disk, network });
  } catch (err) {
    console.error("Failed to write metrics to DB:", err);
    res.status(500).json({ error: "Failed to store metrics" });
  }
});

app.listen(port, '0.0.0.0', () => {
  console.log(`🚀 API listening at http://localhost:${port}`);
});

app.get('/api/metrics/latest', async (req, res) => {
  try {
    const result = await db.query(`
      SELECT cpu, ram, disk, network, timestamp
      FROM metrics
      ORDER BY timestamp DESC
      LIMIT 1
    `);
    res.json(result.rows[0]);
  } catch (err) {
    console.error("Failed to fetch latest metric:", err);
    res.status(500).json({ error: "DB query failed" });
  }
});

app.get('/api/metrics/stats', async (req, res) => {
  try {
    const result = await db.query(`
      SELECT
        ROUND(AVG(cpu)) AS avg_cpu,
        ROUND(AVG(ram)) AS avg_ram,
        ROUND(AVG(disk)) AS avg_disk,
        ROUND(AVG(network)) AS avg_network
      FROM metrics
    `);
    res.json(result.rows[0]);
  } catch (err) {
    console.error("Failed to calculate averages:", err);
    res.status(500).json({ error: "DB query failed" });
  }
});
