# DEPRECATED. 
**PLEASE SEE THE NEW [WORKSPACE](https://github.com/Berkeley-CS162/cs162-workspace) INSTEAD**

Vagrant VM for CS162
====================

### Running on Vagrant

1. Download the source code (don't forget `--recursive` if you're using
   `git clone`) and run `vagrant up` inside the root of the project directory.
1. The Vagrantfile specifies `ubuntu/bionic64` as the base box for this VM, so
   Vagrant will download that box from the Internet, which may take some time.
1. Once the download is complete, Vagrant will import the VM appliance and run
   our Puppet provisioner.

This provisioner is the only modification we've made to the base box, which
means that you **should** be able to run it on any x86 Ubuntu 18.04 machine.

### Running on your own infrastructure

Vagrant+Virtualbox is the recommended way to run the VM. If you don't have VT-x,
or you would prefer to use your own infrastructure, you can run the provisioner
manually.

#### 1. Set up a Ubuntu 18.04 VM

You can set this up on AWS, DigitalOcean, your home server, etc. Anything that
runs this operating system is okay. Both 64-bit and 32-bit versions are okay,
but the underlying system must be x86, not ARM.

#### 2. Log in to your VM as root, and download the source code for this project.

If you can't log in as root, just type `sudo su` when you log in, and you will
become root (assuming you have sudo permissions).

The easiest way to download the source code is through a git clone. You may need
to install git first, so:

```shell
$ apt-get install git
$ git clone --recursive https://github.com/Berkeley-CS162/vagrant.git
```

#### 3. Add the vagrant user (even if you aren't using vagrant)

There will be some things that are installed for the vagrant user and some
things that are placed in the vagrant user's home directory, so regardless of
whether you are using vagrant, you will need a user named `vagrant` with a home
directory at `/home/vagrant` for this to work.

You should use the `adduser` utility script to do this, NOT `useradd` (unless
you are already familiar with the command-line switches of useradd).

```shell
$ adduser vagrant
```

Make sure your password isn't easily guessable! The personal information section
doesn't matter.

#### 4. Give password-less sudo access to the vagrant user (not optional)

You will need to edit `/etc/sudoers` to give `vagrant` password-less sudo
access. This just means you need to add one line to the end of `/etc/sudoers`.
Open up `/etc/sudoers` with your favorite command-line text editor and add this
line:

```
vagrant ALL=(ALL) NOPASSWD: ALL
```

#### 5. Install puppet using the package manager

You will need to install Puppet. This is as easy as:

```shell
apt-get install puppet
```

#### 6. Run the provisioner

Make sure you are in the project root, and then just run the provisioner.

```shell
$ cd path/to/project/vagrant/
$ sudo puppet apply manifests/site.pp --modulepath modules/
```

#### 7. Log in as the vagrant user (not optional)

You need to actually log in as the `vagrant` user now, since the .bashrc has
`~/.bin` in the PATH for the vagrant user, which has some nifty utilities. You
can do this by logging in with ssh, or if you are already logged in with root,
just run:

```
$ su vagrant
```

You're done! You can use this box just the same as you would a vagrant box. Just
remember to log in with the vagrant user when you're developing code.

### SMB Server

There is a Samba server that you can connect to with any SMB client. You can
log in with `vagrant` as both the username and the password. You can also use
the vboxsf mount on `/vagrant` that is connected to the host's home folder. Or,
you can set up rsync or sshfs. You can either add your own SSH key to the
vagrant user's authorized keys (don't replace the entire file, because Vagrant
needs to be able to log in as well to manage the VM), or you can use SSH's
IdentityFile option to use the same private key that Vagrant does. The IP
address of the VM should be `192.168.162.162` always, unless another interface
on the host is using that subnet.

### Building the distributable box

~~The `dist/` directory has components to build the final box file. I'm trying a
thing where the box image and components are all from the ubuntu/bionic64 box,
and we just put a puppet provisioner on top of it. To build~~

    vagrant box add ubuntu/bionic64
    cd dist/
    (Replace the MAC address in Vagrantfile with real MAC address)
    ./make.sh

~~You can find the real MAC address to use in the Vagrantfile in the
`~/.vagrant.d/boxes/ubuntu-..../` directory.~~

**Update Fall 2019:** This semester we upgraded the VM to Ubuntu 18.04. I couldn't find a way to make the scripts in `dist` work with this version of Ubuntu. Ubuntu starts to boot but then hangs at some point in the boot procedure. I've left my attempt at porting this to Ubuntu 18.04 in the `dist` directory, so the code there DOES NOT WORK. I didn't spend too much time on it, so it's possible the fix is trivial---maybe a future TA will find out where I went wrong and revive this.

Until then, just build the vagrant box for distribution like normal. Run `vagrant up` to provision the VM locally, `vagrant halt` to stop the VM, and then `vagrant package --vagrantfile Vagrantfile --output fall2019.box` (choose the correct semester name). After the provisioning the VM (in between `vagrant up` and `vagrant halt`) you may choose to SSH in the VM, clear the apt cache, and zero out the disk so that the packaged `.box` file is smaller after compression. That can be done by running `sudo apt clean`, `sudo dd if=/dev/zero of=/EMPTY bs=1M`, and `sudo rm -f /EMPTY` inside the VM. You may also choose to clear the history with `history -c` (and clear the `.bash_history` if it is present). Here's a pretty good tutorial: https://scotch.io/tutorials/how-to-create-a-vagrant-base-box-from-an-existing-one.
