#!/usr/bin/env bash
TEMP_DEB=$(mktemp)
wget -O $TEMP_DEB https://apt.puppet.com/puppet7-release-$(lsb_release -cs).deb
sudo dpkg -i $TEMP_DEB
rm $TEMP_DEB

apt update
# Ensures interaction is disabled
export DEBIAN_FRONTEND=noninteractive
apt -y install puppet-agent
