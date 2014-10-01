FROM debian:7.6
MAINTAINER maintain@geneegroup.com

ENV DEBIAN_FRONTEND noninteractive

# Install cURL
RUN apt-get update && apt-get install -y curl apt-utils

# Install PHP 5.5
RUN echo "deb http://packages.dotdeb.org wheezy-php55 all" > /etc/apt/sources.list.d/dotdeb-php5.list && \
    (curl -sL http://www.dotdeb.org/dotdeb.gpg | apt-key add -) && \
    apt-get update && apt-get install -y locales gettext php5-fpm php5-cli php5-intl php5-gd php5-mcrypt php5-mysqlnd php5-redis php5-sqlite php5-curl libyaml-0-2 && \
    sed -i 's/^listen\s*=.*$/listen = 0.0.0.0:9000/' /etc/php5/fpm/pool.d/www.conf && \
    sed -i 's/^error_log\s*=.*$/error_log = syslog/' /etc/php5/fpm/php-fpm.conf && \
    sed -i 's/^\;error_log\s*=\s*syslog\s*$/error_log = syslog/' /etc/php5/fpm/php.ini && \
    sed -i 's/^\;error_log\s*=\s*syslog\s*$/error_log = syslog/' /etc/php5/cli/php.ini

ADD yaml.so /usr/lib/php5/20121212/yaml.so
RUN echo "extension=yaml.so" > /etc/php5/mods-available/yaml.ini && \
    php5enmod yaml
	
# Install Friso && Robbe
ADD libfriso.so /usr/lib/libfriso.so
ADD robbe.so /usr/lib/php5/20121212/robbe.so
RUN echo "extension=robbe.so" > /etc/php5/mods-available/robbe.ini && \
    echo "[robbe]" >> /etc/php5/mods-available/robbe.ini && \
    echo "robbe.ini_file=/etc/friso/friso.ini" >> /etc/php5/mods-available/robbe.ini && \
    php5enmod robbe
ADD friso /etc/friso

# Install Development Tools
RUN apt-get install -y git

# Setup Locale
RUN \
    sed -i 's/# en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen && \
    sed -i 's/# zh_CN.UTF-8/zh_CN.UTF-8/' /etc/locale.gen && \
    locale-gen && \
    /usr/sbin/update-locale LANG="en_US.UTF-8" LANGUAGE="en_US:en"

EXPOSE 9000

ADD start /start
CMD ["/start"]