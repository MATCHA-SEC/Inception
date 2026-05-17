FROM debian:bullseye

WORKDIR /var/www/html

RUN rm -rf * \
    && apt update -y \
    && apt upgrade -y \
    && apt install php php-fpm php-mysql curl -y \
    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp \
    && mkdir -p /run/php

RUN sed -i "s|listen = /run/php/php7.4-fpm.sock|listen = 9000|" /etc/php/7.4/fpm/pool.d/www.conf

COPY ./tools/wpscript.sh .

RUN chmod +x ./wpscript.sh

CMD [ "./wpscript.sh" ]