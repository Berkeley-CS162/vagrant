#!/bin/bash

set -e
set -x

test -f ~/.vagrant.d/boxes/ubuntu-VAGRANTSLASH-trusty64/14.04/virtualbox/box-disk1.vmdk
test -f ~/.vagrant.d/boxes/ubuntu-VAGRANTSLASH-trusty64/14.04/virtualbox/box.ovf

tar czvf spring2015.box -L manifests modules include box-disk1.vmdk box.ovf
