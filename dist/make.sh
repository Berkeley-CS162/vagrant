#!/bin/bash

set -e
set -x

if [[ ! -f ~/.vagrant.d/boxes/ubuntu-VAGRANTSLASH-trusty64/14.04/virtualbox/box-disk1.vmdk ]]; then
    echo "You need to do 'vagrant box add ubuntu/trusty64' first!" >&2
    exit 1
fi

if grep "REPLACEME" Vagrantfile; then
    echo "Please replace the MAC address in dist/Vagrantfile with the actual image MAC" >&2
    exit 1
fi

if [[ ! -e box.ovf ]]; then
    ln -s ~/.vagrant.d/boxes/ubuntu-VAGRANTSLASH-trusty64/14.04/virtualbox/box.ovf box.ovf
fi

if [[ ! -e box-disk1.vmdk ]]; then
    ln -s ~/.vagrant.d/boxes/ubuntu-VAGRANTSLASH-trusty64/14.04/virtualbox/box-disk1.vmdk box-disk1.vmdk
fi

tar czvf spring2015.box -h manifests modules include box-disk1.vmdk box.ovf Vagrantfile
