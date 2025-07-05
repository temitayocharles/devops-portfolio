-- Ensure the database exists (runs only once on container start)
DO
$$
BEGIN
   IF NOT EXISTS (SELECT FROM pg_database WHERE datname = 'metricsdb') THEN
      CREATE DATABASE metricsdb;
   END IF;
END
$$;

-- Connect to metricsdb before creating table
\connect metricsdb;

CREATE TABLE IF NOT EXISTS metrics (
  id SERIAL PRIMARY KEY,
  cpu INT NOT NULL,
  ram INT NOT NULL,
  disk INT NOT NULL,
  network INT NOT NULL,
  timestamp TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);
