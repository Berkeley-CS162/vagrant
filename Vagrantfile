Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/trusty64"

  config.vm.network "private_network", ip: "192.168.162.162"
  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true
  config.vm.hostname = "development.cs162.eecs.berkeley.edu"

  config.vm.synced_folder "~/", "/vagrant"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.customize ["modifyvm", :id, "--memory", "1024"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
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
    config.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "#{puppet_root}/manifests"
      puppet.module_path    = "#{puppet_root}/modules"
      puppet.manifest_file  = "site.pp"
    end
  end

end
