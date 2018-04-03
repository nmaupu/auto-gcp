FROM wordpress:4.9.4-apache

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y less sudo && \
    echo "#!/usr/bin/env bash" > /usr/local/bin/apache2-dummy && \
    echo "exit 0"              >> /usr/local/bin/apache2-dummy && \
    chmod +x /usr/local/bin/apache2-dummy

# Installing wp-cli command line tool
RUN curl -fsSL -o /tmp/wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    mv /tmp/wp-cli.phar /usr/local/bin/wp && \
    chmod +x /usr/local/bin/wp

COPY run.sh /run.sh
RUN  chmod +x /run.sh

ENTRYPOINT ["/run.sh"]
