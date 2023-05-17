#!/bin/bash

home=/home/vagrant
src=/vagrant

if [ -z "$(ls -A $home)" ]; then
	sudo cp -R $src/. $home
	sudo chown -R vagrant $home
fi

/bin/bash
