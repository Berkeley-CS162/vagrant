#!/usr/bin/env bash
apt update
# Ensures interaction is disabled
export DEBIAN_FRONTEND=noninteractive
apt -y install puppet
