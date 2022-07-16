FROM ubuntu:18.04 as src

RUN useradd --create-home --home-dir /home/vagrant --user-group vagrant
RUN echo vagrant:vagrant | chpasswd
RUN echo "vagrant ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN apt -y update && apt -y install puppet

COPY modules /puppet/modules
COPY manifests /puppet/manifests

RUN puppet apply /puppet/manifests/site.pp --modulepath /puppet/modules

# No longer need our puppet files, save about 4.3M
RUN rm -rf /puppet
# No longer need puppet, save about 49.4 MB
RUN apt -y purge --auto-remove puppet
# In case for some reason we have orphans
RUN apt -y autoremove --purge
# No longer need puppet, samba, apt, etc., can savely save 3.6M
RUN rm -rf /var/cache
# No longer need apt, can savely save 40M
RUN rm -rf /var/lib/apt/lists/

# I am trusting that the following command depends on puppet;
# If running puppet will not change this, then this should happen well in advance of puppet apply, for build caching
RUN echo "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/vagrant/.bin:/home/vagrant/.cargo/bin:/home/vagrant/.fzf/bin" >> /etc/environment


FROM ubuntu:18.04

COPY --from=src . .

ENTRYPOINT ["bash", "-c"]
