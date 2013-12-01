#!/bin/bash

# update packages
apt-get update

# install tree, curl & php5
apt-get install -y tree curl php5 php5-cli php5-xdebug

# configure php5
echo "date.timezone = UTC" > /etc/php5/conf.d/00-date.timezone.ini
echo "short_open_tag = Off" > /etc/php5/conf.d/00-short_open_tag.ini
ln -s /etc/php5/conf.d/00-date.timezone.ini /etc/php5/cli/conf.d
ln -s /etc/php5/conf.d/00-short_open_tag.ini /etc/php5/cli/conf.d

# install composer
apt-get install -y curl
curl -sS https://getcomposer.org/installer | php && mv composer.phar /bin/composer

# clean apt-get
apt-get autoremove

# install symfony bundles
cd /vagrant && composer install --dev

# add useful aliases in vagrant user's .bashrc
echo "cd /vagrant" >> /home/vagrant/.bashrc
echo "alias phpunit='/vagrant/bin/phpunit'" >> /home/vagrant/.bashrc
echo "alias phpunitcov='phpunit --coverage-html coverage'" >> /home/vagrant/.bashrc

# restore .bashrc ownership to vagrant user
chown vagrant:vagrant /home/vagrant/.bashrc

# create project structure
mkdir /vagrant/katas
mkdir /vagrant/katas/src
mkdir /vagrant/katas/test

# restore project ownership to vagrant user
chown -R vagrant:vagrant /vagrant/
