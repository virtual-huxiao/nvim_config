#!/bin/sh

sudo sed -i '/github/d' /etc/hosts
sudo bash -c "curl https://gitlab.com/ineo6/hosts/-/raw/master/next-hosts | grep github >> /etc/hosts"
