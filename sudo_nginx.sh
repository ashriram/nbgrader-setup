#!bin/bash

cp nginx/nginx.conf /etc/nginx/nginx.conf
mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak
cp nginx/default   /etc/nginx/sites-available
cd /etc/nginx/sites-enabled
rm -rf default
ln -s /etc/nginx/sites-available/default
