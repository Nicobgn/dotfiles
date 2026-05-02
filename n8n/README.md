# n8n + PostgreSQL con Podman (Setup local)

## 🧱 Requisitos

- Podman instalado
- Conexión a internet para bajar imágenes

---

## 📦 1. Crear volúmenes

```bash
podman volume create n8n_data
podman volume create n8n_postgres_data
```

---

## 🌐 2. Crear red

```bash
podman network create n8n-network
```

---

## 🐘 3. Levantar PostgreSQL

```bash
podman run -d \
  --name n8n-postgres \
  --network n8n-network \
  -e POSTGRES_USER=n8n \
  -e POSTGRES_PASSWORD=n8npass \
  -e POSTGRES_DB=n8n \
  -v n8n_postgres_data:/var/lib/postgresql/data \
  docker.io/library/postgres:15
```

---

## 🚀 4. Levantar n8n

```bash
podman run -d \
  --name n8n \
  --network n8n-network \
  -p 5678:5678 \
  -e DB_TYPE=postgresdb \
  -e DB_POSTGRESDB_HOST=n8n-postgres \
  -e DB_POSTGRESDB_PORT=5432 \
  -e DB_POSTGRESDB_DATABASE=n8n \
  -e DB_POSTGRESDB_USER=n8n \
  -e DB_POSTGRESDB_PASSWORD=n8npass \
  -e N8N_BASIC_AUTH_ACTIVE=true \
  -e N8N_BASIC_AUTH_USER=admin \
  -e N8N_BASIC_AUTH_PASSWORD=admin123 \
  -v n8n_data:/home/node/.n8n \
  docker.io/n8nio/n8n
```

---

## 🌍 5. Acceso

Abrir en navegador:

http://localhost:5678

Usuario: `admin`
Password: `admin123`

---

## 🔍 6. Ver logs

```bash
podman logs -f n8n
```

---

## ⛔ 7. Detener servicios

```bash
podman stop n8n
podman stop n8n-postgres
```

---

## 🔄 8. Reiniciar servicios

```bash
podman start n8n-postgres
podman start n8n
```

---

## ⚠️ Notas

- Siempre iniciar primero PostgreSQL
- Los datos quedan persistidos en volúmenes
- Cambiar credenciales en producción

---
