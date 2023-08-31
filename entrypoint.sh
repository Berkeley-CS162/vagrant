#!/bin/bash

home=/home/vagrant
src=/vagrant

if [ -z "$(ls -A $home)" ]; then
	sudo cp -R $src/. $home
	sudo chown -R vagrant $home
 	sudo chmod -R 0700 ~/
fi

sudo service ssh start

echo "Docker workspace is ready!"

/bin/bash
