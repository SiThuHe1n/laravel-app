FROM ubuntu:latest

RUN apt update

RUN apt install php openssl php-bcmath php-curl php-json php-mbstring php-mysql php-tokenizer php-xml php-zip sqlite3 php-sqlite3 -y

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"

RUN php composer-setup.php

RUN mv composer.phar /usr/local/bin/composer

WORKDIR /my-app

COPY . .

RUN composer install

RUN cp .env.example .env

RUN php artisan key:generate

# Create SQLite database directory and file
RUN touch database/database.sqlite

# Set up database permissions (may need adjustment based on your environment)
RUN chmod 777 database/database.sqlite

# Run migrations and seeding
RUN php artisan migrate:fresh --seed

RUN chmod -R 777 ./storage

RUN php artisan storage:link

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]

EXPOSE 8000








