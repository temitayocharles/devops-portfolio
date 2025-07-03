const os = require('os');
const db = require('./db');

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
