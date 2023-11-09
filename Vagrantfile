
Vagrant.configure("2") do |config|
	config.vm.define "WebServer" do |vm1|
		vm1.vm.box = "generic/ubuntu2204"
		vm1.vm.provision "shell", path: "provision-nginx.sh"
		vm1.vm.network "private_network", ip: "172.30.1.5"
		vm1.vm.synced_folder "static-files", "/home/vagrant/static-files-vagrant"
		vm1.vm.provider "virtualbox" do |vb|
			vb.memory = "1024"
			vb.cpus = 1
		end
	end
	config.vm.define "Database" do |vm2|
		vm2.vm.box = "generic/centos7"
		vm2.vm.provision "shell", path: "provision-postgresql.sh"
		vm2.vm.network "private_network", ip: "172.30.1.6"
		vm2.vm.synced_folder "static-files", "/home/vagrant/static-files-vagrant"
		vm2.vm.provider "virtualbox" do |vb|
			vb.memory = "1024"
			vb.cpus = 1
		end
	end
end
