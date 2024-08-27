#!/bin/bash



# create directory to use in nginx container later and also to setup the wordpress conf
mkdir /var/www/
mkdir /var/www/wordpress
cd /var/www/wordpress

rm -rf *

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 
chmod +x wp-cli.phar 
mv wp-cli.phar /usr/local/bin/wp
wp core download --allow-root


wp config create --dbhost=${WORDPRESS_DB_HOST} \
				--dbname=${WORDPRESS_DB_NAME} \
				--dbuser=${WORDPRESS_DB_USER} \
				--dbpass=${WORDPRESS_DB_PASSWORD} \
				--allow-root

wp core install --url=${WP_URL} \
				--title=${WP_TITLE} \
				--admin_user=${WP_ADMIN_USER} \
				--admin_password=${WP_ADMIN_PASSWORD} \
				--admin_email=${WP_ADMIN_MAIL} \
				--skip-email --allow-root




# wp user create $WP_USER $WP_USER_MAIL --role=author --user_pass=$WP_USER_PASSWORD --allow-root
# wp theme install astra --activate --allow-root
# wp plugin install redis-cache --activate --allow-root
# wp plugin update --all --allow-root


 
sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf

mkdir /run/php



# wp redis enable --allow-root

/usr/sbin/php-fpm7.3 -F