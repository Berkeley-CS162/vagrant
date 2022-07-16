FROM ubuntu:18.04 as src

RUN useradd --create-home --home-dir /home/vagrant --user-group vagrant
RUN echo vagrant:vagrant | chpasswd
RUN echo "vagrant ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN apt -y update && apt -y install puppet

COPY modules /puppet/modules
COPY manifests /puppet/manifests


FROM ubuntu:18.04 as puppet

COPY --from=src . .

RUN puppet apply /puppet/manifests/site.pp --modulepath /puppet/modules
# I am trusting that the following command depends on puppet;
# If running puppet will not change this, then this should happen well in advance of puppet apply, for build caching
RUN echo "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/vagrant/.bin:/home/vagrant/.cargo/bin:/home/vagrant/.fzf/bin" >> /etc/environment


FROM ubuntu:18.04

COPY --from=puppet . .
