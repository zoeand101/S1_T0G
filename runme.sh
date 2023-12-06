#!/bin/bash

# Install PHP GD extension
sudo yum install php-gd -y

# Check if Composer is installed; if not, install it
if ! command -v composer &> /dev/null; then
    # Download and install Composer
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    php -r "if (hash_file('sha384', 'composer-setup.php') === 'e21205b207c3ff031906575712edab6f13eb0b361f2085f1f1237b7126d785e826a450292b6cfd1d64d92e6563bbde02') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); exit(1); } echo PHP_EOL;"
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer
    php -r "unlink('composer-setup.php');"
    sudo mv composer.phar /usr/local/bin/composer
    echo "Composer installed successfully."
else
    echo "Composer is already installed."
fi

# Full path to composer
COMPOSER_PATH=/usr/local/bin/composer

# Install required PHP packages using Composer
sudo $COMPOSER_PATH require kreait/firebase-php phpmailer/phpmailer endroid/qr-code bacon/bacon-qr-code

# Delete composer.json and composer.lock
if [ -f composer.json ]; then
    sudo rm composer.json
fi

if [ -f composer.lock ]; then
    sudo rm composer.lock
fi

# Inform the user about the successful installation
echo "Required PHP packages installed successfully."
