#!/bin/bash

# ─── VARIÁVEIS DE ESTILO ─────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # Sem cor

# ─── FUNÇÕES AUXILIARES ──────────────────────────────────────────────

info()    { echo -e "${BLUE}👉 $1${NC}"; }
success() { echo -e "${GREEN}✅ $1${NC}"; }
warn()    { echo -e "${YELLOW}⚠️  $1${NC}"; }
error()   { echo -e "${RED}❌ $1${NC}"; exit 1; }

# ─── INÍCIO ───────────────────────────────────────────────────────────

info "Carregando variáveis de ambiente..."
if [ -f docker/.env.docker ]; then
  source docker/.env.docker
else
  error "Arquivo docker/.env.docker não encontrado!"
fi

# ─── COPIAR .env ─────────────────────────────────────────────────────

if [ ! -f .env ]; then
  info "Copiando .env.example para .env..."
  cp .env.example .env || error "Falha ao copiar .env"
else
  warn ".env já existe, mantendo arquivo atual."
fi

# ─── BUILD E UP ───────────────────────────────────────────────────────

info "Construindo os containers..."
docker compose build || error "Falha ao buildar os containers."

info "Subindo os containers em segundo plano..."
docker compose up -d || error "Erro ao subir os containers."

# ─── ESPERAR O DB FICAR PRONTO ────────────────────────────────────────

info "Aguardando PostgreSQL estar pronto..."
until docker exec postgres pg_isready -U laravel > /dev/null 2>&1; do
  printf "."
  sleep 1
done
echo ""
success "Banco de dados disponível."

# ─── COMANDOS LARAVEL ─────────────────────────────────────────────────

info "Instalando dependências com Composer..."
docker exec -it laravel-app composer install || error "Erro ao instalar dependências."

info "Gerando chave da aplicação..."
docker exec -it laravel-app php artisan key:generate || error "Erro ao gerar chave."

info "Criando link do storage..."
docker exec -it laravel-app php artisan storage:link || warn "Storage já linkado?"

info "Resetando banco com migrate:fresh + seed..."
docker exec -it laravel-app php artisan migrate:fresh --seed --force || error "Erro ao resetar banco."

success "Ambiente Laravel está pronto para desenvolvimento!"
echo -e "${YELLOW}🌐 Acesse em: http://localhost:8080${NC}"
