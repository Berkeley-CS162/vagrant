FROM ubuntu:latest
ADD modules /puppet/modules
ADD manifests /puppet/manifests
RUN apt -y update
RUN apt -y install puppet
RUN useradd --create-home --home-dir /home/vagrant --user-group vagrant
RUN echo vagrant:vagrant | chpasswd
RUN echo "vagrant ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN puppet apply /puppet/manifests/site.pp --modulepath /puppet/modules
RUN echo "[net]\ngit-fetch-with-cli = true" >> /home/vagrant/.cargo/config.toml
RUN echo "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/vagrant/.bin:/home/vagrant/.cargo/bin:/home/vagrant/.fzf/bin" >> /etc/environment
