Running the CS 162 Vagrant VM on Windows
========================================

There are some challenges to running Vagrant on Windows. This file is meant to provide assistance to Windows users.

### 1. Set up Cygwin

Cygwin provides a set of linux tools for Windows computers. You should install Cygwin and use the Cygwin terminal for SSH. Git Bash should also work for our purposes, but most GSIs with Windows support experience are more familiar with Cygwin.

1. Go to [the Cygwin website](http://cygwin.com/install.html) and download `setupx84_64.exe` (Cygwin for 64-bit versions of Windows).
1. Run the `setupx86_64.exe` file that you downloaded.
1. At the welcome screen, press "Next".
1. At "Choose A Download Source", you should select "Install from Internet" and press "Next".
1. At "Select Root Install Directory", you should leave the default value of "Root Directory" and install for "All Users". Press "Next".
1. At "Select Local Package Directory", you should leave the default value of "Local Package Directory" and press "Next".
1. At "Select Your Internet Connection", you should leave the default value of "Direct Connection" and press "Next".
1. (No action required.) Cygwin will now download a list of mirrors (e.g. servers that host available Cygwin software).
1. At "Choose A Download Site", select any one of the download sites, and press "Next".
1. (No action required.) Cygwin will now retrieve a list of available software from the mirror.
1. You should now be at a screen titled "Select Packages". I suggest you click the "View" button at the top right corner, so that the label says "Full" instead of "Category". Make sure "Cur" is selected for the package version channel (this is the default).
1. Search for EACH of the following packages, and click the "Skip" label to select them for installation. When you click the "Skip" label, it should turn into a version number like "2.1.4-1". Some of these may already be selected for installation, in which case it will have the version number already there instead of "Skip".
  1. bash: THE GNU Bourne Again SHell
  1. git: Distributed version control system
1. Click "Next" to review the packages to install.
1. At "Resolving Dependencies", make sure "Select required packages" is selected, and press "Next".
1. (No action required.) Cygwin will now install your packages.
1. At "Create Icons", I recommend you add both the Desktop and Start Menu icons, so Cygwin Terminal is easier to find. Press "Finish" to exit the installer.

### 2. Set up VirtualBox

VirtualBox is a Virtual Machine runtime. You can download VirtualBox for Windows on [the VirtualBox website](https://www.virtualbox.org/wiki/Downloads). Select the one labeled "Virtualbox platform packages - for Windows hosts". Then, run the downloaded file and complete the installation.

### 3. Set up Vagrant

Vagrant is a tool for provisioning development environments. You can download Vagrant for Windows on [the VagrantUp website](https://www.vagrantup.com/downloads.html).

At this point, you should **restart your computer**, for the greatest chance of success.

### 4. Set up the CS 162 VM

We will now use Cygwin Terminal to set up our virtual machine.

1. Open up the Cygwin Terminal.
1. Run `mkdir cs162-vm`
1. Run `cd cs162-vm`
1. Run `vagrant init cs162/<current-semester>`
1. Run `vagrant up`. This step may take a while, and requires a fast internet connection.
1. Run `vagrant ssh`. You should now be in an SSH session connected to the virtual machine. You can type `logout` to log out.

### 5. Closing notes

You need to run all vagrant commands from the `cs162-vm` directory you created earlier. Do NOT delete that directory, or vagrant will not know how to manage the VM you created.

You can run `vagrant halt` to stop the virtual machine. If this command does not work, make sure you are running it from your host machine, not inside SSH. To start the virtual machine the next time, you only need to run `vagrant up` and `vagrant ssh`. All of the other steps (installing Cygwin and running vagrant init) do not need to be repeated.
