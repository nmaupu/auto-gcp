#!/usr/bin/env bash

set -e

# Dummy call to entrypoint to create /var/www/html wordpress content
/usr/local/bin/docker-entrypoint.sh apache2-dummy

# Creating a health page
touch /var/www/html/health

## Installing some plugins
# easy table
# nivo slider
# SEO SearchTerms Tagging 2
# Slick Social Share Buttons (deactivated)
date
sudo -u www-data -- wp --path=/var/www/html plugin install timthumb-vulnerability-scanner
sudo -u www-data -- wp --path=/var/www/html plugin install commentluv                     --activate
sudo -u www-data -- wp --path=/var/www/html plugin install contact-form-manager           --activate
sudo -u www-data -- wp --path=/var/www/html plugin install easy-columns                   --activate
sudo -u www-data -- wp --path=/var/www/html plugin install get-recent-comments            --activate
sudo -u www-data -- wp --path=/var/www/html plugin install google-analytics-for-wordpress --activate
sudo -u www-data -- wp --path=/var/www/html plugin install nextgen-gallery                --activate
sudo -u www-data -- wp --path=/var/www/html plugin install redirection                    --activate
sudo -u www-data -- wp --path=/var/www/html plugin install shareadraft                    --activate
sudo -u www-data -- wp --path=/var/www/html plugin install subscribe-to-comments-reloaded --activate
sudo -u www-data -- wp --path=/var/www/html plugin install subscribe2                     --activate
sudo -u www-data -- wp --path=/var/www/html plugin install upprev                         --activate
sudo -u www-data -- wp --path=/var/www/html plugin install w3-total-cache                 --activate
sudo -u www-data -- wp --path=/var/www/html plugin install wordpress-popular-posts        --activate
sudo -u www-data -- wp --path=/var/www/html plugin install wp-mail-smtp                   --activate
sudo -u www-data -- wp --path=/var/www/html plugin install wp-jquery-lightbox             --activate
sudo -u www-data -- wp --path=/var/www/html plugin install wp-recaptcha-integration       --activate
sudo -u www-data -- wp --path=/var/www/html plugin install wptouch                        --activate
sudo -u www-data -- wp --path=/var/www/html plugin install wordpress-seo                  --activate
sudo -u www-data -- wp --path=/var/www/html plugin install wp-stateless                   --activate

## Some configuration
# wp-stateless
# Env var has to be declared outside !
sudo -u www-data -- wp --path=/var/www/html option update sm_mode                 "${SM_MODE}"
sudo -u www-data -- wp --path=/var/www/html option update sm_service_account_name "${SM_SA_NAME}"
sudo -u www-data -- wp --path=/var/www/html option update sm_key_json             "${SM_KEY_JSON}"
sudo -u www-data -- wp --path=/var/www/html option update sm_bucket               "${SM_BUCKET}"
date

/usr/local/bin/docker-entrypoint.sh apache2-foreground
