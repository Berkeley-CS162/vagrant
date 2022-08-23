#!/usr/bin/env bash
# Override default cmake with latest
apt update
wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | sudo tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null
apt-add-repository "deb https://apt.kitware.com/ubuntu/ $(lsb_release -cs) main"

apt update
# Ensures interaction is disabled
export DEBIAN_FRONTEND=noninteractive
apt -y install puppet
