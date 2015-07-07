FROM ubuntu:latest
ADD modules /puppet/modules
ADD manifests /puppet/manifests
RUN apt-get -y update
RUN apt-get -y install puppet
RUN useradd --create-home --home-dir /home/vagrant --user-group vagrant
RUN echo vagrant:vagrant | chpasswd
RUN echo "vagrant ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN puppet apply /puppet/manifests/site.pp --modulepath /puppet/modules
