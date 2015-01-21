Vagrant VM for CS162
====================

### Building the distributable box

The `dist/` directory has components to build the final box file. I'm trying a
thing where the box image and components are all from the ubuntu/trusty64 box,
and we just put a puppet provisioner on top of it. To build:

    vagrant box add ubuntu/trusty64
    cd dist/
    ./make.sh

