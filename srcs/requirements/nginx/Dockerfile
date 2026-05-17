FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y && apt-get install nginx -y && apt-get install openssl -y

COPY ./conf/nginx.conf /etc/nginx/conf.d

COPY ./tools/setup.sh /tmp

RUN chmod +x /tmp/setup.sh

CMD ["./tmp/setup.sh"]

