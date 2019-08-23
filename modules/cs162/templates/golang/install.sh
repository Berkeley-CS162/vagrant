#!/usr/bin/env bash

set -e
set -x

VERSION=1.12.9

TARFILE=go${VERSION}.linux-amd64.tar.gz

wget -O $TARFILE https://dl.google.com/go/$TARFILE
sudo tar -C /usr/local -xzf $TARFILE

# Add Go to path if not already present
which go || (echo "export PATH=\$PATH:/usr/local/go/bin" | sudo tee -a /etc/profile)

# Clean up
rm $TARFILE
