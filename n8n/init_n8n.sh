#!/bin/bash

set -e

COMPOSE_FILE="podman-compose.yml"
ENV_FILE=".env"

echo "🚀 Levantando n8n + PostgreSQL + Adminer..."

# Verificar que existen los archivos necesarios
if [ ! -f "$COMPOSE_FILE" ]; then
  echo "❌ No se encontró $COMPOSE_FILE en el directorio actual."
  exit 1
fi

if [ ! -f "$ENV_FILE" ]; then
  echo "❌ No se encontró $ENV_FILE en el directorio actual."
  exit 1
fi

# Verificar que podman-compose está instalado
if ! command -v podman-compose &> /dev/null; then
  echo "❌ podman-compose no está instalado o no está en el PATH."
  exit 1
fi

podman-compose -f "$COMPOSE_FILE" up -d

echo ""
echo "✅ Servicios levantados:"
echo "   → n8n:     http://localhost:5678"
echo "   → Adminer: http://localhost:8080"