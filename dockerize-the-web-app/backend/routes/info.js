const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
  res.json({ status: 'ok', message: 'Info endpoint works' });
});

module.exports = router;

app.get('/api/info', (req, res) => {
  res.json({ status: 'Backend API is healthy', timestamp: new Date() });
});
