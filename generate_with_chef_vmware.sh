rm Vagrantfile
cat <<EOF > Vagrantfile

ENV['VAGRANT_DEFAULT_PROVIDER'] = 'vmware_fusion'

Vagrant.configure("2") do |config|
  config.vm.box = "tnarik/solaris10-u8-minimal"
  config.ssh.insert_key = false
  config.vm.provider "vmware_fusion" do |vm|
    vm.vmx["ethernet0.pcislotnumber"] = "33"
  end
  config.vm.provision :shell,
    :inline => "wget -O - https://www.getchef.com/chef/install.sh | sudo bash"
end
EOF

vagrant up
vagrant halt
MACHINE_FOLDER=$(cat ".vagrant/machines/default/vmware_fusion/id" | sed -e 's/\/[^\/]*$//g')
rm -rf package
mkdir -p package
cp ${MACHINE_FOLDER}/*.vmdk ${MACHINE_FOLDER}/*.nvram ${MACHINE_FOLDER}/*.vmsd ${MACHINE_FOLDER}/*.vmx ${MACHINE_FOLDER}/*.vmxf ${MACHINE_FOLDER}/metadata.json package/.
cd package
/Applications/VMware\ Fusion.app/Contents/Library/vmware-vdiskmanager -d disk.vmdk
/Applications/VMware\ Fusion.app/Contents/Library/vmware-vdiskmanager -k disk.vmdk
tar cvzf package.box ./*
vagrant destroy -f
vagrant box add --name tnarik/solaris10-minimal-with-chef package.box

rm Vagrantfile
cat <<EOF > Vagrantfile

ENV['VAGRANT_DEFAULT_PROVIDER'] = 'vmware_fusion'

Vagrant.configure("2") do |config|
  config.vm.box = "tnarik/solaris10-u8-full"
  config.ssh.insert_key = false
  config.vm.provider "vmware_fusion" do |vm|
    vm.vmx["ethernet0.pcislotnumber"] = "33"
  end
  config.vm.provision :shell,
    :inline => "wget -O - https://www.getchef.com/chef/install.sh | sudo bash"
end
EOF

vagrant up
vagrant halt
MACHINE_FOLDER=$(cat ".vagrant/machines/default/vmware_fusion/id" | sed -e 's/\/[^\/]*$//g')
rm -rf package
mkdir -p package
cp ${MACHINE_FOLDER}/*.vmdk ${MACHINE_FOLDER}/*.nvram ${MACHINE_FOLDER}/*.vmsd ${MACHINE_FOLDER}/*.vmx ${MACHINE_FOLDER}/*.vmxf ${MACHINE_FOLDER}/metadata.json package/.
cd package
/Applications/VMware\ Fusion.app/Contents/Library/vmware-vdiskmanager -d disk.vmdk
/Applications/VMware\ Fusion.app/Contents/Library/vmware-vdiskmanager -k disk.vmdk
tar cvzf package.box ./*
vagrant destroy -f
vagrant box add --name tnarik/solaris10-with-chef package.box