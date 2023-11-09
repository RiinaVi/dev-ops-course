#!/bin/bash

#updates the database with information on any new packages or versions
apt-get -y update

#install nginx package
apt-get -y install nginx

#start nginx
service nginx start

#install postgresql
apt-get -y install postgresql
