#!/bin/bash

set -e
set -x

BASE_BOX_ROOT=~/.vagrant.d/boxes/ubuntu-VAGRANTSLASH-trusty64

if [[ ! -d $BASE_BOX_ROOT ]]; then
    echo "You need to do 'vagrant box add ubuntu/trusty64' first!" >&2
    exit 1
fi

BASE_BOX_VERSION=`ls -d1 $BASE_BOX_ROOT/[0-9]* | tail -1`

echo "Detected base box version $BASE_BOX_VERSION"

if [[ ! -f $BASE_BOX_VERSION/virtualbox/box-disk1.vmdk ]]; then
    echo "Could not find box-disk1.vmdk from base box"
    exit 1
fi

if grep "REPLACEME" Vagrantfile; then
    echo "Please replace the MAC address in dist/Vagrantfile with the actual image MAC" >&2
    exit 1
fi

if [[ ! -e box.ovf ]]; then
    ln -s $BASE_BOX_VERSION/virtualbox/box.ovf box.ovf
fi

if [[ ! -e box-disk1.vmdk ]]; then
    ln -s $BASE_BOX_VERSION/virtualbox/box-disk1.vmdk box-disk1.vmdk
fi

tar czvf spring2018.box -h manifests modules include box-disk1.vmdk box.ovf Vagrantfile
