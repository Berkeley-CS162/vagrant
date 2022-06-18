#!/bin/bash

set -e
set -x

BASE_BOX_ROOT=~/.vagrant.d/boxes/ubuntu-VAGRANTSLASH-bionic64

if [[ ! -d $BASE_BOX_ROOT ]]; then
    echo "You need to do 'vagrant box add ubuntu/bionic64' first!" >&2
    exit 1
fi

BASE_BOX_VERSION=`ls -d1 $BASE_BOX_ROOT/[0-9]* | tail -1`

echo "Detected base box version $BASE_BOX_VERSION"

if [[ ! -f $BASE_BOX_VERSION/virtualbox/ubuntu-bionic-18.04-cloudimg.vmdk ]]; then
    echo "Could not find ubuntu-bionic-18.04-cloudimg.vmdk from base box"
    exit 1
fi

if grep "REPLACEME" Vagrantfile; then
    echo "Please replace the MAC address in dist/Vagrantfile with the actual image MAC" >&2
    exit 1
fi

if [[ ! -e box.ovf ]]; then
    ln -s $BASE_BOX_VERSION/virtualbox/box.ovf box.ovf
fi

if [[ ! -e ubuntu-bionic-18.04-cloudimg.vmdk ]]; then
    ln -s $BASE_BOX_VERSION/virtualbox/ubuntu-bionic-18.04-cloudimg.vmdk ubuntu-bionic-18.04-cloudimg.vmdk
fi

if [[ ! -e ubuntu-bionic-18.04-cloudimg-configdrive.vmdk ]]; then
    ln -s $BASE_BOX_VERSION/virtualbox/ubuntu-bionic-18.04-cloudimg-configdrive.vmdk ubuntu-bionic-18.04-cloudimg-configdrive.vmdk
fi

if [[ ! -e ubuntu-bionic-18.04-cloudimg.mf ]]; then
    ln -s $BASE_BOX_VERSION/virtualbox/ubuntu-bionic-18.04-cloudimg.mf ubuntu-bionic-18.04-cloudimg.mf
fi

tar czvf summer2022.box -h manifests modules include install_puppet.sh ubuntu-bionic-18.04-cloudimg.vmdk ubuntu-bionic-18.04-cloudimg-configdrive.vmdk box.ovf ubuntu-bionic-18.04-cloudimg.mf Vagrantfile
