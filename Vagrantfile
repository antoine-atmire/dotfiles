VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "debian/jessie64"
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
  config.vm.provision :shell, :path => File.join(File.dirname(__FILE__), "setup")
  config.vm.network :forwarded_port, guest:3000, host:3000
end
