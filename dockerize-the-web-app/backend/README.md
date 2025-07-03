# Three-Tier Backend (Node.js + PostgreSQL)

## Features

- REST API with `/api/info`, `/api/metrics`, and full `/api/users` CRUD
- YAML and `.env` driven config
- Dockerized

## Usage

```bash
cp .env.example .env
docker build -t three-tier-backend .
docker run --env-file .env -p 3000:3000 three-tier-backend
