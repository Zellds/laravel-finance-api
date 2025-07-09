
# WIP
## Laravel Finance API

Este repositório ira conter uma API RESTful de controle financeiro pessoal, desenvolvida com **Laravel**. O objetivo é gerenciar **transações** de entrada e saída, organizar por categoria e permitir o acompanhamento de saldo total por usuário.

---

### Tecnologias Utilizadas
- PHP 8+
- Laravel 12^
- PostgreSQL
- Laravel Sanctum (autenticação via token)
- PHPUnit (testes automatizados)
- Docker

---

### Funcionalidades
- Cadastro e login de usuário
- CRUD de transações financeiras
  - tipo: entrada / saída
  - valor, descrição, data, categoria
- Consulta de saldo por usuário
- Filtragem de transações por data, tipo e categoria

---

### Instalação local (com Laravel Sail ou ambiente próprio)
```bash
# Clone o repositório
git clone https://github.com/Zellds/laravel-finance-api.git
cd laravel-finance-api

# Instale as dependências
composer install

# Copie o .env e configure
cp .env.example .env
php artisan key:generate

# Configure o banco no .env
DB_CONNECTION=pgsql
DB_HOST=127.0.0.1
DB_PORT=5432
DB_DATABASE=finance
DB_USERNAME=postgres
DB_PASSWORD=senha

# Rode as migrations
php artisan migrate

# Rode o servidor
php artisan serve
```

---

### Testes
```bash
php artisan test
```

> Os testes cobrem login, cadastro e operações com transações (criação, edição, listagem e exclusão).

---

### Endpoints
- `POST /api/register` - Cadastrar usuário
- `POST /api/login` - Login (retorna token)
- `GET /api/transactions` - Listar transações
- `POST /api/transactions` - Criar transação
- `GET /api/balance` - Obter saldo atual

> Todas as rotas são protegidas por token via Sanctum.

---

### Planejamento futuro (issues abertas)
- Integração com webhooks
- CI com GitHub Actions para testes e lint

---


### :man_technologist: Desenvolvido por Gabriel Medeiros
