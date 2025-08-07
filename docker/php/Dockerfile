FROM php:8.4-fpm

# ARGs para UID e GID do host
ARG UID
ARG GID

# Instalar dependências e extensões necessárias
RUN apt-get update && apt-get install -y \
    libpq-dev libzip-dev zip unzip git curl \
    && docker-php-ext-install pdo pdo_pgsql bcmath pcntl zip

# Criar usuário com mesmo UID e GID do host
RUN groupadd -g $GID laravel && useradd -u $UID -g laravel -m laravel

# Configuração de timezone
RUN echo "date.timezone=America/Sao_Paulo" > /usr/local/etc/php/conf.d/timezone.ini

# Usar o usuário não-root
USER laravel