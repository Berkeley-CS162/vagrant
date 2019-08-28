Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/bionic64"

  config.vm.network "private_network", ip: "192.168.162.162"
  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true
  config.vm.hostname = "development.cs162.eecs.berkeley.edu"

  config.vm.synced_folder "~/", "/vagrant"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.customize ["modifyvm", :id, "--memory", "1024"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]

    # This line is needed because the ubuntu/bionic64 Vagrantfile sets the
    # file to one hardcoded based on the directory where "vagrant up" is
    # originally run, preventing distribution. Simply using "--uartmode1
    # disconnected" causes the VM to boot 100x to 1000x more slowly on some
    # versions of VirtualBox (e.g., 6.0.2), causing vagrant to time out. See
    # https://github.com/hashicorp/vagrant/issues/10578.
    # The fix for now is to require students to use a version of VirtualBox
    # without this problem. Version 6.0.10, the latest verion of VirtualBox at
    # the time of writing, appears not to have such problems.
    vb.customize ["modifyvm", :id, "--uartmode1", "disconnected"]
  end

  if File.exist?(File.expand_path("../modules", __FILE__))
    puppet_root = File.expand_path("../", __FILE__)
  elsif File.exist?(File.expand_path("../../modules", __FILE__))
    puppet_root = File.expand_path("../../", __FILE__)
  elsif File.exist?(File.expand_path("../../../modules", __FILE__))
    puppet_root = File.expand_path("../../../", __FILE__)
  else
    puppet_root = nil
  end

  unless puppet_root.nil?
    # Install Puppet in the VM
    config.vm.provision "shell", path: "#{puppet_root}/install_puppet.sh"

    # Provision with Puppet
    config.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "#{puppet_root}/manifests"
      puppet.module_path    = "#{puppet_root}/modules"
      puppet.manifest_file  = "site.pp"
    end
  end

end
