FROM ubuntu:latest

RUN apt update

RUN apt install php openssl nodejs npm php-bcmath php-curl php-json php-mbstring php-mysql php-tokenizer php-xml php-zip sqlite3 php-sqlite3 -y

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"

RUN php composer-setup.php

RUN mv composer.phar /usr/local/bin/composer

WORKDIR /my-app

COPY . .

RUN composer install

RUN chmod -R 777 ./storage

RUN php artisan storage:link

RUN npm i && npm run build

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]

EXPOSE 8000








