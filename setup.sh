#!/bin/bash

export IWP_VERSION=2.14.7

# Downlaod file from Infinite WP
echo Downloading infiniteWP
wget -O IWPAdminPanel_v${IWP_VERSION}.zip  https://infinitewp.com/iwp-admin-panel-download.php?installedEmail=

# The build arg leaves the install folder inplace to allow 
#   first run wizard to create the config.php file.
docker-compose build --build-arg INSTALL=true --build-arg IWP_VERSION=${IWP_VERSION}

# Config.php ######
echo Setting up config.

# Create an empty config.php file
touch config.php

# set permissions
chmod 666 config.php

# start it up in interactive mode
echo 
echo Now start the docker file with 
echo 
echo      docker-compose up
echo 
echo Docker will bring up the instance, you have to wait
echo till it starts, and then shows in the log
echo   "MySQL init process done. Ready for start up"
echo 
echo Then you can browse to http://localhost:3000 and 
echo finish the installation



