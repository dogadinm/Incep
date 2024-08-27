FROM debian:buster


RUN apt update -y && apt install php php-fpm php-mysql curl -y

COPY ./requirements/wordpress/conf/script.sh /
# COPY ./requirements/wordpress/conf/wp-config.php /


CMD [ "/script.sh" ]
