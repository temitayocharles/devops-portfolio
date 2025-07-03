const { Pool } = require('pg');

const pool = new Pool({
  host: process.env.DB_HOST || 'db',
  port: process.env.DB_PORT || 5432,
  user: process.env.DB_USER || 'charles',
  password: process.env.DB_PASSWORD || 'strongpassword',
  database: process.env.DB_NAME || 'metricsdb',
});

module.exports = pool;
