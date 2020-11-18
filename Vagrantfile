Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/bionic64"

  config.vm.network "private_network", ip: "192.168.162.162"
  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true
  config.vm.hostname = "development.cs162.eecs.berkeley.edu"

  config.vm.synced_folder "~/", "/vagrant"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    # Workaround to get the grpcio package installed!
    # Set it back to 1024 MB in Virtualbox before packaging
  
    vb.customize ["modifyvm", :id, "--memory", "2560"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]

    # Instead of running disconnected, noticed that setting the file to NULL
    # avoids performance issues.
    vb.customize ["modifyvm", :id, "--uartmode1", "file", File::NULL]
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
